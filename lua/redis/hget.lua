local redis_common = require("redis.redis_common")
local args = ngx.req.get_uri_args()
local key = args.key
local field = args.field

local content = hget_content(key,field)
ngx.say(content)