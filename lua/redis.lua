local args = ngx.req.get_uri_args()
local redis = require "resty.redis"
local cjson = require "cjson"
local red = redis:new()
red:set_timeout(1000)
local ok, err = red:connect("127.0.0.1", 6379)

if not ok then
    ngx.say("failed to connect: ", err)
    return
end

ok, err = red:set("dog", "an animal")
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end

param = args.param
res, err = red:get(param)

if not res then
    ngx.say("failed to set dog: ", err)
    return
end

ngx.say(cjson.encode({param,res}))