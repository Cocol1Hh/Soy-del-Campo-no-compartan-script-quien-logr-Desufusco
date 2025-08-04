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
local MarketplaceService = game:GetService("MarketplaceService")
local fullName = MarketplaceService:GetProductInfo(game.PlaceId).Name

local filteredName = fullName:gsub("%b[]", function(match)
	local inner = match:sub(2, -2)
	if inner:find("[%z\1-\127\194-\244][\128-\191]*") and not inner:find("[%w]") then
		return inner
	else
		return ""
	end
end)

filteredName = filteredName:gsub("%s%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""):upper()
if filteredName:sub(-1) == "." then
	filteredName = filteredName:sub(1, -2)
end


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
TextLabel.Text = " "
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
TextLabel.TextSize = 14
TextLabel.TextStrokeTransparency = 0
TextLabel.TextScaled = true



local textLabel = Instance.new("TextLabel")
textLabel.Parent = Frame
textLabel.Size = UDim2.new(0.9, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = filteredName
textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
textLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
textLabel.TextStrokeTransparency = 0
textLabel.TextScaled = true
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.TextYAlignment = Enum.TextYAlignment.Top


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


local Exp = Instance.new("TextLabel")
Exp.Size = UDim2.new(0, 100, 0, 10)
Exp.Position = UDim2.new(0.490, 0, 0.009, 0)
Exp.BackgroundTransparency = 1
Exp.TextColor3 = Color3.fromRGB(255, 255, 255)
Exp.TextSize = 7
Exp.Parent = Barra1

local Rebiths = Instance.new("TextLabel")
Rebiths.Size = UDim2.new(0, 100, 0, 10)
Rebiths.Position = UDim2.new(0.120, 0, 0.009, 0)
Rebiths.BackgroundTransparency = 1
Rebiths.TextColor3 = Color3.fromRGB(255, 255, 255)
Rebiths.TextScaled = true
Rebiths.Text = "Rebirth"
Rebiths.Parent = Barra1

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 100, 0, 23)
statusLabel.Position = UDim2.new(0.134, 0, 0.03, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.Text = "Stats..."
statusLabel.Parent = Barra1

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
    {text = "Farm", position = UDim2.new(0.010, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0)},
    {text = "Spin", position = UDim2.new(0.520, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0)},
    {text = "Reb|Stats", position = UDim2.new(0.010, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255)},
    {text = "Gift", position = UDim2.new(0.520, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255)},
    {text = "Pets", position = UDim2.new(0.010, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0)},
    {text = "Equip", position = UDim2.new(0.520, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255)},
    {text = "Jump", position = UDim2.new(0.1, 0, 0.320, 0), color = Color3.fromRGB(200, 200, 200)},
    {text = "Speed", position = UDim2.new(0.653, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100)},
    {text = "Duck", position = UDim2.new(0.010, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 200)},
    {text = "PestTP", position = UDim2.new(0.520, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70)},
    {text = "NoTouch", position = UDim2.new(0.010, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},
    {text = "INMortal", position = UDim2.new(0.520, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},
    {text = "Autoclik", position = UDim2.new(0.010, 0, 0.570, 0), color = Color3.fromRGB(200, 200, 90)},
    {text = "AutoEquip", position = UDim2.new(0.520, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100)},
}

local uniformSize = UDim2.new(0, 75, 0, 36)

for _, props in pairs(textProperties) do
    local Frame = Instance.new("Frame")
    Frame.Parent = Barra1
    Frame.BackgroundTransparency = 1
    Frame.Size = uniformSize
    Frame.Position = props.position
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = true

    if props.position.X.Scale < 0 then
        Frame.Position = UDim2.new(0.001, 0, props.position.Y.Scale, 0)
    end

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Frame
    TextLabel.Size = UDim2.new(1, 0, 1, 0) 
    TextLabel.Position = UDim2.new(0, 0, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextStrokeColor3 = props.color
    TextLabel.TextStrokeTransparency = 0
    TextLabel.Text = props.text
    TextLabel.TextScaled = true 
    TextLabel.TextWrapped = true 
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center 
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center 
    TextLabel.TextSize = 50
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
local saveFileName = "Legends_Switches.json"
local function SaveSwitchState(isActive, switchName)
    local states = {}
    if isfile(saveFileName) then
        states = HttpService:JSONDecode(readfile(saveFileName))
    end
    states[switchName] = {SwitchOn = isActive, LastModified = os.time()}
    writefile(saveFileName, HttpService:JSONEncode(states))
end

local function LoadSwitchState(switchName)
    if not isfile(saveFileName) then return false end
    local states = HttpService:JSONDecode(readfile(saveFileName))
    return states[switchName] and states[switchName].SwitchOn or false
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

local getIsActive1  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.120, 0), "Legends1",  LoadSwitchState("Legends1"))  -- Farm
local getIsActive2  = createSwitch(Barra1, UDim2.new(0.735, 0, 0.115, 0), "Legends2",  LoadSwitchState("Legends2"))  -- Form
local getIsActive3  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.2,   0), "Legends3",  LoadSwitchState("Legends3"))  -- Rebirth
local getIsActive4  = createSwitch(Barra1, UDim2.new(0.735, 0, 0.195, 0), "Legends4",  LoadSwitchState("Legends4"))  -- Ozaru
local getIsActive5  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.275, 0), "Legends5",  LoadSwitchState("Legends5"))  -- Black
local getIsActive6  = createSwitch(Barra1, UDim2.new(0.740, 0, 0.275, 0), "Legends6",  LoadSwitchState("Legends6"))  -- Hallowen 🎃
local getIsActive7  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.420, 0), "Legends7",  LoadSwitchState("Legends7"))  -- Duck
local getIsActive8  = createSwitch(Barra1, UDim2.new(0.740, 0, 0.420, 0), "Legends8",  LoadSwitchState("Legends8"))  -- Protección server
local getIsActive9  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.495, 0), "Legends9",  LoadSwitchState("Legends9"))  -- Graf
local getIsActive10 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.495, 0), "Legends10", LoadSwitchState("Legends10")) -- Planet
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2,   0, 0.570, 0), "Legends11", LoadSwitchState("Legends11")) -- Mapa
local getIsActive12 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.570, 0), "Legends12", LoadSwitchState("Legends12")) -- Klirin


