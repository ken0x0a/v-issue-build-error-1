module issue

import x.json2

[inline]
fn macro_deser_json<T>(src json2.Any) ?T {
	mut typ := T{}
	typ.decode_json(src) ?
	return typ
}

[inline]
fn macro_deser_json_map<T>(src map[string]json2.Any) ?map[string]T {
	mut res := map[string]T{}
	for key, val in src {
		res[key] = macro_deser_json<T>(val) ?
	}
	return res
}

[inline]
fn macro_deser_json_array<T>(src []json2.Any) ?[]T {
	return src.map(macro_deser_json<T>(it) ?)
}

pub fn (mut self MethodSpec) decode_json(j json2.Any) ? {
	obj := j.as_map()
	self.resp = macro_deser_json_map<RespSpec>(obj['resp'].as_map()) ?
}

pub fn (mut self RespSpec) decode_json(j json2.Any) ? {
	obj := j.as_map()
	self.typ = value_type_decode_json(obj['type'] or { 0 }) ?
	self.comment = obj['comment'] or { 0 }.str()
	self.example = obj['example'] or { 0 }.str()
	self.nullable = obj['nullable'] or { 0 }.bool()
}
