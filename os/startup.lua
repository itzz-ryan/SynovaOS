-- startup.lua
if fs.exists("install.lua") then
    shell.run("delete install.lua")
end

if fs.exists("update.lua") then
    shell.run("delete update.lua")
end

term.clear()
term.setCursorPos(1, 1)

print("Running Updater...")

local success, err = pcall(function()
    shell.run("os/updater.lua")
end)

if not success then
    print("Error running updater: " .. err)
end

os.sleep(1.5)

term.clear()
term.setCursorPos(1, 1)

print("Starting Mindows...")

os.sleep(2)

-- Load the NFP file
local function displayNFP(filename)
    if fs.exists(filename) then
        -- Clear the terminal
        term.clear()
        term.setCursorPos(1, 1)

        -- Load and draw the NFP file
        paintutils.drawImage(paintutils.loadImage(filename), 1, 1)
    else
        print("File not found: " .. filename)
    end
end

-- Display the loading image
displayNFP("os/loading.nfp")

-- Optional: Keep the program running until a key is pressed
print("Press any key to exit...")
os.pullEvent("key")

os.sleep(2)

term.clear()
term.setCursorPos(1, 1)

local success, err = pcall(function()
    shell.run("os/start.lua")
end)

if not success then
    print("Error running starter: " .. err)
end
