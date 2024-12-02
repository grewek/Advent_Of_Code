package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

RecordOrder :: enum {
	Increasing,
	Decreasing,
}

main :: proc() {
	result, ok := os.read_entire_file("data.txt")

	if !ok {
		return
	}

	data := string(result)
	lines := strings.split_lines(data)

	part_a(lines)
}

part_a :: proc(lines: []string) {
	safe_record_count := 0

	for line in lines {
		if (line == "") {
			break
		}
		line_data := strings.split(line, " ")

		ascending_values := false
		descending_values := false

		fmt.println(line_data)
		if (strconv.atoi(line_data[0]) < strconv.atoi(line_data[1])) {
			if (analyse_record(line_data, RecordOrder.Increasing)) {
				safe_record_count += 1
			}
		} else {
			if (analyse_record(line_data, RecordOrder.Decreasing)) {
				safe_record_count += 1
			}
		}

	}

	fmt.printfln("The result for part a of day_02 is: %i", safe_record_count)
}

part_b :: proc(lines: []string) {
	safe_record_count := 0

	for line in lines {
		if (line == "") {
			break
		}
		line_data := strings.split(line, " ")

		ascending_values := false
		descending_values := false

		fmt.println(line_data)
		if (strconv.atoi(line_data[0]) < strconv.atoi(line_data[1])) {
			if (analyse_record(line_data, RecordOrder.Increasing)) {
				safe_record_count += 1
			}
		} else {
			if (analyse_record(line_data, RecordOrder.Decreasing)) {
				safe_record_count += 1
			}
		}

	}

	fmt.printfln("The result for part a of day_02 is: %i", safe_record_count)
}

analyse_record :: proc(line_values: []string, order: RecordOrder) -> bool {
	for i := 0; i < len(line_values); i += 1 {
		current_entry := 0
		next_entry := 0

		if (i + 1 >= len(line_values)) {
			current_entry = strconv.atoi(line_values[i - 1])
			next_entry = strconv.atoi(line_values[i])
		} else {
			current_entry = strconv.atoi(line_values[i])
			next_entry = strconv.atoi(line_values[i + 1])
		}

		if (order == RecordOrder.Increasing) {
			if (next_entry >= current_entry + 1 && next_entry <= current_entry + 3) {
				fmt.printfln("Increasing Value because %i <= %i", next_entry, current_entry)
			} else {
				return false
			}
		} else {
			if (order == RecordOrder.Decreasing &&
				   next_entry <= current_entry - 1 &&
				   next_entry >= current_entry - 3) {
				fmt.printfln("Descending Value because %i >= %i", next_entry, current_entry)
			} else {
				return false
			}
		}
	}

	return true
}
