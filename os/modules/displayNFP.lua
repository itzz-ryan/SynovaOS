local displayNFPModule = {}

function displayNFPModule.displayNFP(filePath)
    if fs.exists(filePath) then
        term.clear()
        term.setCursorPos(1, 1)

        paintutils.drawImage(paintutils.loadImage(filePath), 1, 1)
    else
        print("File not found: " .. filePath)
    end
end

function displayNFPModule.clearScreen()
    term.clear()
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.black)
    
    for i = 1, 10 do
        shell.run("about")
    end
    
    term.clear()
    term.setCursorPos(1, 1)
end

return displayNFPModule