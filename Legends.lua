 local fffg = game.CoreGui:FindFirstChild("fffg")
if fffg then
    return  
end
local Fernando = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Cuadro1 = Instance.new("Frame")
local Cuadro2 = Instance.new("Frame")
local Cuadro3 = Instance.new("Frame")
local Barra1 = Instance.new("ScrollingFrame")
local Barra2 = Instance.new("ScrollingFrame")
local Barra3 = Instance.new("ScrollingFrame")
local Siguiente = Instance.new("TextButton")
local Mix = Instance.new("TextButton")
local Borde1 = Instance.new("UIStroke")
local Borde2 = Instance.new("UIStroke")
local Borde3 = Instance.new("UIStroke")
local HttpService = game:GetService("HttpService")--Barra
local Lighting = game:GetService("Lighting")--Barra
local UserInputService = game:GetService("UserInputService")--Barra
local lplr = game:GetService("Players").LocalPlayer

Fernando.Name = "fffg"
Fernando.Parent = game.CoreGui


local suffixes = {'', 'K', 'M', 'B', 'T', 'qd', 'Qn'}
local function formatNumber(number)
    local isNegative = number < 0
    number = math.abs(number)
    for i = 1, #suffixes do
        if number < 10^(i * 3) then
            local divisor = 10^((i - 1) * 3)
            local formatted = math.floor((number / divisor) * 100) / 100
            return (isNegative and "-" or "") .. formatted .. suffixes[i]
        end
    end
    return (isNegative and "-" or "") .. tostring(number):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end 

Frame.Parent = Fernando
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(0.5, -150, 0.4, -130)
Frame.Size = UDim2.new(0, 410, 0, 30)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Text = "Muscle Legends                         "
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
TextLabel.TextSize = 14
TextLabel.TextStrokeTransparency = 0
TextLabel.TextScaled = true


Cuadro1.Parent = TextLabel
Cuadro1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro1.Position = UDim2.new(0, 0, 1, 0)
Cuadro1.Size = UDim2.new(0, 410, 0, 400)
Cuadro1.Visible = false  -- Comienza oculto

Cuadro2.Parent = TextLabel
Cuadro2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro2.Position = UDim2.new(0, 0, 1, 0)
Cuadro2.Size = UDim2.new(0, 410, 0, 400)
Cuadro2.Visible = false  -- Comienza oculto

Cuadro3.Parent = TextLabel
Cuadro3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro3.Position = UDim2.new(0, 0, 1, 0)
Cuadro3.Size = UDim2.new(0, 410, 0, 400)
Cuadro3.Visible = false  -- Comienza oculto

Barra1.Parent = Cuadro1
Barra1.Size = UDim2.new(1, 0, 1, 0)
Barra1.CanvasSize = UDim2.new(0, 0, 2, 0)
Barra1.ScrollBarThickness = 10
Barra1.BackgroundTransparency = 1
Barra1.ScrollingDirection = Enum.ScrollingDirection.Y 

Barra2.Parent = Cuadro2
Barra2.Size = UDim2.new(1, 0, 1, 0)
Barra2.CanvasSize = UDim2.new(0, 0, 2, 0)
Barra2.ScrollBarThickness = 10
Barra2.BackgroundTransparency = 1
Barra2.ScrollingDirection = Enum.ScrollingDirection.Y 

Barra3.Parent = Cuadro3
Barra3.Size = UDim2.new(1, 0, 1, 0)
Barra3.CanvasSize = UDim2.new(0, 0, 2, 0)
Barra3.ScrollBarThickness = 10
Barra3.BackgroundTransparency = 1
Barra3.ScrollingDirection = Enum.ScrollingDirection.Y 

Siguiente.Parent = Frame
Siguiente.BackgroundTransparency = 1
Siguiente.Position = UDim2.new(0.9, 17, 0, 0)
Siguiente.Size = UDim2.new(0, 30, 0, 30)
Siguiente.Text = ">"
Siguiente.TextColor3 = Color3.fromRGB(255, 255, 255)
Siguiente.TextSize = 20

Mix.Parent = Frame
Mix.BackgroundTransparency = 1
Mix.Position = UDim2.new(0.880, 0, 0, 0)
Mix.Size = UDim2.new(0, 30, 0, 30)
Mix.Text = "+"
Mix.TextColor3 = Color3.fromRGB(255, 255, 255)
Mix.TextSize = 20

