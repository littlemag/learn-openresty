local redis_common = require("redis.redis_common")
local param = require("comm.param")
local args = ngx.req.get_uri_args()
local keys = param.split(args.param,',')

local content = mget_content(keys)
ngx.say(content)