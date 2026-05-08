package main

import "core:strings"

Shift :: struct {
	x, y, z: int,
}

Rule :: struct {
	imx, imy, imz: int,
	omx, omy, omz: int,
	input:         []i32,
	output:        []u8,
	ishifts:       [][]Shift,
	p:             f64,
}

Pattern :: struct {
	data: []u8,
	mx, my, mz: int,
}

rule_destroy :: proc(r: ^Rule) {
	if r.input != nil do delete(r.input)
	if r.output != nil do delete(r.output)
	for i in 0..<len(r.ishifts) {
		if r.ishifts[i] != nil do delete(r.ishifts[i])
	}
	if r.ishifts != nil do delete(r.ishifts)
}

parse_pattern :: proc(s: string) -> Pattern {
	layers := strings.split(s, " ")
	defer delete(layers)
	rows0 := strings.split(layers[0], "/")
	mx := len(rows0[0])
	my := len(rows0)
	delete(rows0)
	mz := len(layers)

	p := Pattern{data = make([]u8, mx * my * mz), mx = mx, my = my, mz = mz}
	for z in 0..<mz {
		layer := layers[mz - 1 - z]
		rows := strings.split(layer, "/")
		for y in 0..<my {
			row := rows[y]
			for x in 0..<mx {
				p.data[x + y * mx + z * mx * my] = row[x]
			}
		}
		delete(rows)
	}
	return p
}

pattern_destroy :: proc(p: ^Pattern) {
	if p.data != nil do delete(p.data)
}

rule_init :: proc(g: ^Grid, in_string, out_string: string, probability := 1.0) -> Rule {
	pin := parse_pattern(in_string)
	defer pattern_destroy(&pin)
	pout := parse_pattern(out_string)
	defer pattern_destroy(&pout)

	input := make([]i32, len(pin.data))
	output := make([]u8, len(pout.data))

	for i in 0..<len(pin.data) {
		input[i] = grid_wave(g, pin.data[i])
	}
	for i in 0..<len(pout.data) {
		ch := pout.data[i]
		if ch == '*' {
			output[i] = 0xff
		} else {
			output[i] = grid_value(g, ch)
		}
	}

	return rule_from_arrays(g, input, pin.mx, pin.my, pin.mz, output, pout.mx, pout.my, pout.mz, probability)
}

rule_from_arrays :: proc(g: ^Grid, input: []i32, imx, imy, imz: int, output: []u8, omx, omy, omz: int, probability := 1.0) -> Rule {
	r := Rule{
		imx = imx, imy = imy, imz = imz,
		omx = omx, omy = omy, omz = omz,
		input = input,
		output = output,
		ishifts = make([][]Shift, len(g.characters)),
		p = probability,
	}

	for c in 0..<len(g.characters) {
		list := make([dynamic]Shift)
		for z in 0..<r.imz {
			for y in 0..<r.imy {
				for x in 0..<r.imx {
					i := x + y * r.imx + z * r.imx * r.imy
					w := r.input[i]
					if (w & (i32(1) << uint(c))) != 0 {
						append(&list, Shift{x, y, z})
					}
				}
			}
		}
		r.ishifts[c] = make([]Shift, len(list))
		copy(r.ishifts[c], list[:])
		delete(list)
	}
	return r
}

rule_clone :: proc(g: ^Grid, r: ^Rule) -> Rule {
	input := make([]i32, len(r.input))
	copy(input, r.input)
	output := make([]u8, len(r.output))
	copy(output, r.output)
	return rule_from_arrays(g, input, r.imx, r.imy, r.imz, output, r.omx, r.omy, r.omz, r.p)
}

rule_z_rotated :: proc(g: ^Grid, r: ^Rule) -> Rule {
	input := make([]i32, len(r.input))
	for z in 0..<r.imz {
		for y in 0..<r.imx {
			for x in 0..<r.imy {
				input[x + y * r.imy + z * r.imx * r.imy] = r.input[r.imx - 1 - y + x * r.imx + z * r.imx * r.imy]
			}
		}
	}

	output := make([]u8, len(r.output))
	for z in 0..<r.omz {
		for y in 0..<r.omx {
			for x in 0..<r.omy {
				output[x + y * r.omy + z * r.omx * r.omy] = r.output[r.omx - 1 - y + x * r.omx + z * r.omx * r.omy]
			}
		}
	}

	return rule_from_arrays(g, input, r.imy, r.imx, r.imz, output, r.omy, r.omx, r.omz, r.p)
}

rule_y_rotated :: proc(g: ^Grid, r: ^Rule) -> Rule {
	input := make([]i32, len(r.input))
	for z in 0..<r.imx {
		for y in 0..<r.imy {
			for x in 0..<r.imz {
				input[x + y * r.imz + z * r.imz * r.imy] = r.input[r.imx - 1 - z + y * r.imx + x * r.imx * r.imy]
			}
		}
	}

	output := make([]u8, len(r.output))
	for z in 0..<r.omx {
		for y in 0..<r.omy {
			for x in 0..<r.omz {
				output[x + y * r.omz + z * r.omz * r.omy] = r.output[r.omx - 1 - z + y * r.omx + x * r.omx * r.omy]
			}
		}
	}

	return rule_from_arrays(g, input, r.imz, r.imy, r.imx, output, r.omz, r.omy, r.omx, r.p)
}

rule_reflected :: proc(g: ^Grid, r: ^Rule) -> Rule {
	input := make([]i32, len(r.input))
	for z in 0..<r.imz {
		for y in 0..<r.imy {
			for x in 0..<r.imx {
				input[x + y * r.imx + z * r.imx * r.imy] = r.input[r.imx - 1 - x + y * r.imx + z * r.imx * r.imy]
			}
		}
	}

	output := make([]u8, len(r.output))
	for z in 0..<r.omz {
		for y in 0..<r.omy {
			for x in 0..<r.omx {
				output[x + y * r.omx + z * r.omx * r.omy] = r.output[r.omx - 1 - x + y * r.omx + z * r.omx * r.omy]
			}
		}
	}

	return rule_from_arrays(g, input, r.imx, r.imy, r.imz, output, r.omx, r.omy, r.omz, r.p)
}

