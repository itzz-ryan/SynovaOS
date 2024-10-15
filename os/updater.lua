-- updater.lua
local currentVersion = "1.0"  -- Set this to the current version of your OS
local versionFileUrl = "https://raw.githubusercontent.com/GamerboyRyan/ComputerCraft-OS/main/version.txt"
local baseUrl = "https://raw.githubusercontent.com/GamerboyRyan/ComputerCraft-OS/main/os/"
local filesToUpdate = {
    "startup.lua",
    "commands/view.lua",
    "commands/edit.lua",
    "libs/helper.lua"
}

-- Function to download a file
local function downloadFile(url, path)
    shell.run("wget " .. url .. " " .. path)
end

-- Function to check for updates
local function checkForUpdates()
    print("Checking for updates...")
    
    -- Download the version file
    local versionFile = "version.txt"
    downloadFile(versionFileUrl, versionFile)

    -- Read the version number from the downloaded file
    local file = fs.open(versionFile, "r")
    local latestVersion = file.readLine()
    file.close()

    print("Current version: " .. currentVersion)
    print("Latest version: " .. latestVersion)

    -- Compare versions
    if latestVersion > currentVersion then
        print("Updating to version " .. latestVersion .. "...")
        for _, fileName in ipairs(filesToUpdate) do
            local url = baseUrl .. fileName
            print("Downloading " .. fileName .. "...")
            downloadFile(url, "os/" .. fileName)
        end
        print("Update complete! Please reboot the computer.")
    else
        print("You are already using the latest version.")
    end
end

-- Run the update check
checkForUpdates()
