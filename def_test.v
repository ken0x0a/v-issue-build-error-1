module issue

fn test_decode2_method_spec() ? {
	json_text := '{
  "api": {
    "status": {
      "resp": {
        "status": {
          "type": "string",
          "comment": "Status: MAINTENANCE OPEN"
        }
      }
    }
  }
}'

	res := deser_json_map_map<MethodSpec>(json_text) or {
		eprintln('deser_json_map_map')
		panic(err)
	}
	assert res['api']['status'].resp == map{}
}
