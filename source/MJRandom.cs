// Copyright (C) 2026 Kazys Kalabibishkis, The MIT License (MIT)

using System;

/// <summary>
/// Deterministic pseudo-random number generator used by MarkovJunior.
///
/// This intentionally mirrors the seeded System.Random compatibility algorithm
/// (modified Knuth subtractive generator), so it is small and easy to port 1:1
/// to other languages such as Odin.
/// </summary>
class MJRandom
{
    const int MBIG = int.MaxValue;
    const int MSEED = 161803398;

    readonly int[] seedArray = new int[56];
    int inext;
    int inextp;

    public MJRandom(int seed)
    {
        int subtraction = seed == int.MinValue ? int.MaxValue : Math.Abs(seed);
        int mj = MSEED - subtraction;
        seedArray[55] = mj;
        int mk = 1;

        int ii = 0;
        for (int i = 1; i < 55; i++)
        {
            ii += 21;
            if (ii >= 55) ii -= 55;

            seedArray[ii] = mk;
            mk = mj - mk;
            if (mk < 0) mk += MBIG;

            mj = seedArray[ii];
        }

        for (int k = 1; k < 5; k++)
        {
            for (int i = 1; i < 56; i++)
            {
                int n = i + 30;
                if (n >= 55) n -= 55;

                seedArray[i] -= seedArray[1 + n];
                if (seedArray[i] < 0) seedArray[i] += MBIG;
            }
        }

        inext = 0;
        inextp = 21;
    }

    public int Next()
    {
        int locINext = inext;
        if (++locINext >= 56) locINext = 1;

        int locINextp = inextp;
        if (++locINextp >= 56) locINextp = 1;

        int retVal = seedArray[locINext] - seedArray[locINextp];

        if (retVal == MBIG) retVal--;
        if (retVal < 0) retVal += MBIG;

        seedArray[locINext] = retVal;
        inext = locINext;
        inextp = locINextp;

        return retVal;
    }

    public int Next(int maxValue)
    {
        if (maxValue < 0) throw new ArgumentOutOfRangeException(nameof(maxValue));
        return (int)(Sample() * maxValue);
    }

    public double NextDouble() => Sample();

    double Sample() => Next() * (1.0 / int.MaxValue);
}
