Screen = {}
Screen.__index = Screen
local self = setmetatable({}, Screen)

function Screen:init( window_w,window_h,left_pad,right_pad,top_pad,bottom_pad )

    -- body
    Screen.width = window_w - left_pad - right_pad
    Screen.height = window_h - top_pad - bottom_pad
    Screen.x = left_pad
    Screen.y = top_pad
    Screen.topY = top_pad
    Screen.bottomY = window_h - bottom_pad
    Screen.leftX = left_pad
    Screen.rightX = window_w - right_pad

    return Screen

end

function Screen:BrickGrid( number_of_brick_X, number_of_brick_Y )
      -- body
      Screen.colNum = number_of_brick_X
      Screen.rowNum = number_of_brick_Y
      Screen.b_width = Screen.width / number_of_brick_X
      Screen.b_height = Screen.height / number_of_brick_Y
      
      Screen.tileMap = {}
      for i=1,number_of_brick_Y do
        row ={}
        for j=1,number_of_brick_X do
            row[j] = 0
        end
          Screen.tileMap[i] = row
      end

      local tileMap = Screen.tileMap
      for j=1, #tileMap do  
          local row = tileMap[j]   
          local r = ''   
          for i=1,#row do
              r = r ..row[i] 
          end  
          print(r)        
      end
end

function Screen:MaptoCoord(x,y)
    return Screen.leftX + Brick.width * (x-1) , Screen.topY + Brick * (y-1)
end

function Screen:MaptoIndex(x,y)
    print(math.floor((x - Screen.leftX) / Screen.rowNum) , math.floor((y - Screen.topY) / Screen.rowNum))
    return math.floor((x - Screen.leftX) / Screen.rowNum) , math.floor((y - Screen.topY) / Screen.rowNum)
end

function Screen:InserTile(x,y,color) 
    print(Screen.tileMap[x][y])
    Screen.tileMap[y][x] = color
    local tileMap = Screen.tileMap
    for j=1, #tileMap do  
        local row = tileMap[j]   
        local r = ''   
        for i=1,#row do
            r = r ..row[i] 
        end  
        print(r)        
    end
    print('Color '.. color)
end

function Screen:Draw( )
    -- body
    love.graphics.rectangle('line', Screen.x, Screen.y, Screen.width, Screen.height)

     --Screen.tileMap = {}
    tileMap = Screen.tileMap
    for j=1, #tileMap do  
        local row = tileMap[j]      
        for i=1,#row do
            
           
            if row[i] == 1 then
                print('Screen insert true')
                
            love.graphics.rectangle('fill', Screen.leftX +  (i-1) * Brick.width , Screen.topY + (j-1) * Brick.height , Brick.width , Brick.height  )
            

        
            end

        end          
    end
end