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

-- hash结构key1,value1,key2,value2...获取hash表内容
function hgetall_content(key)
	local red = redis_connect()

	local content,err = red:hgetall(key)
	if content == false or content == ngx.null then
		ngx.say('no content: ',err)
		return false
	end
	local result = {}
	local value
	for k,v in pairs(content) do
		if k%2 == 1 then
			value = v
		else
			result[value] = v
		end
	end
	return cjson.encode(result)
end

-- 获取hash表某个字段内容
function hget_content(key,field)
	local red = redis_connect()

	local content,err = red:hget(key,field)
	if content == ngx.null then
		ngx.say("content null: ", err)
	    return false
	end
	local result = {}
	result[field] = content
	return cjson.encode(result)
end

-- hash表某个字段整型增量，非整型会报错
function hincrby(key,field,value)
	-- body
	local red = redis_connect()
	local content = hget_content(key,field)
	local result = {}
	result['status'] = 'fail'
	result['content'] = 'null'
	if content ~= false then
		local res,err = red:hincrby(key,field,value)
		if res ~= false then
			result['status'] = 'success'
			result['content'] = hget_content(key,field)
		end
	end
	return cjson.encode(result)
end

--频道发布内容
function pub(channel,content)
	-- body
	local red = redis_connect()
	local res,err = red:publish(channel,content)
	local result = {}
	result['status'] = 'fail'
	result['content'] = 'publish nothing'
	if res ~= false then
		result['status'] = 'success'
		result['content'] = content
	end
	return cjson.encode(result)
end

--频道接收
function sub(channel)
	-- body
	local red = redis_connect()
	local res,err = red:subscribe(channel)
	local result = {}
	result['status'] = 'fail'
	result['content'] = 'subscribe nothing'
	if res ~= false then
		result['status'] = 'success'
		result['content'] = res
	end
	return cjson.encode(result)
end
