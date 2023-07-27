local plugins = {}

local files = io.popen('ls ./plugins')
for filename in files:lines() do
    if filename ~= 'init.lua' then
        plugins.insert(require(filename))
    end
end
return plugins