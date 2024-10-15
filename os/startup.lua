-- startup.lua
term.clear()
term.setCursorPos(1, 1)

print("Running Updater...")

local success, err = pcall(function()
    shell.run("os/updater.lua")
end)

if not success then
    print("Error running updater: " .. err)
end

os.sleep(2)

term.clear()
term.setCursorPos(1, 1)

print("Starting Mindows...")

os.sleep(2)

local success, err = pcall(function()
    shell.run("os/start.lua")
end)

if not success then
    print("Error running starter: " .. err)
end
