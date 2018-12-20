local redis_common = require("redis.redis_common")
local args = ngx.req.get_uri_args()
local key = args.key
local value = args.value

set_content(key,value)