local userId = lplr.UserId
local thumbnailUrl = game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 58, 0, 58)
imageLabel.Position = UDim2.new(0.07, 0, 0.04, 0)
imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = thumbnailUrl
imageLabel.Parent = Barra1

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(0, 40, 0, 10)
pingLabel.Position = UDim2.new(0.380, 0, 0.009, 0)
pingLabel.BackgroundTransparency = 1 
pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLabel.TextSize = 7
pingLabel.Parent = Barra1


local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(0, 100, 0, 10)
timeLabel.Position = UDim2.new(0.490, 0, 0.009, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timeLabel.TextSize = 7
timeLabel.Parent = Barra1

local Fps = Instance.new("TextLabel")
Fps.Size = UDim2.new(0, 100, 0, 10)
Fps.Position = UDim2.new(0.663, 0, 0.009, 0)
Fps.TextSize = 7
Fps.BackgroundTransparency = 1
Fps.TextColor3 = Color3.fromRGB(255, 255, 255)
Fps.Parent = Barra1



local VS = Instance.new("TextLabel")
VS.Parent = Barra1
VS.Text = "V [0.8]"
VS.Size = UDim2.new(0, 100, 0, 10)
VS.Position = UDim2.new(0.783, 0, 0.009, 0)
VS.TextColor3 = Color3.fromRGB(255, 255, 255)
VS.BackgroundTransparency = 1
VS.TextSize = 7
VS.TextStrokeTransparency = 0.8


local button = Instance.new("TextButton", Barra1)
button.Size = UDim2.new(0.120, 0, 0.03, 0)
button.Position = UDim2.new(0.840, 0, 0.03, 0)
button.Text = "Reset"
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 100, 200)


local Contenedor = Instance.new("ScrollingFrame", Barra1)
Contenedor.Size = UDim2.new(0, 400, 0, 200)
Contenedor.Position = UDim2.new(0.490, 0, 0.731, 0)
Contenedor.AnchorPoint = Vector2.new(0.5, 0.5)
Contenedor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Contenedor.BorderSizePixel = 0
Contenedor.ScrollBarThickness = 6
Contenedor.CanvasSize = UDim2.new(0, 0, 0, 400)
Contenedor.ScrollingDirection = Enum.ScrollingDirection.Y



--incio Borde color\/
Borde1.Parent = Cuadro1
Borde1.Thickness = 2
Borde1.Color = Color3.fromRGB(255, 0, 0) 

Borde2.Parent = Cuadro2
Borde2.Thickness = 2
Borde2.Color = Color3.fromRGB(255, 0, 0) 

Borde3.Parent = Cuadro3
Borde3.Thickness = 2
Borde3.Color = Color3.fromRGB(255, 0, 0) 
--parte 2 de color Borde\/


task.spawn(function()
    local colors = {
        Color3.fromRGB(255, 0, 0), -- Rojo
        Color3.fromRGB(0, 255, 0), -- Verde
        Color3.fromRGB(0, 0, 255), -- Azul
        Color3.fromRGB(255, 255, 0) -- Amarillo
    }
    local index = 1

    while true do
        Borde1.Color = colors[index]
        Borde2.Color = colors[index]
        Borde3.Color = colors[index]
        index = index + 1
        if index > #colors then
            index = 1
        end
        task.wait(1) 
    end
end)
--Fin color Borde/\

