package main

Grid :: struct {
	state:      []u8,
	mx:         int,
	my:         int,
	mz:         int,
	characters: string,
}

grid_init :: proc(mx, my, mz: int, values: string, origin: bool) -> Grid {
	g := Grid {
		state = make([]u8, mx * my * mz),
		mx = mx,
		my = my,
		mz = mz,
		characters = values,
	}
	if origin {
		idx := mx / 2 + (my / 2) * mx + (mz / 2) * mx * my
		g.state[idx] = 1
	}
	return g
}

grid_destroy :: proc(g: ^Grid) {
	if g.state != nil {
		delete(g.state)
	}
}

grid_value :: proc(g: ^Grid, ch: u8) -> u8 {
	for i in 0..<len(g.characters) {
		if g.characters[i] == ch {
			return u8(i)
		}
	}
	return 0xff
}

grid_wave :: proc(g: ^Grid, ch: u8) -> i32 {
	if ch == '*' {
		return (i32(1) << uint(len(g.characters))) - 1
	}
	value := grid_value(g, ch)
	return i32(1) << uint(value)
}

grid_matches :: proc(g: ^Grid, rule: ^Rule, x, y, z: int) -> bool {
	for dz in 0..<rule.imz {
		for dy in 0..<rule.imy {
			for dx in 0..<rule.imx {
				pi := dx + dy * rule.imx + dz * rule.imx * rule.imy
				si := (x + dx) + (y + dy) * g.mx + (z + dz) * g.mx * g.my
				value := g.state[si]
				if (rule.input[pi] & (i32(1) << uint(value))) == 0 {
					return false
				}
			}
		}
	}
	return true
}
