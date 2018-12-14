local args = ngx.req.get_uri_args()
local redis= require "redis"
local cjson = require "cjson"

key = args.key
ngx.say(key)
res, err = redis.connect:get(param)

if not res then
    ngx.say("failed to get redis: ", err)
    return
end
array = {}
array[key] = res
ngx.say(cjson.encode(array))