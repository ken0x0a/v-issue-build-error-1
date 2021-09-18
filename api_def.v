module issue

pub fn parse(json_string string) map[string]map[string]MethodSpec {
	res := deser_json_map_map<MethodSpec>(json_string) or {
		eprintln('deser_json_map_map')
		panic(err)
	}
	return res
}
