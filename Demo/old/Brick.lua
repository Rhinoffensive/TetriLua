Brick = {}
Brick.__index = Brick
local self = setmetatable({}, Brick)

function Brick:SetSize(width, height)
    self.width = width
    self.height = height
    print(Brick.width, Brick.height)
end

function Brick:init(x,y)
    self.x = x
    self.y = y
    self.orientation = 'N'
    self.cw = 'E'
    self.ccw = 'W'


    self.child = {}
    self.child.x = self.x
    self.child.y = self.y - self.width
    

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
        self.child.y = self.y - self.height
        self.left = self.x
        self.bottom = self.y + self.height
        self.right = self.x + self.width
    elseif self.orientation == 'E' then
        self.child.x = self.x + self.width
        self.child.y = self.y
        self.left = self.x
        self.bottom = self.y + self.height
        self.right = self.x + 2 * self.width
    elseif self.orientation == 'S' then 
        self.child.x = self.x
        self.child.y = self.y + self.height
        self.left = self.x
        self.bottom = self.y  + 2 * self.height
        self.right = self.x + self.width
    elseif self.orientation == 'W' then 
        self.child.x = self.x - self.width
        self.child.y = self.y
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
        if self.x < Screen.leftX then 
            self.x = Screen.leftX
        end
    end

    if love.keyboard.isDown('right') then 
        self.x = self.x + self.width
        if self.x + self.width > Screen.rightX then
            self.x = Screen.rightX - self.width
        end
    end


  


    if self.bottom < Screen.bottomY then
        
        self.y = self.y + self.velocity
        if self.y + self.height > Screen.bottomY then
            self.y = Screen.bottomY - self.height
            Screen:InserTile(Screen:MaptoIndex(self.x,self.y),1)
            
            
            
        end

        
        
    end



    self:UpdateChild()
end



