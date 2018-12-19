local switch = {
     get = function (key)
         local res = {}
         local data,err = red:get(key)
         res[key] = data
         return res,err
     end,
     
     set = function (key,value)
     	local data,err = red:sget(key,value)
     	return data,err	 	
     end

}