local function displayStartAnimation()
    local termWidth, termHeight = term.getSize()
    local centerX = math.ceil(termWidth / 2)
    local centerY = math.ceil(termHeight / 2)

    local message = "Welcome!"
    local delay = 0.1
    local colorsArray = { colors.red, colors.orange, colors.yellow, colors.lime, colors.cyan, colors.purple }
    
    for i = 1, #message do
        local subMessage = message:sub(1, i)

        local colorIndex = (i % #colorsArray) + 1
        term.setTextColor(colorsArray[colorIndex])

        term.setCursorPos(centerX - (#subMessage / 2), centerY)
        term.clearLine()
        term.write(subMessage)
        sleep(delay)
    end
    
    for i = 1, 4 do
        term.setCursorPos(centerX - (#message / 2), centerY)
        term.clearLine()
        term.setTextColor(colors.white)
        term.write(message)
        sleep(0.2)

        term.setCursorPos(centerX - (#message / 2), centerY)
        term.clearLine()
        sleep(0.2)
    end

    sleep(0.5)
end

displayStartAnimation()
