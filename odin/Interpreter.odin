package main

import xml "core:encoding/xml"
import "core:fmt"
import "core:strconv"

Model_Config :: struct {
	name:   string,
	mx:     int,
	my:     int,
	mz:     int,
	steps:  int,
}

xml_attr :: proc(doc: ^xml.Document, id: xml.Element_ID, key: string, default: string = "") -> string {
	if value, ok := xml.find_attribute_val_by_key(doc, id, key); ok {
		return value
	}
	return default
}

xml_attr_bool :: proc(doc: ^xml.Document, id: xml.Element_ID, key: string, default := false) -> bool {
	value := xml_attr(doc, id, key, "")
	if value == "" do return default
	return value == "True" || value == "true"
}

xml_attr_int :: proc(doc: ^xml.Document, id: xml.Element_ID, key: string, default: int) -> int {
	value := xml_attr(doc, id, key, "")
	if value == "" do return default
	if parsed, ok := strconv.parse_int(value); ok {
		return int(parsed)
	}
	return default
}

xml_attr_f64 :: proc(doc: ^xml.Document, id: xml.Element_ID, key: string, default: f64) -> f64 {
	value := xml_attr(doc, id, key, "")
	if value == "" do return default
	if parsed, ok := strconv.parse_f64(value); ok {
		return parsed
	}
	return default
}

load_model_config :: proc(name: string, model_index := -1) -> (Model_Config, bool) {
	doc, err := xml.load_from_file("models.xml")
	if err != .None || doc == nil {
		return {}, false
	}
	defer xml.destroy(doc)

	matching_index := 0
	for id in 0..<len(doc.elements) {
		e := doc.elements[id]
		if e.ident != "model" do continue
		if xml_attr(doc, xml.Element_ID(id), "name") != name do continue
		if model_index >= 0 && matching_index != model_index {
			matching_index += 1
			continue
		}
		matching_index += 1

		linear_size := xml_attr_int(doc, xml.Element_ID(id), "size", -1)
		dimension := xml_attr_int(doc, xml.Element_ID(id), "d", 2)
		mx := xml_attr_int(doc, xml.Element_ID(id), "length", linear_size)
		my := xml_attr_int(doc, xml.Element_ID(id), "width", linear_size)
		default_mz := linear_size
		if dimension == 2 {
			default_mz = 1
		}
		mz := xml_attr_int(doc, xml.Element_ID(id), "height", default_mz)
		steps := xml_attr_int(doc, xml.Element_ID(id), "steps", 50000)
		return Model_Config{name = name, mx = mx, my = my, mz = mz, steps = steps}, true
	}

	return {}, false
}

run_xml_one_model :: proc(model_name: string, amount: int, output_folder: string, format: string, force_steps := -1, model_index := -1) -> bool {
	config, ok := load_model_config(model_name, model_index)
	if !ok {
		fmt.printf("unknown model %s\n", model_name)
		return false
	}

	if force_steps >= 0 {
		config.steps = force_steps
	}

	path := fmt.tprintf("models/%s.xml", model_name)
	doc, err := xml.load_from_file(path)
	if err != .None || doc == nil {
		fmt.printf("could not load %s\n", path)
		return false
	}
	defer xml.destroy(doc)

	root := xml.Element_ID(0)
	root_kind := doc.elements[root].ident
	if root_kind != "one" && root_kind != "all" && root_kind != "prl" && root_kind != "sequence" {
		return false
	}

	values := xml_attr(doc, root, "values")
	origin := xml_attr_bool(doc, root, "origin")

	meta := mj_random_init(0)
	for k in 0..<amount {
		seed := mj_random_next(&meta)
		random := mj_random_init(seed)
		g := grid_init(config.mx, config.my, config.mz, values, origin)
		load_unions(doc, root, &g)
		run_xml_element(doc, root, &g, &random, config.steps)
		if format == "text" {
			write_state_text(fmt.tprintf("%s/%s_%d.txt", output_folder, model_name, seed), g.state, g.mx, g.my, g.mz, g.characters)
		}
		grid_destroy(&g)
		fmt.printf("%s > DONE\n", model_name)
	}
	return true
}

load_unions :: proc(doc: ^xml.Document, id: xml.Element_ID, g: ^Grid) {
	for value in doc.elements[id].value {
		#partial switch child_id in value {
		case xml.Element_ID:
			kind := doc.elements[child_id].ident
			if kind == "union" {
				symbol := xml_attr(doc, child_id, "symbol", "")
				values := xml_attr(doc, child_id, "values", "")
				if len(symbol) > 0 && len(values) > 0 {
					grid_add_union(g, symbol[0], values)
				}
			} else {
				load_unions(doc, child_id, g)
			}
		}
	}
}

run_xml_element :: proc(doc: ^xml.Document, id: xml.Element_ID, g: ^Grid, random: ^MJRandom, default_steps: int) -> bool {
	kind := doc.elements[id].ident
	if kind == "sequence" {
		for value in doc.elements[id].value {
			#partial switch child_id in value {
			case xml.Element_ID:
				child_kind := doc.elements[child_id].ident
				if child_kind == "union" {
					continue
				}
				if child_kind == "one" || child_kind == "all" || child_kind == "prl" || child_kind == "sequence" {
					run_xml_element(doc, child_id, g, random, default_steps)
				}
			}
		}
		return true
	}

	if kind != "one" && kind != "all" && kind != "prl" {
		return false
	}

	rules_dyn := make([dynamic]Rule)
	defer {
		for i in 0..<len(rules_dyn) {
			rule_destroy(&rules_dyn[i])
		}
		delete(rules_dyn)
	}
	load_rules_for_element(doc, id, g, &rules_dyn)

	steps := xml_attr_int(doc, id, "steps", 0)
	if steps == 0 && id == 0 {
		steps = default_steps
	}

	if kind == "one" {
		run_one_node(g, rules_dyn[:], random, steps)
	} else if kind == "all" {
		run_all_node(g, rules_dyn[:], random, steps)
	} else {
		run_parallel_node(g, rules_dyn[:], random, steps)
	}
	return true
}

load_rules_for_element :: proc(doc: ^xml.Document, id: xml.Element_ID, g: ^Grid, rules: ^[dynamic]Rule) {
	in_root := xml_attr(doc, id, "in", "")
	out_root := xml_attr(doc, id, "out", "")
	if in_root != "" && out_root != "" {
		append_rule_symmetries(g, rules, rule_init(g, in_root, out_root, xml_attr_f64(doc, id, "p", 1.0)), xml_attr(doc, id, "symmetry", ""))
		return
	}

	for value in doc.elements[id].value {
		#partial switch child_id in value {
		case xml.Element_ID:
			if doc.elements[child_id].ident == "rule" {
				symmetry := xml_attr(doc, child_id, "symmetry", xml_attr(doc, id, "symmetry", ""))
				append_rule_symmetries(g, rules, rule_init(g, xml_attr(doc, child_id, "in"), xml_attr(doc, child_id, "out"), xml_attr_f64(doc, child_id, "p", 1.0)), symmetry)
			}
		}
	}
}
