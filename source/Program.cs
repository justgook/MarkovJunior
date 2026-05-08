// Copyright (C) 2022 Maxim Gumin, The MIT License (MIT)

using System;
using System.Linq;
using System.Xml.Linq;
using System.Diagnostics;
using System.Collections.Generic;

static class Program
{
    static void Main(string[] args)
    {
        string modelFilter = null;
        bool forceGif = false;
        int? forceGui = null;
        int? forceAmount = null;
        int? forceSteps = null;
        string outputFolder = "output";

        foreach (string arg in args)
        {
            if (arg == "--gif") forceGif = true;
            else if (arg.StartsWith("--gui=")) forceGui = int.Parse(arg[6..]);
            else if (arg.StartsWith("--amount=")) forceAmount = int.Parse(arg[9..]);
            else if (arg.StartsWith("--steps=")) forceSteps = int.Parse(arg[8..]);
            else if (arg.StartsWith("--output=")) outputFolder = arg[9..];
            else if (modelFilter == null) modelFilter = arg;
            else throw new ArgumentException($"unknown argument: {arg}");
        }

        Stopwatch sw = Stopwatch.StartNew();
        var folder = System.IO.Directory.CreateDirectory(outputFolder);
        foreach (var file in folder.GetFiles()) file.Delete();

        Dictionary<char, int> palette = XDocument.Load("resources/palette.xml").Root.Elements("color").ToDictionary(x => x.Get<char>("symbol"), x => (255 << 24) + Convert.ToInt32(x.Get<string>("value"), 16));

        MJRandom meta = new(0);
        XDocument xdoc = XDocument.Load("models.xml", LoadOptions.SetLineInfo);
        foreach (XElement xmodel in xdoc.Root.Elements("model"))
        {
            string name = xmodel.Get<string>("name");
            if (modelFilter != null && name != modelFilter) continue;
            int linearSize = xmodel.Get("size", -1);
            int dimension = xmodel.Get("d", 2);
            int MX = xmodel.Get("length", linearSize);
            int MY = xmodel.Get("width", linearSize);
            int MZ = xmodel.Get("height", dimension == 2 ? 1 : linearSize);

            Console.Write($"{name} > ");
            string filename = $"models/{name}.xml";
            XDocument modeldoc;
            try { modeldoc = XDocument.Load(filename, LoadOptions.SetLineInfo); }
            catch (Exception)
            {
                Console.WriteLine($"ERROR: couldn't open xml file {filename}");
                continue;
            }

            Interpreter interpreter = Interpreter.Load(modeldoc.Root, MX, MY, MZ);
            if (interpreter == null)
            {
                Console.WriteLine("ERROR");
                continue;
            }

            int amount = forceAmount ?? xmodel.Get("amount", 2);
            int pixelsize = xmodel.Get("pixelsize", 4);
            string seedString = xmodel.Get<string>("seeds", null);
            int[] seeds = seedString?.Split(' ').Select(s => int.Parse(s)).ToArray();
            bool gif = forceGif || xmodel.Get("gif", false);
            bool iso = xmodel.Get("iso", false);
            int steps = forceSteps ?? xmodel.Get("steps", gif ? 1000 : 50000);
            int gui = forceGui ?? xmodel.Get("gui", 0);
            if (gif) amount = 1;

            Dictionary<char, int> customPalette = new(palette);
            foreach (var x in xmodel.Elements("color")) customPalette[x.Get<char>("symbol")] = (255 << 24) + Convert.ToInt32(x.Get<string>("value"), 16);

            for (int k = 0; k < amount; k++)
            {
                int seed = seeds != null && k < seeds.Length ? seeds[k] : meta.Next();
                foreach ((byte[] result, char[] legend, int FX, int FY, int FZ) in interpreter.Run(seed, steps, gif))
                {
                    int[] colors = legend.Select(ch => customPalette[ch]).ToArray();
                    string outputname = gif ? $"{outputFolder}/{interpreter.counter}" : $"{outputFolder}/{name}_{seed}";
                    if (FZ == 1 || iso)
                    {
                        var (bitmap, WIDTH, HEIGHT) = Graphics.Render(result, FX, FY, FZ, colors, pixelsize, gui);
                        if (gui > 0) GUI.Draw(name, interpreter.root, interpreter.current, bitmap, WIDTH, HEIGHT, customPalette);
                        Graphics.SaveBitmap(bitmap, WIDTH, HEIGHT, outputname + ".png");
                    }
                    else VoxHelper.SaveVox(result, (byte)FX, (byte)FY, (byte)FZ, colors, outputname + ".vox");
                }
                Console.WriteLine("DONE");
            }
        }
        Console.WriteLine($"time = {sw.ElapsedMilliseconds}");
    }
}
