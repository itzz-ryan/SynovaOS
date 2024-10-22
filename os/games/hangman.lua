-- Hangman-Spiel für ComputerCraft

-- Liste der Wörter (hier kannst du deine eigenen Wörter hinzufügen)
local words = {
    "Apfel",
    "Banane",
    "Telekenese",
    "Cola",
    "Mindows",
    "Tisch",
    "Fisch",
    "Haus",
    "Baum",
    "Gesetzbuch",
    "DigitaleDiensteGesetz",
    "Laterne",
    "Donaudampfschifffahrtselektrizitätenhauptbetriebswerkbauunterbeamtengesellschaft",
    "Puppenhaus",
    "Kissen",
    "Ampel",
    "Lampe",
    "Fenster",
    "Stuhl",
    "Schüssel",
    "Alexa",
    "Decke",
    "Batterie",
    "Kleber",
    "Wand",
    "Boden",
    "Deckel",
    "Jacke",
    "Besen",
    "Stopschild",
    "Klebeband",
    "Steckdose",
    "LED",
    "LEDStreifen",
    "LEDLampe",
    "Projector",
    "Affe",
    "Gorilla",
    "Giraffe",
    "Insekt",
    "Baumhaus",
    "Biene",
    "IPAdresse",
    "Adresse",
    "Wohnort",
    "Stadt",
    "Boxen",
    "Boxer",
}

-- Zufälliges Wort auswählen
local chosenWord = words[math.random(#words)]:lower() -- Wort in Kleinbuchstaben umwandeln
local guessedLetters = {}
local maxAttempts = 6
local attemptsLeft = maxAttempts

-- Funktion, um das aktuelle Wort anzuzeigen
local function displayWord()
    local display = ""
    for i = 1, #chosenWord do
        local letter = chosenWord:sub(i, i)
        if guessedLetters[letter] then
            display = display .. letter .. " "
        else
            display = display .. "_ "
        end
    end
    return display
end

-- Hauptspielschleife
while attemptsLeft > 0 do
    term.clear()
    term.setCursorPos(1, 1)

    print("Hangman!")
    print("Versuche übrig: " .. attemptsLeft)
    print("Wort: " .. displayWord())
    print("\nBuchstaben, die du geraten hast: ")

    for letter, _ in pairs(guessedLetters) do
        write(letter .. " ")
    end

    print("\n\nGib einen oder mehrere Buchstaben ein:")
    local guess = read():lower()

    -- Überprüfen, ob der Benutzer mehrere Buchstaben eingegeben hat
    local allCorrect = true
    for char in guess:gmatch(".") do
        if not guessedLetters[char] then
            guessedLetters[char] = true
            -- Überprüfen, ob der geratene Buchstabe im Wort enthalten ist
            if not chosenWord:find(char) then
                allCorrect = false
                attemptsLeft = attemptsLeft - 1
                print("\nFalsch! Der Buchstabe '" .. char .. "' ist nicht im Wort.")
            else
                print("\nRichtig! Der Buchstabe '" .. char .. "' ist im Wort.")
            end
        else
            print("\nDu hast den Buchstaben '" .. char .. "' bereits geraten!")
        end
    end

    -- Überprüfen, ob das Wort vollständig erraten wurde
    if displayWord():find("_") == nil then
        print("\nHerzlichen Glückwunsch! Du hast das Wort '" .. chosenWord .. "' erraten!")
        break
    end

    if not allCorrect then
        sleep(2)
    end
end

if attemptsLeft == 0 then
    print("\nDu hast verloren! Das Wort war '" .. chosenWord .. "'.")
end
