package envoy.authz

import input.attributes.request.http as http_request

# default allow = false
# default http_status = 401

# https://www.openpolicyagent.org/docs/edge/envoy-primer/

# No cookie, set cookie and redirect to itself
allow = response {
  not http_request.headers.cookie

  session_id := uuid.rfc4122("")  # generate new session_id
  
  response := {
    "allowed": false,
    "http_status": 301,
    # "response_headers_to_add": {
    "headers": {
       "Set-Cookie": concat("", ["api-gateway=", session_id]),
       "Location": "/"
    }
  }
}

# cookie is set but for other apps, set cookie and redirect to itself
allow = response {
  cookies := extract_cookies(http_request.headers.cookie)
  not cookies["api-gateway"]

  session_id := uuid.rfc4122("")  # generate new session_id
  
  response := {
    "allowed": false,
    "http_status": 301,
    # "response_headers_to_add": {
    "headers": {
       "Set-Cookie": concat("", ["api-gateway=", session_id]),
       "Location": "/"
    }
  }
}

# No cookie, set cookie and redirect to itself
allow = response {
  cookies := extract_cookies(http_request.headers.cookie)
  cookies["api-gateway"]

  session_id := cookies["api-gateway"]

  response := {
    "allowed": true,
    "headers": {
      "x-current-user": "OPA",
      "x-session_id": session_id
    }
  }
}

### utility functions
extract_cookies(cookies) = { 
	key: value |
    	cookie := trim(split(cookies,";")[_], " ");
        [key, value] := split(cookie, "=")
}

