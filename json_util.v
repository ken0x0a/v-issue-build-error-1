module issue

import x.json2

fn decode_json<T>(src string) ?T {
	res := json2.raw_decode(src) ?
	return macro_deser_json<T>(res)
}

fn deser_json_map<T>(src string) ?map[string]T {
	decoded := json2.raw_decode(src) ?

	mut res := map[string]T{}
	for key, val in decoded.as_map() {
		res[key] = macro_deser_json<T>(val) ?
	}
	return res
}

fn deser_json_map_map<T>(src string) ?map[string]map[string]T {
	decoded := json2.raw_decode(src) ?

	mut res := map[string]map[string]T{}
	for key, val in decoded.as_map() {
		res[key] = macro_deser_json_map<T>(val.as_map()) ?
	}
	return res
}

