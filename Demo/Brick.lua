Brick = {}
Brick.__index = Brick
local self = setmetatable({}, Brick)

function Brick:SetSize(width, height)
    self.width = width
    self.height = height
    print(Brick.width, Brick.height)
end

function Brick:init(i,j)
    self.i = i 
    self.j = j
    self.x = Screen.x + (self.i ) * Screen.b_width
    self.y = Screen.y + (self.j) * Screen.b_height
    self.orientation = 'N'
    self.cw = 'E'
    self.ccw = 'W'


    self.child = {}
    self.child.x = self.x
    self.child.i = self.i

    self.child.y = self.y - self.width
    self.child.j = self.j - 1

    self.left = self.x
    self.bottom = self.y + self.height
    self.right = self.x + self.width

    self.velocity = 10

    return self 
end

function Brick:Draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle('fill', self.child.x, self.child.y, self.width, self.height)
end

function Brick:Rotate(rotation) -- rotation : 'cw' or 'ccw'
    local gotoRotate = nil
    
    if rotation == 'cw' then
        gotoRotate = self.cw
    elseif rotation == 'ccw' then
        gotoRotate = self.ccw
    end

    if gotoRotate == 'N' then
        self.orientation = 'N'
        self.cw = 'E'
        self.ccw = 'W'
    elseif gotoRotate == 'E' then
        self.orientation = 'E'
        self.cw = 'S'
        self.ccw = 'N'
    elseif gotoRotate == 'S' then
        self.orientation = 'S'
        self.cw = 'W'
        self.ccw = 'E'
    elseif gotoRotate == 'W' then
        self.orientation = 'W'
        self.cw = 'N'
        self.ccw = 'S'
    end
end

function Brick:UpdateChild()
    if self.orientation == 'N' then
        self.child.x = self.x
        self.child.i = self.i
        self.child.y = self.y - self.height
        self.child.j = self.j - 1
        self.left = self.x
        self.bottom = self.y + self.height
        self.right = self.x + self.width
    elseif self.orientation == 'E' then
        self.child.x = self.x + self.width
        self.child.i = self.i + 1
        self.child.y = self.y
        self.child.j = self.j
        self.left = self.x
        self.bottom = self.y + self.height
        self.right = self.x + 2 * self.width
    elseif self.orientation == 'S' then 
        self.child.x = self.x
        self.child.i = self.i
        self.child.y = self.y + self.height
        self.child.j = self.j + 1
        self.left = self.x
        self.bottom = self.y  + 2 * self.height
        self.right = self.x + self.width
    elseif self.orientation == 'W' then 
        self.child.x = self.x - self.width
        self.child.i = self.i - 1
        self.child.y = self.y
        self.child.j = self.j
        self.left = self.x - self.width
        self.bottom = self.y + self.height
        self.right = self.x + self.width
    end
end

function Brick:Update(dt)
    if love.keyboard.isDown('up') then
        self:Rotate('ccw')
    end

    if love.keyboard.isDown('down') then
        self:Rotate('cw')
    end

    if love.keyboard.isDown('left') then
        self.x = self.x - self.width
        self.i = self.i - 1
        if self.x < Screen.leftX then 
            self.x = Screen.leftX
            self.i = 1
        end
    end

    if love.keyboard.isDown('right') then 
        self.x = self.x + self.width
        self.i = self.i + 1
        if self.x + self.width > Screen.rightX then
            self.x = Screen.rightX - self.width
            self.i = Screen.colNum
        end
    end


  


    if self.bottom < Screen.bottomY then
        
        self.y = self.y + self.velocity
      
        if self.y + self.height > Screen.bottomY then
            self.y = Screen.bottomY - self.height
            self.j = Screen.rowNum   
            Screen:InserTile(self.i,self.j,1)
            print('Inserted')
            self:init(5,0)    
          
        end
   
    end
        
        
    



    self:UpdateChild()
end