--incio de color txt\/
local textProperties = {
    {text = "Farm", position = UDim2.new(-0.155 + 0, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Quets", position = UDim2.new(0.350 + 0, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Reb|Stats", position = UDim2.new(-0.160 + 0.170, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255), parent = Barra1, size = UDim2.new(0, 75, 0, 36)},
    {text = "Gift", position = UDim2.new(0.360 + 0, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Size", position = UDim2.new(-0.160 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "...", position = UDim2.new(0.350 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Speed", position = UDim2.new(-0.04 + 0, 0, 0.320, 0), color = Color3.fromRGB(200, 200, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Brillo", position = UDim2.new(0.473 + 0, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Duck", position = UDim2.new(-0.160 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Protect", position = UDim2.new(0.350 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Req", position = UDim2.new(-0.160 + 0, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Tp|Planet", position = UDim2.new(0.350 + 0.170, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 80, 0, 36)},
    {text = "Form", position = UDim2.new(-0.140 + 0, 0, 0.570, 0), color = Color3.fromRGB(200, 200, 90), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "F|Vip", position = UDim2.new(0.360 + 0.1, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 120, 0, 36)},
    {text = "Tp", position = UDim2.new(-0.160 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3, size = UDim2.new(0, 200, 0, 36)},
    {text = "Actk", position = UDim2.new(0.350 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3, size = UDim2.new(0, 200, 0, 36)},
    {text = "Copy", position = UDim2.new(-0.160 + 0, 0, 0.345, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3, size = UDim2.new(0, 200, 0, 36)},
    {text = "Camr", position = UDim2.new(0.350 + 0, 0, 0.345, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3, size = UDim2.new(0, 200, 0, 36)},
}

for _, props in pairs(textProperties) do
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = props.parent
    TextLabel.Size = props.size
    TextLabel.Position = props.position
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextStrokeColor3 = props.color
    TextLabel.TextStrokeTransparency = 0
    TextLabel.Text = props.text
    TextLabel.TextScaled = true
end
 --Fin del color txt/\
 
local HttpService = game:GetService("HttpService")
local switchName = "PanelState"
local currentPanel = 1
local isMinimized = true
local clickCount = 0

local function SaveMinimizedState(state)
    writefile(switchName.."_Minimized.json", HttpService:JSONEncode({Minimized = state, LastModified = os.time()}))
end

local function LoadMinimizedState()
    if isfile(switchName.."_Minimized.json") then
        local data = HttpService:JSONDecode(readfile(switchName.."_Minimized.json"))
        return data.Minimized
    end
    return true  -- Por defecto minimizado si no hay guardado previo
end

isMinimized = LoadMinimizedState()
local function UpdateVisibility()
    if isMinimized then
        Cuadro1.Visible = false
        Cuadro2.Visible = false
        Cuadro3.Visible = false
        Mix.Text = "+"
    else
        if currentPanel == 1 then
            Cuadro1.Visible = true
            Cuadro2.Visible = false
            Cuadro3.Visible = false
        elseif currentPanel == 2 then
            Cuadro1.Visible = false
            Cuadro2.Visible = true
            Cuadro3.Visible = false
        else
            Cuadro1.Visible = false
            Cuadro2.Visible = false
            Cuadro3.Visible = true
        end
        Mix.Text = "-"
    end
end

UpdateVisibility()

Siguiente.MouseButton1Click:Connect(function()
    if not isMinimized then
        if currentPanel == 1 then
            Cuadro1.Visible = false
            currentPanel = 2
            Cuadro2.Visible = true
        elseif currentPanel == 2 then
            Cuadro2.Visible = false
            currentPanel = 3
            Cuadro3.Visible = true
        else
            Cuadro3.Visible = false
            currentPanel = 1
            Cuadro1.Visible = true
        end
    end
end)

button.MouseButton1Click:Connect(function()
    lplr.Character.Humanoid:ChangeState(15)
end)

Mix.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    SaveMinimizedState(isMinimized)
    UpdateVisibility()
end)

--Aki ya es del interrutor <: \/
local function SaveSwitchState(isActive, switchName)
    writefile(switchName.."_SwitchState.json", game:GetService("HttpService"):JSONEncode({SwitchOn = isActive, LastModified = os.time()}))
end

local function LoadSwitchState(switchName)
    return isfile(switchName.."_SwitchState.json") and game:GetService("HttpService"):JSONDecode(readfile(switchName.."_SwitchState.json")).SwitchOn or false
end

local activeBar, speed = nil, 0
local flying = true
local function saveValue(name, value)
    writefile(name..".json", HttpService:JSONEncode({v=value,t=os.time()}))
end

local function loadValue(name)
    return isfile(name..".json") and HttpService:JSONDecode(readfile(name..".json")).v or 0
end


local function createSwitch(parent, position, switchName, initialState)
    local switchButton = Instance.new("TextButton")
    switchButton.Parent = parent
    switchButton.BackgroundColor3 = Color3.fromRGB(190, 190, 190)
    switchButton.BorderSizePixel = 0
    switchButton.Position = position
    switchButton.Size = UDim2.new(0, 84, 0, 30)
    switchButton.Text = ""
    Instance.new("UICorner", switchButton).CornerRadius = UDim.new(0.4, 0)

    local switchBall = Instance.new("Frame")
    switchBall.Parent = switchButton
    switchBall.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    switchBall.Size = UDim2.new(0, 30, 0, 30)
    switchBall.Position = UDim2.new(0, 5, 0.5, -15)
    switchBall.BorderSizePixel = 0
    Instance.new("UICorner", switchBall).CornerRadius = UDim.new(0.5, 0)

    local isActive = initialState

    switchBall.Position, switchBall.BackgroundColor3 = 
        isActive and UDim2.new(1, -35, 0.5, -15) or UDim2.new(0, 5, 0.5, -15), 
        isActive and Color3.fromRGB(0, 0, 200) or Color3.fromRGB(255, 0, 0)

    switchButton.MouseButton1Click:Connect(function()
        isActive = not isActive
        switchBall.Position, switchBall.BackgroundColor3 = 
            isActive and UDim2.new(1, -35, 0.5, -15) or UDim2.new(0, 5, 0.5, -15), 
            isActive and Color3.fromRGB(0, 0, 250) or Color3.fromRGB(255, 0, 0)        
        SaveSwitchState(isActive, switchName)
    end)
    return function() return isActive end
end

local function createBar(xPos, text, color, yPos, max, updateFunc, name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.41, 0, 0.02, 0)
    frame.Position = UDim2.new(xPos, 0, yPos, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.Parent = Barra1

    local bar = Instance.new("Frame", frame)
    bar.BackgroundColor3 = color
    
    local value = loadValue(name)
    bar.Size = UDim2.new(value/max, 0, 1, 0)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text..": "..value
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true

    for _, obj in pairs({frame, bar}) do
        Instance.new("UICorner", obj).CornerRadius = UDim.new(0, 10)
    end
    
    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.Touch or 
            input.UserInputType == Enum.UserInputType.MouseButton1) and 
            not activeBar then        
            activeBar = bar
            local connection
            connection = UserInputService.InputChanged:Connect(function(m)
                if m.UserInputType == Enum.UserInputType.MouseMovement or 
                   m.UserInputType == Enum.UserInputType.Touch then
                    local x = math.clamp((m.Position.X - frame.AbsolutePosition.X) / frame.AbsoluteSize.X, 0, 1)
                    local val = math.floor(x * max)
                    bar.Size = UDim2.new(x, 0, 1, 0)
                    label.Text = text..": "..val
                    saveValue(name, val)
                    updateFunc(val)
                end
            end)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                    activeBar = nil
                end
            end)
        end
    end)
end


--Tp Players
local getIsActive15 = createSwitch(Barra3, UDim2.new(0.2, 0, 0.275, 0), "Switch15", LoadSwitchState("Switch15"))--Tp
local getIsActive17 = createSwitch(Barra3, UDim2.new(0.2, 0, 0.345, 0), "Switch17", LoadSwitchState("Switch17"))--Tp
local getIsActive18 = createSwitch(Barra3, UDim2.new(0.740, 0, 0.345, 0), "Switch18", LoadSwitchState("Switch178"))--Tp
--[Xd]


local getIsActive1 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.120, 0), "Switch1", LoadSwitchState("Switch1"))--Farm
local getIsActive2 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.115, 0), "Switch2", LoadSwitchState("Switch2"))--Form
local getIsActive3 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.2, 0), "Switch3", LoadSwitchState("Switch3"))--Rebirth
local getIsActive4 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.195, 0), "Switch4", LoadSwitchState("Switch4"))--Ozaru
local getIsActive5 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.275, 0), "Switch5", LoadSwitchState("Switch5"))--Black
local getIsActive6 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.275, 0), "Switch6", LoadSwitchState("Switch6"))--Hallowen🎃
local getIsActive7 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.420, 0), "Switch7", LoadSwitchState("Switch7"))--Duck
local getIsActive8 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.420, 0), "Switch8", LoadSwitchState("Switch8"))--Protecion server
local getIsActive9 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.495, 0), "Switch9", LoadSwitchState("Switch9"))--Graf
local getIsActive10 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.495, 0), "Switch10", LoadSwitchState("Switch10"))--Planet
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.570, 0), "Switch11", LoadSwitchState("Switch11"))--Mapa
local getIsActive12 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.570, 0), "Switch12", LoadSwitchState("Switch12"))--Klirin