local jumpInput = 0
local originalJumpPower
createBar(0, "Jump", Color3.fromRGB(255, 0, 0), 0.37, 100, function(v) 
    jumpInput = v
end, "jump")
task.spawn(function()
    while true do
        if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
            local hum = lplr.Character.Humanoid
            if not originalJumpPower then
                originalJumpPower = hum.JumpPower
            end            
            if jumpInput == 0 then
                hum.JumpPower = originalJumpPower
            else
                local val = jumpInput * 5
                hum.JumpPower = val
                local stats = lplr:FindFirstChild("leaderstats")
                if stats and stats:FindFirstChild("Jump") then
                    stats.Jump.Value = val
                end
            end
        end
        task.wait()
    end
end)


local originalSpeed = nil
createBar(0.513, "Speed", Color3.fromRGB(0, 255, 0), 0.37, 200, function(v)
    if originalSpeed == nil then
        local char = lplr.Character or lplr.CharacterAdded:Wait()
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            originalSpeed = hum.WalkSpeed
        end
    end
    speed = (v == 0 and originalSpeed) or v    
    task.spawn(function()
        while true do
            task.wait()
            local char = lplr.Character or lplr.CharacterAdded:Wait()
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = speed
            end
        end
    end)
end, "Speed")



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
				local lplr = game:GetService("Players").LocalPlayer
				local root = lplr.Character:WaitForChild("HumanoidRootPart")
				local winsFolder = workspace:WaitForChild("Wins")
				local leaderstats = lplr:WaitForChild("leaderstats")
				local playerWins = leaderstats:WaitForChild("Wins").Value
				local unlocked = lplr:WaitForChild("UnlockedWorlds")

				local mundos = {
					["Hell"] = 10000,
					["Candy"] = 6000,
					["Heaven"] = 3000,
					["Forest"] = 2000,
					["Steampunk"] = 1000,
					["Desert"] = 750,
					["Void"] = 500,
					["Dark"] = 250,
					["Snow"] = 100,
					["Flower"] = 50,
					["Ice"] = 30,
					["Lava"] = 20,
					["Moon"] = 10,
					["Earth"] = 0,
				}

				local keys = {}
				for name in pairs(mundos) do table.insert(keys, name) end
				table.sort(keys, function(a, b)
					return mundos[a] > mundos[b]
				end)

				for _, world in ipairs(keys) do
					if unlocked:FindFirstChild(world) then
						local part = winsFolder:FindFirstChild(world)
						if part and part:IsA("BasePart") then
							firetouchinterest(root, part, 0)
							task.wait()
							firetouchinterest(root, part, 1)
							break
						end
					end
				end
			end
		end)
		task.wait(1)
	end
