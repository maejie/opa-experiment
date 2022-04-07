package envoy.authz

test_not_allowed_without_cookie {
    not allow with input.attributes.request.http as {
        "method": "GET",
	    "path": [""] 
    }
}

test_allowed_with_cookie {
    allow with input.attributes.request.http as {
        "method": "GET",
	    "path": [""], 
        "headers": {
            "cookie": "api-gateway=12345"
        }
    }
}