local getIsActive16 = createSwitch(Barra3, UDim2.new(0.740, 0, 0.275, 0), "Switch16", LoadSwitchState("Switch16"))--Atakes


createBar(0, "Speed", Color3.fromRGB(255, 0, 0), 0.37, 100, function(v) 
    speed = v
    if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
        lplr.Character.Humanoid.WalkSpeed = speed
    end
end, "speed")
createBar(0.513, "Ambient", Color3.fromRGB(0, 255, 0), 0.37, 700, function(v) Lighting.Ambient = Color3.fromRGB(v, v, v) end, "ambient")


--*(1)*--
local estabaSentado = false
local zonas1 = {
    {CFrame.new(111.6, 6.0, 351.9), 10},
    {CFrame.new(74.8, 6.9, 350.8), 150},
    {CFrame.new(-194.6, 8.2, 272.9), 400},
    {CFrame.new(-235.7, 13.1, 104.0), 1000},
    {CFrame.new(-231.3, 14.8, 66.8), 1500},
    {CFrame.new(-185.0, 10.0, 67.5), 2500}
}

local zonas2 = {
    {CFrame.new(-2695.1, 13.4, -181.8), 3000},
    {CFrame.new(-2628.6, 22.0, -609.6), 4000},
    {CFrame.new(-2917.5, 40.1, -209.6), 5000},
    {CFrame.new(-3022.5, 28.9, -197.5), 7500},
    {CFrame.new(-2720.1, 29.3, -591.3), 10000},
    {CFrame.new(-3008.7, 38.5, -337.7), 15000}
}

