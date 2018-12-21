local redis_common = require("redis.redis_common")
local args = ngx.req.get_uri_args()
local channel = args.param

local result = sub(channel)
ngx.say(result)