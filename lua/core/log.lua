local M = {}
M._debug_enabled = false

function M.enable_debug()
    M._debug_enabled = true
    print('-- DEBUG MODE ENABLED --')
end

function M.debug(...)
    if M._debug_enabled then
        for i, v in ipairs({...}) do
            if type(v) == "table" then
                v = vim.inspect(v)
            end
            print(v)
        end
    end
end

return M