rule_same :: proc(a, b: ^Rule) -> bool {
	if a.imx != b.imx || a.imy != b.imy || a.imz != b.imz || a.omx != b.omx || a.omy != b.omy || a.omz != b.omz do return false
	for i in 0..<len(a.input) {
		if a.input[i] != b.input[i] do return false
	}
	for i in 0..<len(a.output) {
		if a.output[i] != b.output[i] do return false
	}
	return true
}

append_rule_symmetries :: proc(g: ^Grid, rules: ^[dynamic]Rule, base: Rule, symmetry := "") {
	if g.mz == 1 {
		append_square_symmetries(g, rules, base, symmetry)
	} else {
		append_cube_symmetries(g, rules, base)
	}
}

square_symmetry_enabled :: proc(symmetry: string, i: int) -> bool {
	if symmetry == "" || symmetry == "(xy)" do return true
	if symmetry == "()" do return i == 0
	if symmetry == "(x)" do return i == 0 || i == 1
	if symmetry == "(y)" do return i == 0 || i == 5
	if symmetry == "(x)(y)" do return i == 0 || i == 1 || i == 4 || i == 5
	if symmetry == "(xy+)" do return i == 0 || i == 2 || i == 4 || i == 6
	return true
}

append_square_symmetries :: proc(g: ^Grid, rules: ^[dynamic]Rule, base: Rule, symmetry := "") {
	things: [8]Rule
	things[0] = base
	things[1] = rule_reflected(g, &things[0])
	things[2] = rule_z_rotated(g, &things[0])
	things[3] = rule_reflected(g, &things[2])
	things[4] = rule_z_rotated(g, &things[2])
	things[5] = rule_reflected(g, &things[4])
	things[6] = rule_z_rotated(g, &things[4])
	things[7] = rule_reflected(g, &things[6])

	used: [8]bool
	for i in 0..<8 {
		if !square_symmetry_enabled(symmetry, i) {
			rule_destroy(&things[i])
			continue
		}
		duplicate := false
		for j in 0..<i {
			if used[j] && rule_same(&things[j], &things[i]) {
				duplicate = true
				break
			}
		}
		if duplicate {
			rule_destroy(&things[i])
		} else {
			used[i] = true
			append(rules, things[i])
		}
	}
}

append_cube_symmetries :: proc(g: ^Grid, rules: ^[dynamic]Rule, base: Rule) {
	s: [48]Rule
	s[0] = base
	s[1] = rule_reflected(g, &s[0])
	s[2] = rule_z_rotated(g, &s[0])
	s[3] = rule_reflected(g, &s[2])
	s[4] = rule_z_rotated(g, &s[2])
	s[5] = rule_reflected(g, &s[4])
	s[6] = rule_z_rotated(g, &s[4])
	s[7] = rule_reflected(g, &s[6])
	s[8] = rule_y_rotated(g, &s[0])
	s[9] = rule_reflected(g, &s[8])
	s[10] = rule_y_rotated(g, &s[2])
	s[11] = rule_reflected(g, &s[10])
	s[12] = rule_y_rotated(g, &s[4])
	s[13] = rule_reflected(g, &s[12])
	s[14] = rule_y_rotated(g, &s[6])
	s[15] = rule_reflected(g, &s[14])
	s[16] = rule_y_rotated(g, &s[8])
	s[17] = rule_reflected(g, &s[16])
	s[18] = rule_y_rotated(g, &s[10])
	s[19] = rule_reflected(g, &s[18])
	s[20] = rule_y_rotated(g, &s[12])
	s[21] = rule_reflected(g, &s[20])
	s[22] = rule_y_rotated(g, &s[14])
	s[23] = rule_reflected(g, &s[22])
	s[24] = rule_y_rotated(g, &s[16])
	s[25] = rule_reflected(g, &s[24])
	s[26] = rule_y_rotated(g, &s[18])
	s[27] = rule_reflected(g, &s[26])
	s[28] = rule_y_rotated(g, &s[20])
	s[29] = rule_reflected(g, &s[28])
	s[30] = rule_y_rotated(g, &s[22])
	s[31] = rule_reflected(g, &s[30])
	s[32] = rule_z_rotated(g, &s[8])
	s[33] = rule_reflected(g, &s[32])
	s[34] = rule_z_rotated(g, &s[10])
	s[35] = rule_reflected(g, &s[34])
	s[36] = rule_z_rotated(g, &s[12])
	s[37] = rule_reflected(g, &s[36])
	s[38] = rule_z_rotated(g, &s[14])
	s[39] = rule_reflected(g, &s[38])
	s[40] = rule_z_rotated(g, &s[24])
	s[41] = rule_reflected(g, &s[40])
	s[42] = rule_z_rotated(g, &s[26])
	s[43] = rule_reflected(g, &s[42])
	s[44] = rule_z_rotated(g, &s[28])
	s[45] = rule_reflected(g, &s[44])
	s[46] = rule_z_rotated(g, &s[30])
	s[47] = rule_reflected(g, &s[46])

	used: [48]bool
	for i in 0..<48 {
		duplicate := false
		for j in 0..<i {
			if used[j] && rule_same(&s[j], &s[i]) {
				duplicate = true
				break
			}
		}
		if duplicate {
			rule_destroy(&s[i])
		} else {
			used[i] = true
			append(rules, s[i])
		}
	}
}
