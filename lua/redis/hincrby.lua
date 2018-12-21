local redis_common = require("redis.redis_common")
local args = ngx.req.get_uri_args()
local key = args.key
local field = args.field
local value = args.value

local content = hincrby(key,field,value)
ngx.say(content)