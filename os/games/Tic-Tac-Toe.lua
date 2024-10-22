-- Spielfeld initialisieren (3x3 Gitter)
local board = {
    "1", "2", "3",
    "4", "5", "6",
    "7", "8", "9"
}

-- Funktion, um das Spielfeld anzuzeigen
local function displayBoard()
    term.clear()
    term.setCursorPos(1, 1)
    print(" " .. board[1] .. " | " .. board[2] .. " | " .. board[3])
    print("---+---+---")
    print(" " .. board[4] .. " | " .. board[5] .. " | " .. board[6])
    print("---+---+---")
    print(" " .. board[7] .. " | " .. board[8] .. " | " .. board[9])
end

-- Funktion, um zu überprüfen, ob ein Spieler gewonnen hat
local function checkWin(player)
    local winPatterns = {
        {1, 2, 3}, {4, 5, 6}, {7, 8, 9}, -- Reihen
        {1, 4, 7}, {2, 5, 8}, {3, 6, 9}, -- Spalten
        {1, 5, 9}, {3, 5, 7}             -- Diagonalen
    }

    for _, pattern in ipairs(winPatterns) do
        if board[pattern[1]] == player and
           board[pattern[2]] == player and
           board[pattern[3]] == player then
            return true
        end
    end
    return false
end

-- Funktion, um zu prüfen, ob das Spielfeld voll ist (Unentschieden)
local function isBoardFull()
    for i = 1, 9 do
        if board[i] ~= "X" and board[i] ~= "O" then
            return false
        end
    end
    return true
end

-- Funktion, um die Spielernamen abzufragen
local function getPlayerNames()
    print("Spieler 1, wähle deinen Namen (X):")
    local player1 = read()
    print("Spieler 2, wähle deinen Namen (O):")
    local player2 = read()
    return player1, player2
end

-- Hauptspielschleife
local function playGame()
    local player1, player2 = getPlayerNames()
    local currentPlayer = "X" -- Spieler 1 startet mit "X"
    local currentName = player1

    while true do
        displayBoard()

        -- Spielereingabe abfragen
        print("\n" .. currentName .. " ist am Zug. Wähle ein Feld (1-9):")
        local move = tonumber(read())

        -- Überprüfen, ob die Eingabe gültig ist
        if move == nil then
            print("Bitte gib nur zahlen an.")
        end
        if move >= 1 and move <= 9 and board[move] ~= "X" and board[move] ~= "O" then
            -- Setze das Zeichen des aktuellen Spielers auf das gewählte Feld
            board[move] = currentPlayer

            -- Überprüfen, ob der Spieler gewonnen hat
            if checkWin(currentPlayer) then
                displayBoard()
                print("\n" .. currentName .. " hat gewonnen!")
                break
            end

            -- Überprüfen, ob das Spiel unentschieden ist
            if isBoardFull() then
                displayBoard()
                print("\nUnentschieden!")
                break
            end

            -- Spieler wechseln
            if currentPlayer == "X" then
                currentPlayer = "O"
                currentName = player2
            else
                currentPlayer = "X"
                currentName = player1
            end
        else
            print("\nUngültige Eingabe! Wähle ein freies Feld zwischen 1 und 9.")
            sleep(1)
        end
    end

    print("\nMöchtest du erneut spielen? (ja/nein)")
    local replay = read()
    if replay:lower() == "ja" then
        board = {"1", "2", "3", "4", "5", "6", "7", "8", "9"} -- Spielfeld zurücksetzen
        playGame()
    else
        print("Danke fürs Spielen!")
    end
end

-- Spiel starten
playGame()