end)


   
 task.spawn(function()
    while task.wait(.5) do
    pcall(function()  
    if getIsActive2() then
game:GetService("ReplicatedStorage"):WaitForChild("SpinFolder"):WaitForChild("Spin"):FireServer()
         end
     end)
  end
end)

task.spawn(function()
    while task.wait(1) do
    pcall(function()  
    if getIsActive3() then
game.ReplicatedStorage:WaitForChild("RebirthEvent"):FireServer()
         end
     end)
  end
end)

task.spawn(function()
    while task.wait(.5) do
    pcall(function()  
    if getIsActive4() then
for i = 1, 15 do
    game:GetService("ReplicatedStorage"):WaitForChild("Recv"):InvokeServer("TimeGift", tostring(i))
            end
         end
     end)
  end
end)
   
  
task.spawn(function()
    while true do
        pcall(function()
        if getIsActive5() then
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local workspaceEggs = workspace:WaitForChild("Eggs")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local huevoMasCercano = nil
            local menorDistancia = math.huge
            for _, huevo in pairs(workspaceEggs:GetChildren()) do
                local ui = huevo:FindFirstChild("UIanchor")
                if ui then
                    local distancia = (hrp.Position - ui.Position).Magnitude
                    if distancia < menorDistancia then
                        menorDistancia = distancia
                        huevoMasCercano = huevo
                    end
                end
            end
            if huevoMasCercano then
                local destino = huevoMasCercano:FindFirstChild("UIanchor")
                if destino and menorDistancia > 10 then
                    hrp.CFrame = destino.CFrame + Vector3.new(0, 3, 0)
                    task.wait(0.3)
                end
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("EggOpened"):InvokeServer(huevoMasCercano.Name, "Single")
            end      
            end
        end)
        task.wait()
    end
end)

task.spawn(function()
    while task.wait(.5) do
    pcall(function()  
    if getIsActive6() then
game.ReplicatedStorage.RemoteEvents.PetActionRequest:InvokeServer("EquipBest", {Pets = {}})
         end
     end)
  end
end)


local Players = game:GetService("Players")
local lplr = Players.LocalPlayer
local huevos = {
    {nombre = "Noob", requisito = 1},
    {nombre = "Starter", requisito = 2},
    {nombre = "Rare", requisito = 4},
    {nombre = "Pro", requisito = 6},
    {nombre = "Epic", requisito = 10},
    {nombre = "Legendary", requisito = 12},
    {nombre = "Mythical", requisito = 18},
    {nombre = "Godly", requisito = 25},
    {nombre = "Candy", requisito = 40},
    {nombre = "Beach", requisito = 100},
    {nombre = "Dark", requisito = 200},
    {nombre = "Void", requisito = 300},
    {nombre = "Desert", requisito = 400},
    {nombre = "Steampunk", requisito = 500},
    {nombre = "Forest", requisito = 600},
    {nombre = "Heaven", requisito = 1200},
    {nombre = "Sugar", requisito = 1600},
    {nombre = "Hell", requisito = 2400}
}

