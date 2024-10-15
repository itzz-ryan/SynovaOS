-- main.lua

-- Function to initialize the monitor
local function initializeMonitor()
    local monitor = peripheral.find("monitor")
    
    if not monitor then
        print("No monitor found. Please attach a monitor.")
        return
    end
    
    -- Display Welcome Screen
    monitor.setBackgroundColor(colors.blue)
    monitor.clear()
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(2, 2)
    monitor.write("Welcome to My Custom OS!")
    
    -- Version info
    monitor.setCursorPos(2, 4)
    monitor.setTextColor(colors.yellow)
    monitor.write("Version 1.1 - Latest Features!")
    
    -- Dynamic Information (optional)
    while true do
        monitor.setCursorPos(2, 6)
        monitor.setTextColor(colors.cyan)
        local time = textutils.formatTime(os.time(), true)
        monitor.write("Time: " .. time)
        
        sleep(1)
    end
end

-- Start the OS and monitor display
initializeMonitor()
