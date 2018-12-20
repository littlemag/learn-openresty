local redis_common = require("redis.redis_common")
local args = ngx.req.get_uri_args()
local key = args.param
-- local str = ngx.var.path
-- local action = string.sub(str,string.len('redis')+2,string.len(str))

local content = get_content(key)
ngx.say(content)