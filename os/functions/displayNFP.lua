local function displayNFP(filePath)
    if fs.exists(filePath) then
        term.clear()
        term.setCursorPos(1, 1)

        paintutils.drawImage(paintutils.loadImage(filePath), 1, 1)
    else
        print("File not found: " .. filePath)
    end
end

return displayNFP
