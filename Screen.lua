Screen = {}
Screen.__index = Screen

function Screen:init( window_w,window_h,left_pad,right_pad,top_pad,bottom_pad )

    -- body
    Screen.width = window_w - left_pad - right_pad
    Screen.height = window_h - top_pad - bottom_pad
    Screen.x = left_pad
    Screen.y = top_pad
    Screen.bottomY = window_h - bottom_pad

    return Screen

end

function Screen:BrickGrid( number_of_brick_X, number_of_brick_Y )
      -- body
      Screen.rowNum = number_of_brick_X
      Screen.colNum = number_of_brick_Y
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
end

function Screen:Draw( )
    -- body
    love.graphics.rectangle('line', Screen.x, Screen.y, Screen.width, Screen.height)
end