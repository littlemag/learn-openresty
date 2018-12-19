local config = require "config.config"
local redis= require "resty.redis"
local cjson = require "cjson"

local red = redis:new()
red:set_timeout(1000)
local res, err = red:connect(config.redis_ip,config.redis_port)
if not res then
    ngx.say("failed to connect: ", err)
    return false
end


function get_content(key,value)
	param = red:get(key)
	array = {}
	array[key] = param
	return cjson.encode(array)
end

function set_content(key,value)
	local set,err = red:set(key, value)
	if not set then
		ngx.say("failed to set")
		return false
	end
	ngx.say('set success')
	param = red:get(key)
	array = {}
	array[key] = param
	ngx.say(cjson.encode(array))
end

local args = ngx.req.get_uri_args()
local key = args.key
local value = args.value
local str = ngx.var.path
local action = string.sub(str,string.len('redis')+2,string.len(str))


-- local content = get_content(key,value)
ngx.say(key)
