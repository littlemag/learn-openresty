local args = ngx.req.get_uri_args()
local redis = require "resty.redis"


local redis_conn = {}

function redis_conn.connect(...)
    local red = redis:new()
	red:set_timeout(1000)
	local ok, err = red:connect("127.0.0.1", 6379)

	if not ok then
	    ngx.say("failed to connect: ", err)
	    return
	end
	return red
end

return redis_conn
