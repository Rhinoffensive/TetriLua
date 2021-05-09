Brick = {}
Brick.__index = Brick


function Brick:init( width,height,x,y )
    Brick.width = width
    Brick.height = height
    Brick.x = x
    Brick.y = y
    Brick.velocity = 8

    return  Brick
    -- body
end

function  Brick:Draw(  )

    love.graphics.setColor(0.5,0,0)
   
    love.graphics.rectangle('fill', Brick.x, Brick.y, Brick.width, Brick.height)

    
end

function Brick:Update(dt )
    if( love.keyboard.isDown('left')  ) then

    Brick.x = Brick.x - Brick.width
    end


    if( love.keyboard.isDown('right') ) then
    Brick.x = Brick.x + Brick.width
    end 

    if(love.keyboard.isDown('space')) then
        Brick.velocity = 80
    else 
        Brick.velocity = 8
    end

if Brick.y + Brick.height<= Screen.bottomY   then
   
    Brick.y = Brick.y + Brick.velocity 

    if Brick.y + Brick.height > Screen.bottomY then
        Brick.y = Screen.bottomY - Brick.height
    end
end


end