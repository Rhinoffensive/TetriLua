require("Screen")  
require("Brick")


view_w, view_h = 300, 700

function love.load()
    love.window.setMode(view_w,view_h,{borderless=false})
    sc = Screen:init(view_w,view_h,10,10,10,10)
    sc:BrickGrid(8,15)

    br = Brick:init(sc.b_width, sc.b_height,sc.x,sc.y)
    print(#sc.tileMap)
    print(sc.rowNum)
    print(sc.bottomY)

end

dtotal = 0 
function love.update(dt)
    

    dtotal = dtotal + dt   -- we add the time passed since the last update, probably a very small number like 0.01
    if dtotal >= 0.1 then
       dtotal = dtotal - 0.1   -- reduce our timer by a second, but don't discard the change... what if our framerate is 2/3 of a second?
       br:Update(dt)
    end
    
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    br:Draw()
    sc:Draw()
end

