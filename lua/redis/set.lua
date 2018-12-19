local args = ngx.req.get_uri_args()
local redis= require "resty.redis"
local cjson = require "cjson"

key = args.key
value = args.value
local red = redis:new()
red:set_timeout(1000)
local res, err = red:connect("127.0.0.1", 6379)
if not res then
    ngx.say("failed to connect "..key, err)
    return
end
local set,err = red:set(key, value)
if not set then
	ngx.say("failed to set")
	return
end

param = red:get(key)
array = {}
array[key] = param
ngx.say(cjson.encode(array))