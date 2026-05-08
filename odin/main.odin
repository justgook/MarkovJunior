package main

import "core:fmt"

main :: proc() {
	fmt.println("MarkovJunior Odin bootstrap")
	fmt.println("Deterministic MJRandom test vector:")

	r := mj_random_init(42)
	fmt.printf("seed 42 Next: %d %d %d %d %d\n", mj_random_next(&r), mj_random_next(&r), mj_random_next(&r), mj_random_next(&r), mj_random_next(&r))

	r = mj_random_init(42)
	fmt.printf("seed 42 Next(10): %d %d %d %d %d\n", mj_random_next_max(&r, 10), mj_random_next_max(&r, 10), mj_random_next_max(&r, 10), mj_random_next_max(&r, 10), mj_random_next_max(&r, 10))

	r = mj_random_init(42)
	fmt.printf("seed 42 Double: %.17g %.17g %.17g\n", mj_random_next_f64(&r), mj_random_next_f64(&r), mj_random_next_f64(&r))
}
