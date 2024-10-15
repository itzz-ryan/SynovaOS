-- List of directories needed
local directories = {
    "os",
    "os/commands",
    "os/libs"
}

-- Create directories if they don't exist
for _, dir in ipairs(directories) do
    if not fs.exists(dir) then
        fs.makeDir(dir)
    end
end

-- Define files with their GitHub raw URLs and target paths
local files = {
    {url = "https://raw.githubusercontent.com/GamerboyRyan/ComputerCraft-OS/main/os/startup.lua", path = "os/startup"},
    {url = "https://raw.githubusercontent.com/GamerboyRyan/ComputerCraft-OS/main/os/commands/view.lua", path = "os/commands/view"},
    {url = "https://raw.githubusercontent.com/GamerboyRyan/ComputerCraft-OS/main/os/commands/edit.lua", path = "os/commands/edit"},
    {url = "https://raw.githubusercontent.com/GamerboyRyan/ComputerCraft-OS/main/os/libs/helper.lua", path = "os/libs/helper"}
}

-- Function to download files using wget
local function downloadFile(url, path)
    shell.run("wget " .. url .. " " .. path)
end

-- Start Installation
print("Starting installation from GitHub...")
for _, file in ipairs(files) do
    print("Downloading " .. file.path .. "...")
    downloadFile(file.url, file.path)
end

-- Setup startup file to automatically boot your OS
local startup = fs.open("startup", "w")
startup.writeLine("shell.run('os/startup')")
startup.close()

print("Installation complete! Rebooting...")
os.reboot()
