-- Target height for optimal Copper generation
local TARGET_Y = 48

print("Enter current Y-level:")
local currentY = tonumber(read())

if not currentY then
    print("Error: Invalid Y-level entered.")
    return
end

-- Function to handle moving vertically while clearing blocks
local function travelVertical(target)
    while currentY ~= target do
        if currentY < target then
            if turtle.up() then
                currentY = currentY + 1
            else
                turtle.digUp()
            end
        else
            if turtle.down() then
                currentY = currentY - 1
            else
                turtle.digDown()
            end
        end
        os.sleep(0.1) -- Small cooldown to prevent path blocking
    end
end

-- Clear block forward and move
local function moveForward()
    while not turtle.forward() do
        turtle.dig()
    end
end

-- Position the turtle at the right Y level
print("Adjusting position to Y = " .. TARGET_Y .. "...")
travelVertical(TARGET_Y)
print("Target Y-level reached!")

-- Simple mining loop (mines straight line, clearing up and down)
print("How many blocks forward should I mine?")
local distance = tonumber(read()) or 20

print("Mining copper vein path...")
for i = 1, distance do
    moveForward()
    turtle.digUp()   -- Clears copper above
    turtle.digDown() -- Clears copper below
end

print("Mining complete! Returning to starting altitude...")
travelVertical(currentY) 
print("Finished.")