task.spawn(function()
    while true do
    pcall(function()
    if getIsActive8() then
        local wins = lplr.leaderstats:FindFirstChild("Wins")
        if wins then
            local disponibles = {}
            for _, huevo in ipairs(huevos) do
                if wins.Value >= huevo.requisito then
                    table.insert(disponibles, huevo)
                end
            end
            local top = {}
            for i = math.max(#disponibles - 3, 1), #disponibles do
                table.insert(top, disponibles[i])
            end
            for _, huevo in ipairs(top) do
                local obj = workspace:FindFirstChild("Eggs")
                if obj and obj:FindFirstChild(huevo.nombre) then
                    local pos = obj[huevo.nombre]:FindFirstChild("PriceBrick")
                    if pos then
                        lplr.Character:PivotTo(pos.CFrame + Vector3.new(0, 3, 0))
                        task.wait(10)
                    end
                end
            end
        end
        end
        end)
        task.wait()
    end
end)


task.spawn(function()
    while task.wait() do
    pcall(function()		
    if getIsActive9() then
         local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
		char:WaitForChild("Humanoid").BreakJointsOnDeath = false
		char:WaitForChild("Humanoid").Health = char.Humanoid.MaxHealth
             end
         end)
    end
end)

task.spawn(function()
	while task.wait() do
	pcall(function()		
	    if getIsActive10() then
		local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	    	end
		 end)
	end
end)

task.spawn(function()
	while task.wait() do
	pcall(function()		
	    if getIsActive11() then
		  game:GetService("ReplicatedStorage").IncreaseSpeed:FireServer()
	    	end
		 end)
	end
end)

task.spawn(function()
	while task.wait() do
	pcall(function()		
	    if getIsActive12() then
		  game:GetService("ReplicatedStorage").EquipBestMorphEvent:FireServer()
	    	end
		 end)
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
             		 	
             			
             Rebiths.Text = "Rebirths: " .. tostring(lplr.leaderstats.Rebirth.Value)
           
				local rebirthValue = lplr.leaderstats.Rebirth.Value
				local strengthValue = lplr.leaderstats.Wins.Value
				local nextRequirement = lplr.requiredwins.Value
				statusLabel.Text = string.format(
				    "%s/%s\n%s",
				    formatNumber(nextRequirement),
				    formatNumber(strengthValue),
				    formatNumber(rebirthValue)
				)		
				local currentRebirthValue = lplr.leaderstats.Rebirth.Value
				if currentRebirthValue > previousRebirthValue then
				    game.ReplicatedStorage.RebirthTimeValue.Value = tick()
				    previousRebirthValue = currentRebirthValue
				end				
				if isInTargetPlace() then
				    if not hasReinitialized then
				        game.ReplicatedStorage.RebirthTimeValue.Value = tick()
				        previousRebirthValue = currentRebirthValue
				        hasReinitialized = true
				    end
				else
				    hasReinitialized = false
				end		
				saveRebirthData()          
             end
         end)        
    end
end)

task.spawn(function()
	while wait(1) do
		pcall(function()
			if not totalWins then totalWins = 0 end			if not previousWins then previousWins = lplr.leaderstats.Wins.Value end
			local currentWins = lplr.leaderstats.Wins.Value
			if currentWins > previousWins then
				totalWins = totalWins + (currentWins - previousWins)
			end
			previousWins = currentWins
			Exp.Text = "Exps: " .. formatNumber(totalWins)
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
  
  
