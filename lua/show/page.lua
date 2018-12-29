local template = require "resty.template"
local args = ngx.req.get_uri_args()
local page = ngx.var.path
template.render("/usr/local/openresty/nginx/lua/learn-openresty/lua/tpl/page.html",{param = args.param1,param2 = args.param2})
