package main

import "core:fmt"
import "core:os"
import "core:strings"

run_basic :: proc(amount := 1, output_folder := "output", format := "text") {
	_ = os.make_directory(output_folder)

	meta := mj_random_init(0)
	for k in 0..<amount {
		seed := mj_random_next(&meta)
		state := generate_basic(seed, 1000, 60, 60)
		defer delete(state)

		if format == "text" {
			write_state_text(fmt.tprintf("%s/Basic_%d.txt", output_folder, seed), state, 60, 60, 1, "BW")
		}
		fmt.println("Basic > DONE")
	}
}

generate_basic :: proc(seed: i32, steps: int, width: int, height: int) -> []u8 {
	state := make([]u8, width * height)
	matches := make([]int, width * height)
	for i in 0..<len(matches) {
		matches[i] = i
	}

	random := mj_random_init(seed)
	match_count := len(matches)
	for step in 0..<steps {
		if match_count <= 0 {
			break
		}

		match_index := int(mj_random_next_max(&random, i32(match_count)))
		cell := matches[match_index]
		matches[match_index] = matches[match_count - 1]
		match_count -= 1
		state[cell] = 1
	}

	delete(matches)
	return state
}

write_state_text :: proc(path: string, state: []u8, mx: int, my: int, mz: int, legend: string) {
	builder: strings.Builder
	strings.builder_init(&builder)
	defer strings.builder_destroy(&builder)

	fmt.sbprintf(&builder, "MJSTATE 1\n")
	fmt.sbprintf(&builder, "size %d %d %d\n", mx, my, mz)
	fmt.sbprintf(&builder, "legend %s\n", legend)

	for z in 0..<mz {
		if mz > 1 {
			fmt.sbprintf(&builder, "z %d\n", z)
		}
		for y in 0..<my {
			for x in 0..<mx {
				idx := x + y * mx + z * mx * my
				fmt.sbprintf(&builder, "%c", legend[state[idx]])
			}
			fmt.sbprintf(&builder, "\n")
		}
	}

	_ = os.write_entire_file_from_string(path, strings.to_string(builder))
}
