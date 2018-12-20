local config = require "config.config"
local redis= require "resty.redis"
local cjson = require "cjson"

local function redis_connect()
	local red = redis:new()
	red:set_timeout(1000)
	local res, err = red:connect(config.redis_ip,config.redis_port)
	if not res then
	    ngx.say("failed to connect: ", err)
	    return false
	end
	return red
end

function set_content(key,value)
	local red = redis_connect()
	
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

function get_content(key)
	local red = redis_connect()

	param = red:get(key)
	array = {}
	array[key] = param
	return cjson.encode(array)
end

function mget_content(keys)
	local red = redis_connect()

	local content,err = red:mget(unpack(keys))
	local result = {}
	for k,v in pairs(keys) do
		result[v] = content[k]
	end
	return cjson.encode(result)
end

function hgetall_content(key)
	local red = redis_connect()

	local content,err = red:mget(key)
	local result = {}
	for k,v in pairs(content) do
		result[key] = content[k]
	end
	return cjson.encode(result)
end
