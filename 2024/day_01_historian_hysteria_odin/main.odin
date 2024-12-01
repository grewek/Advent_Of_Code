package main

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

main :: proc() {
	example_data, ok := os.read_entire_file("input_data.txt", context.allocator)
	list_a: [dynamic]int
	list_b: [dynamic]int

	if !ok {
		return
	}
	defer delete(example_data, context.allocator)

	it := string(example_data)

	for line in strings.split_lines_iterator(&it) {
		if line == "" {
			break
		}
		values := strings.split(line, "   ")

		for i := 0; i < len(values); i += 2 {
			fmt.printfln("%s", values)
			value_a := strconv.atoi(values[i])
			value_b := strconv.atoi(values[i + 1])
			append(&list_a, value_a)
			append(&list_b, value_b)
		}
	}

	slice.sort(list_a[:])
	slice.sort(list_b[:])

	accumulator := 0
	for i := 0; i < len(list_a); i += 1 {
		value_a := list_a[i]
		value_b := list_b[i]

		distance := max(value_a, value_b) - min(value_a, value_b)
		fmt.printfln("%i - %i = %i", max(value_a, value_b), min(value_a, value_b), distance)
		accumulator += distance
	}

	fmt.printfln("The searched result is: %i", accumulator)
}
