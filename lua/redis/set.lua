local redis= require("lua.redis")

key = args.key
value = args.value

ok, err = redis.connect:set(key, value)
if not ok then
    ngx.say("failed to set "..key, err)
    return
end