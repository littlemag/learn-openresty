local redis_common = require("redis.redis_common")
local args = ngx.req.get_uri_args()
local channel = args.param
local content = args.content

local result = pub(channel,content)
ngx.say(result)