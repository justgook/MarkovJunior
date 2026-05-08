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

load_model_config :: proc(name: string) -> (Model_Config, bool) {
	doc, err := xml.load_from_file("models.xml")
	if err != .None || doc == nil {
		return {}, false
	}
	defer xml.destroy(doc)

	for id in 0..<len(doc.elements) {
		e := doc.elements[id]
		if e.ident != "model" do continue
		if xml_attr(doc, xml.Element_ID(id), "name") != name do continue

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

run_xml_one_model :: proc(model_name: string, amount: int, output_folder: string, format: string, force_steps := -1) -> bool {
	config, ok := load_model_config(model_name)
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
	if doc.elements[root].ident != "one" {
		return false
	}

	values := xml_attr(doc, root, "values")
	origin := xml_attr_bool(doc, root, "origin")

	rules_dyn := make([dynamic]Rule)
	defer {
		for i in 0..<len(rules_dyn) {
			rule_destroy(&rules_dyn[i])
		}
		delete(rules_dyn)
	}

	g_for_rules := grid_init(config.mx, config.my, config.mz, values, false)
	defer grid_destroy(&g_for_rules)

	// Either a single rule on the <one> element, or child <rule> elements.
	in_root := xml_attr(doc, root, "in", "")
	out_root := xml_attr(doc, root, "out", "")
	if in_root != "" && out_root != "" {
		append_square_symmetries(&g_for_rules, &rules_dyn, rule_init(&g_for_rules, in_root, out_root))
	} else {
		for value in doc.elements[root].value {
			#partial switch child_id in value {
			case xml.Element_ID:
				if doc.elements[child_id].ident == "rule" {
					append_square_symmetries(&g_for_rules, &rules_dyn, rule_init(&g_for_rules, xml_attr(doc, child_id, "in"), xml_attr(doc, child_id, "out")))
				}
			}
		}
	}

	meta := mj_random_init(0)
	for k in 0..<amount {
		seed := mj_random_next(&meta)
		g := grid_init(config.mx, config.my, config.mz, values, origin)
		run_one_node(&g, rules_dyn[:], seed, config.steps)
		if format == "text" {
			write_state_text(fmt.tprintf("%s/%s_%d.txt", output_folder, model_name, seed), g.state, g.mx, g.my, g.mz, g.characters)
		}
		grid_destroy(&g)
		fmt.printf("%s > DONE\n", model_name)
	}
	return true
}
