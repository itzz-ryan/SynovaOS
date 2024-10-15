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

os.sleep(1)

term.clear()
term.setCursorPos(1, 1)
print("Welcome to My Custom OS")
print("1. Start OS")
print("2. Shell Mode")
print("3. Shutdown")
print("Select an option:")

-- Wait for user input
local choice = read()

if choice == "1" then
    -- Start the OS
    local osFile = "os/main.lua"
    if fs.exists(osFile) then
        shell.run(osFile)
    else
        print("Error: OS file not found!")
    end
elseif choice == "2" then
    -- Enter normal shell mode
    print("Exiting to shell...")
    shell.run("shell")
elseif choice == "3" then
    -- Shutdown the computer
    print("Shutting down...")
    os.shutdown()
else
    print("Invalid choice! Rebooting...")
    os.reboot()
end
