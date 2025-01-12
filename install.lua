term.clear()
term.setCursorPos(1, 1)

local function drawProgressBar(x, y, length, progress)
    term.setCursorPos(x, y)
    term.write("[")
    local barLength = math.floor(length * progress)
    term.write(string.rep("=", barLength))
    term.write(string.rep(" ", length - barLength))
    term.write("]")
end

local directories = {
    "os",
    "os/assets",
    "os/commands",
    "os/modules",
    "os/games",
    "os/libs",
    "os/sounds"
}

for _, dir in ipairs(directories) do
    if not fs.exists(dir) then
        fs.makeDir(dir)
    end
end

local mainPath = "https://raw.githubusercontent.com/GamerboyRyan/SynovaOS/main/os/"

local files = {
    {url = mainPath.."assets/logo.nfp", path = "os/assets/logo.nfp"},
    {url = mainPath.."modules/displayNFP.lua", path = "os/modules/displayNFP.lua"},
    {url = mainPath.."modules/loadingBarScreen.lua", path = "os/modules/loadingBarScreen.lua"},
    {url = mainPath.."sounds/lets-go-gambling-x-slide.dfpwm", path = "os/sounds/lets-go-gambling-x-slide.dfpwm"},
    {url = mainPath.."monitor.lua", path = "os/monitor.lua"},
    {url = mainPath.."loading.lua", path = "os/loading.lua"},
    {url = mainPath.."welcome.lua", path = "os/welcome.lua"},
    {url = mainPath.."updater.lua", path = "os/updater.lua"},
    {url = mainPath.."main.lua", path = "os/main.lua"},
    {url = mainPath.."startup.lua", path = "os/startup.lua"},
    {url = mainPath.."start.lua", path = "os/start.lua"},
    {url = mainPath.."view.lua", path = "os/commands/view.lua"},
    {url = mainPath.."commands/edit.lua", path = "os/commands/edit.lua"},
    {url = mainPath.."games/snake.lua", path = "os/games/snake.lua"},
    {url = mainPath.."libs/helper.lua", path = "os/libs/helper.lua"}
}

local function downloadFile(url, path)
    shell.run("wget " .. url .. " " .. path)
end

local function downloadWithProgressBar()
    print("Starting installation...")
    print("")
    print("===================================")
    os.sleep(1)

    local totalFiles = #files
    for i, file in ipairs(files) do
        local progress = i / totalFiles
        drawProgressBar(1, 7, 30, progress)
        print("Downloading " .. file.path .. "...")
        downloadFile(file.url, file.path)
        term.clearLine()
        term.setCursorPos(1, 8)
    end

    term.clearLine()
    term.setCursorPos(1, 8)
    drawProgressBar(1, 7, 30, 1)
    print("Installation progress complete!")
end

downloadWithProgressBar()

local startup = fs.open("startup", "w")
startup.writeLine("shell.run('os/startup.lua')")
startup.close()

local currentVersion

local url = "https://raw.githubusercontent.com/GamerboyRyan/SynovaOS/main/version.txt"

local response = http.get(url)

if response then
    local content = response.readAll()
    response.close()
    currentVersion = content
else
    print("Failed to fetch version.txt from GitHub. Make sure HTTP is enabled.")
end

local currentVersionFile = fs.open("currentVersion.txt", "w")

if currentVersionFile then
    currentVersionFile.write(currentVersion)
    currentVersionFile.close()
else
    print("Failed to open the file for writing.")
end

print("===================================")
print("")
print("Installation complete! Rebooting...")

os.sleep(1)

os.reboot()