local redis_common = require("redis.redis_common")
local args = ngx.req.get_uri_args()
local key = args.param

local content = hgetall_content(key)
ngx.say(content)