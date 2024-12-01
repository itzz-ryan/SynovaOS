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

print("Starting SynovaOS...")

os.sleep(2)

local displayNFPModule = require("modules/displayNFP")

displayNFPModule.displayNFP("os/assets/logo.nfp")

os.sleep(2)

displayNFPModule.clearScreen()

os.sleep(0.5)

local loadingBarScreenModule = require("modules/loadingBarScreen")

loadingBarScreenModule.displayLoadingBarScreen("Loading, please wait...", 10)

os.sleep(0.5)

term.clear()
term.setCursorPos(1, 1)

shell.run("os/welcome.lua")

os.sleep(0.5)

term.clear()
term.setCursorPos(1, 1)

shell.run("os/start.lua")
