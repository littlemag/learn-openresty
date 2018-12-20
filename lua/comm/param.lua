local _M = {}

function _M.is_number(...)
    local arg = {...}

    local num
    for _,v in ipairs(arg) do
        num = tonumber(v)
        if nil == num then
            return false
        end
    end

    return true
end


-- string库的gsub函数，共三个参数： 
-- 1. str是待分割的字符串 
-- 2. '[^'..reps..']+'是正则表达式，查找非reps字符，并且多次匹配 
-- 3. 每次分割完的字符串都能通过回调函数获取到，w参数就是分割后的一个子字符串，把它保存到一个table中

function _M.split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end

return _M
