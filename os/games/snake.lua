-- Snake Game
local width, height = term.getSize()
local snake = {{x = math.floor(width / 2), y = math.floor(height / 2)}}
local direction = {x = 1, y = 0}
local apple = {x = math.random(1, width), y = math.random(1, height)}
local score = 0
local speed = 0.2  -- Time between each update (lower = faster)

-- Draw the apple
local function drawApple()
    term.setCursorPos(apple.x, apple.y)
    term.setTextColor(colors.red)
    term.write("O")
    term.setTextColor(colors.white)
end

-- Draw the snake
local function drawSnake()
    for _, part in ipairs(snake) do
        term.setCursorPos(part.x, part.y)
        term.write("#")
    end
end

-- Place a new apple
local function placeApple()
    repeat
        apple.x = math.random(1, width)
        apple.y = math.random(1, height)
    until not (apple.x == snake[1].x and apple.y == snake[1].y)
end

-- Check if the snake has collided with itself or the walls
local function checkCollision()
    -- Check wall collision
    if snake[1].x < 1 or snake[1].x > width or snake[1].y < 1 or snake[1].y > height then
        return true
    end
    -- Check self collision
    for i = 2, #snake do
        if snake[1].x == snake[i].x and snake[1].y == snake[i].y then
            return true
        end
    end
    return false
end

-- Update the snake's position
local function updateSnake()
    -- Create a new head
    local newHead = {x = snake[1].x + direction.x, y = snake[1].y + direction.y}
    table.insert(snake, 1, newHead)
    
    -- Check for apple collision
    if newHead.x == apple.x and newHead.y == apple.y then
        score = score + 1
        placeApple()
    else
        table.remove(snake)  -- Remove the tail if no apple eaten
    end
end

-- Set direction based on user input
local function setDirection(key)
    if key == keys.up and direction.y == 0 then
        direction = {x = 0, y = -1}
    elseif key == keys.down and direction.y == 0 then
        direction = {x = 0, y = 1}
    elseif key == keys.left and direction.x == 0 then
        direction = {x = -1, y = 0}
    elseif key == keys.right and direction.x == 0 then
        direction = {x = 1, y = 0}
    end
end

-- Main game loop
local function gameLoop()
    while true do
        term.clear()
        term.setCursorPos(1, 1)
        print("Score: " .. score)
        
        drawApple()
        drawSnake()
        updateSnake()
        
        -- Check for collisions
        if checkCollision() then
            term.setCursorPos(1, 3)
            print("Game Over! Final Score: " .. score)
            break
        end
        
        -- Event handling for direction change
        local event, key = os.pullEvent("key")
        setDirection(key)
        
        -- Slow down the loop to control speed
        sleep(speed)
    end
end

-- Initialize the game
term.clear()
term.setCursorPos(1, 1)
print("Welcome to Snake! Use arrow keys to move.")
print("Press any key to start...")
os.pullEvent("key")  -- Wait for key press to start

-- Start the game loop
gameLoop()
