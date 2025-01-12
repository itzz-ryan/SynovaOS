term.clear()

-- Centering helpers
local function getCenter()
    local w, h = term.getSize()
    return math.floor(w / 2), math.floor(h / 2)
end

local function drawProgressBarCentered(length, progress)
    local centerX, centerY = getCenter()
    local startX = centerX - math.floor(length / 2)
    term.setCursorPos(startX, centerY)
    term.write("[")
    local barLength = math.floor(length * progress)
    term.write(string.rep("=", barLength))
    term.write(string.rep(" ", length - barLength))
    term.write("]")
end

local function writeCentered(text, offsetY)
    local centerX, centerY = getCenter()
    local x = centerX - math.floor(#text / 2)
    term.setCursorPos(x, centerY + offsetY)
    term.write(text)
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
    local barLength = 30
    local totalFiles = #files
    writeCentered("Installing...", -2)

    for i, file in ipairs(files) do
        local progress = i / totalFiles
        drawProgressBarCentered(barLength, progress)
        writeCentered("Downloading " .. file.path .. "...", 2)
        downloadFile(file.url, file.path)
        os.sleep(0.5) -- Adds a slight delay for visual feedback (optional)
    end

    -- Complete bar and clear extra info
    drawProgressBarCentered(barLength, 1)
    writeCentered("Installation progress complete!", 4)
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
    writeCentered("Failed to fetch version.txt from GitHub. Make sure HTTP is enabled.", 6)
end

local currentVersionFile = fs.open("currentVersion.txt", "w")

if currentVersionFile then
    currentVersionFile.write(currentVersion)
    currentVersionFile.close()
else
    writeCentered("Failed to open the file for writing.", 7)
end

writeCentered("Installation complete! Rebooting...", 8)

os.sleep(1)
os.reboot()