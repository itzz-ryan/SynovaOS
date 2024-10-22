local function displayLoadingBarScreen(message, totalSteps)
    local termWidth, termHeight = term.getSize() 
    local centerX = math.ceil(termWidth / 2)
    local centerY = math.ceil(termHeight / 2)
    local barWidth = termWidth - 4

    term.setCursorPos(centerX - #message / 2, centerY - 1)
    term.write(message)

    term.setCursorPos(2, centerY)
    term.write("[" .. string.rep(" ", barWidth) .. "]")

    for step = 1, totalSteps do
        local progress = math.floor((step / totalSteps) * barWidth)
        term.setCursorPos(2, centerY)
        term.write("[" .. string.rep("=", progress) .. string.rep(" ", barWidth - progress) .. "]")
        sleep(math.random(1, 10) / 100)
    end
end

displayLoadingBarScreen("Loading, please wait...", 30)