local zonas3 = {
    {CFrame.new(-7173.3, 44.7, -1105.0), 16000}
}--*(1)*---

--*(2)*--
local blacklist = {
    ["handstands"] = true,
    ["pushups"] = true,
    ["situps"] = true,
    ["stomp"] = true,
    ["punch"] = true,
    ["ground slam"] = true,
}

local function loopTool(tool)
    while tool.Parent == lplr.Character do
        pcall(tool.Activate, tool)
        task.wait()
    end
end--*(1)*--


--Casi fin del interrutor /\
task.spawn(function()
    pcall(function()
    
function player()
	if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
		if lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart") then
			return true
		end
	end
	return false
end
    


task.spawn(function()
    while true do
            pcall(function()
                    if getIsActive1() then
                local root = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
                if not root then return end
                local closest, dist = nil, math.huge
                for _, machine in pairs(workspace.machinesFolder:GetChildren()) do
                    local seat = machine:FindFirstChild("interactSeat")
                    if seat then
                        local d = (seat.Position - root.Position).Magnitude
                        if d < dist then
                            dist = d
                            closest = seat
                        end
                    end
                end
                if closest then
                    game.ReplicatedStorage.rEvents.machineInteractRemote:InvokeServer("useMachine", closest)
                   end
                end
            end)
        task.wait()
    end
end)

--*(1)*--
task.spawn(function()
	while true do
		pcall(function()
		if getIsActive1() then
			local char = lplr.Character or lplr.CharacterAdded:Wait()
			local humanoid = char:FindFirstChildWhichIsA("Humanoid")
			local seatPart = humanoid and humanoid.SeatPart
			local enMaquina = seatPart and seatPart:IsDescendantOf(workspace.machinesFolder)
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local fuerza = lplr.leaderstats.Strength.Value
			local rebirths = lplr.leaderstats.Rebirths.Value

			local listaZonas = {}
			for _, zona in ipairs(zonas1) do table.insert(listaZonas, zona) end
			if rebirths >= 1 then
				for _, zona in ipairs(zonas2) do table.insert(listaZonas, zona) end
			end
			if rebirths >= 15 then
				for _, zona in ipairs(zonas3) do table.insert(listaZonas, zona) end
			end

			local mejorZona = nil
			local mejorReq = -math.huge
			for _, zona in ipairs(listaZonas) do
				if fuerza >= zona[2] and zona[2] > mejorReq then
					mejorZona = zona[1]
					mejorReq = zona[2]
				end
			end

			if mejorZona and hrp then
				local distancia = (hrp.Position - mejorZona.Position).Magnitude
				local posActualMaquina = seatPart and seatPart.Position or Vector3.zero
				local usandoMaquinaCorrecta = enMaquina and (posActualMaquina - mejorZona.Position).Magnitude <= 20

				if usandoMaquinaCorrecta then return end

				if humanoid and humanoid.Sit then
					humanoid.Sit = false
					humanoid.SeatPart = nil
				end

				if distancia > 20 then
					hrp.CFrame = mejorZona
				end
			end
			end
		end)
		task.wait()
	end
end)--*(1)*--


task.spawn(function()
    while true do
    pcall(function()
    if getIsActive1() then
        local c = lplr.Character or p.CharacterAdded:Wait()
        local t = c:FindFirstChildWhichIsA("Tool")
        if t then
                t:Activate()
            end
            end
        end)
        task.wait(0.2)
    end
end)



--*(2)*--
task.spawn(function()
    while true do
        pcall(function()
        if getIsActive1() then
            local c = lplr.Character or lplr.CharacterAdded:Wait()
            local humanoid = c:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end

            for _, tool in ipairs(lplr.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = tool.Name:lower()
                    if not blacklist[name] then
                        humanoid:EquipTool(tool)
                        loopTool(tool)
                    end
                end
            end
            end
        end)
        task.wait()
    end
end)--*(2)*--

task.spawn(function()
	while true do
		pcall(function()
		if getIsActive4() then
			for i = 1, 8 do
				game.ReplicatedStorage.rEvents.freeGiftClaimRemote:InvokeServer("claimGift", i)				
			end
			end
		end)
		task.wait(.5)
	end
end)



task.spawn(function()
    while true do
        pcall(function()
        if getIsActive2() then
            game:GetService("ReplicatedStorage").rEvents.questsEvent:FireServer("seenQuest", "dailyQuests")
            game:GetService("ReplicatedStorage").rEvents.questsEvent:FireServer("seenQuest", "weeklyQuests")
            game:GetService("ReplicatedStorage").rEvents.questsEvent:FireServer("seenQuest", "storyQuests")

            local q = lplr:FindFirstChild("Quests")

            local function claimAll(folderName)
                local folder = q and q:FindFirstChild(folderName)
                if folder then
                    for _, quest in pairs(folder:GetChildren()) do
                        game:GetService("ReplicatedStorage").rEvents.questsEvent:FireServer("collectQuest", quest)
                        task.wait()
                    end
                end
            end
            claimAll("Daily Quests")
            claimAll("Weekly Quests")
            claimAll("Story Quests")
            end
        end)
        task.wait(.5)
    end
end)

task.spawn(function()
	while true do
		pcall(function()
		if getIsActive3() then
				game.ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
			end
		end)
		task.wait(.5)
	end
end)

task.spawn(function()
	while true do
		pcall(function()
		if getIsActive5() then
				game:GetService("ReplicatedStorage").rEvents.changeSpeedSizeRemote:InvokeServer("changeSize", 2)
			end
		end)
		task.wait(.5)
	end
end)

task.spawn(function()
	while true do
		pcall(function()
		     if getIsActive1() then
			lplr.muscleEvent:FireServer("rep")
			end
		end)
		task.wait()
	end
end)    
   
task.spawn(function()
    while wait(1) do
    pcall(function()
    if player() then
        local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
        pingLabel.Text = "Ping: " .. (ping < 1000 and ping or math.floor(ping / 10) * 10) .. " ms"---PING

        local fpsValue = math.floor(game:GetService("Stats").Workspace["Heartbeat"]:GetValue())
        Fps.Text = "FPS: " .. tostring(fpsValue)
             end
         end)        
    end
end)

task.spawn(function()
    while wait(.4) do
    pcall(function()
    if getIsActive7() and player() then
                local accessories = {}            
                for _, v in pairs(lplr.Character:GetChildren()) do 
                    if v:IsA("Hat") or v:IsA("Accessory") or v.Name:lower():find("hair") then
                        v.Parent = game.ReplicatedStorage
                        table.insert(accessories, v)
                    elseif v:IsA("BasePart") then
                        v.Transparency = 1
                    end
                end             
                local duck = Instance.new("SpecialMesh", lplr.Character.HumanoidRootPart)
                duck.MeshId = "http://www.roblox.com/asset/?id=9419831"
                duck.TextureId = "http://www.roblox.com/asset/?id=9419827"
                duck.Scale = Vector3.new(5, 5, 5)
                lplr.Character.HumanoidRootPart.Transparency = 0
            end             
        end)
   end
end)
    
  
    task.spawn(function()
       pcall(function() 
            local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:CaptureController()
    vu:ClickButton2(Vector2.new())
          end)
         end)
 end)          
 
 
 task.spawn(function()
pcall(function()
    local bb = game:service 'VirtualUser'
    game:service 'Players'.LocalPlayer.Idled:connect(function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
        task.wait(2)
    end)
end)
end)


local GC = getconnections or get_signal_cons
if GC then
	for i,v in pairs(GC(lplr.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
	lplr.Idled:Connect(function()
		local VirtualUser = game:GetService("VirtualUser")
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end

--fin de todo \/
       end)    
    task.wait()
  end)