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

shell.run("os/updater.lua")

os.sleep(1.5)

term.clear()
term.setCursorPos(1, 1)

print("Starting Mindows...")

os.sleep(2)

local displayNFPModule = require("functions/displayNFP")

displayNFPModule.displayNFP("os/assets/logo.nfp")

os.sleep(2)

term.clear()
term.setCursorPos(1, 1)
term.setBackgroundColor(colors.black)

for i = 1, 10 do
    shell.run("about")
end

term.clear()
term.setCursorPos(1, 1)

os.sleep(0.5)

shell.run("os/loading.lua")

os.sleep(0.5)

term.clear()
term.setCursorPos(1, 1)

shell.run("os/welcome.lua")

os.sleep(0.5)

term.clear()
term.setCursorPos(1, 1)

shell.run("os/start.lua")
