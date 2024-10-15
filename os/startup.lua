-- startup.lua
-- This file automatically runs on computer startup

-- Clear the screen and display a welcome message
term.clear()
term.setCursorPos(1, 1)
print("Welcome to My Custom OS")
print("Initializing...")

-- Define the main OS file path
local osFile = "os/main.lua"

-- Check if the main OS file exists
if fs.exists(osFile) then
    -- Run the main OS script
    print("Loading the operating system...")
    shell.run(osFile)
else
    -- Display an error message if the OS file is missing
    print("Error: Operating System file not found.")
    print("Please ensure that " .. osFile .. " exists.")
end
