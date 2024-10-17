-- loadingBarScreen.lua

-- Function to display the loading screen with a loading bar
local function displayLoadingBarScreen(message, totalSteps)
    local termWidth, termHeight = term.getSize()  -- Get the terminal size
    local centerX = math.ceil(termWidth / 2)  -- Calculate center X position
    local centerY = math.ceil(termHeight / 2)  -- Calculate center Y position
    local barWidth = termWidth - 4  -- Width of the loading bar

    -- Clear the terminal
    term.clear()
    term.setCursorPos(1, 1)

    -- Draw the loading message
    term.setCursorPos(centerX - #message // 2, centerY - 1)  -- Center message horizontally
    term.write(message)

    -- Initialize loading bar
    term.setCursorPos(2, centerY)  -- Set cursor for loading bar
    term.write("[" .. string.rep(" ", barWidth) .. "]")  -- Draw empty loading bar

    -- Animate loading
    for step = 1, totalSteps do
        local progress = math.floor((step / totalSteps) * barWidth)  -- Calculate progress width
        term.setCursorPos(2, centerY)  -- Set cursor back to loading bar
        term.write("[" .. string.rep("=", progress) .. string.rep(" ", barWidth - progress) .. "]")  -- Update loading bar
        sleep(0.1)  -- Simulate loading time, adjust for speed
    end

    -- Clear the screen after loading is complete
    term.clear()
    term.setCursorPos(1, 1)
end

-- Call the loading bar screen function with a message and total steps
displayLoadingBarScreen("Loading, please wait...", 30)  -- 30 total steps for the loading bar
