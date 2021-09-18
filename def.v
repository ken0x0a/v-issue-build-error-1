module issue

import x.json2

[deser_json_with: value_type_decode_json]
enum ValueType {
	null
	array
	string_
	bool_
	f64_
	i64_
	u64_
}

pub fn value_type_decode_json(j json2.Any) ?ValueType {
	json_str := j.json_str()
	if json_str.starts_with('"') {
		str := j.str()
		match str {
			'null' {
				return .null
			}
			'array' {
				return .array
			}
			'string' {
				return .string_
			}
			'bool' {
				return .bool_
			}
			'f64' {
				return .f64_
			}
			'i64' {
				return .i64_
			}
			'u64' {
				return .u64_
			}
			else {
				return error('unexpected ValueType `$str`')
			}
		}
	} else {
		return .null
	}
}

[derive: Deser_json]
struct MethodSpec {
mut:
	resp map[string]RespSpec
}

[derive: Deser_json]
struct RespSpec {
mut:
	typ      ValueType [json: @type]
	comment  string
	example  string // ?
	nullable bool   // ?
}
