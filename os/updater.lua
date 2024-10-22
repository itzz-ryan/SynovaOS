local versionUrl = "https://raw.githubusercontent.com/GamerboyRyan/ComputerCraft-OS/main/version.txt"
local updaterUrl = "https://pastebin.com/vX7AD0wu"

local function getLocalVersion()
    if fs.exists("currentVersion.txt") then
        local file = fs.open("currentVersion.txt", "r")
    
        local version = file.readLine()
    
        file.close()
    
        return version
    else
        return nil
    end
end

local function getRemoteVersion()
    local response = http.get(versionUrl)
  
    if response then
        local version = response.readLine()
    
        response.close()
    
        return version
    else
        print("Failed to check for updates. Ensure HTTP is enabled.")
    
        return nil
    end
end

local function checkForUpdates()
    print("Checking for updates...")

    local localVersion = getLocalVersion()
    local remoteVersion = getRemoteVersion()

    if not localVersion then
        print("Local version not found. Assuming update is needed.")
    elseif not remoteVersion then
        print("Could not determine the latest version. Aborting update.")
        return
    elseif localVersion == remoteVersion then
        print("Your system is up-to-date! (Version " .. localVersion .. ")")
        return
    else
        print("New version available: " .. remoteVersion .. " (Current: " .. localVersion .. ")")
    end

    print("Creating Updater file...")

    shell.run("pastebin get vX7AD0wu update")

    os.sleep(0.1)

    print("Updating OS to version " .. remoteVersion .. "...")
    
    os.sleep(1)

    shell.run("update")
end

checkForUpdates()
