term.clear()
term.setCursorPos(1, 1)

print("Welcome to Mindows!")
print("1. Start OS")
print("2. Shell Mode")
print("3. Shutdown")
print("Select an option:")

local choice = read()

if choice == "1" then
    local osFile = "os/main.lua"
    if fs.exists(osFile) then
        shell.run(osFile)
    else
        print("Error: OS file not found!")
    end
elseif choice == "2" then
    print("Exiting to shell...")
    shell.run("shell")
elseif choice == "3" then
    print("Shutting down...")
    os.shutdown()
else
    print("Invalid choice! Rebooting...")
    os.reboot()
end
