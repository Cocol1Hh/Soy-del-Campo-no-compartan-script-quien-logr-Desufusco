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
TextLabel.Text = "Steal a Brainrot                          "
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


local Cash = Instance.new("TextLabel")
Cash.Size = UDim2.new(0, 100, 0, 10)
Cash.Position = UDim2.new(0.490, 0, 0.009, 0)
Cash.BackgroundTransparency = 1
Cash.TextColor3 = Color3.fromRGB(255, 255, 255)
Cash.TextSize = 7
Cash.Parent = Barra1

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
    {text = "Farm", position = UDim2.new(-0.155 + 0, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Lock", position = UDim2.new(0.350 + 0, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Coins", position = UDim2.new(-0.160 + 0.170, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255), parent = Barra1, size = UDim2.new(0, 75, 0, 36)},
    {text = "Pest", position = UDim2.new(0.360 + 0, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Alert", position = UDim2.new(-0.160 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Ray", position = UDim2.new(0.350 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Speed", position = UDim2.new(-0.04 + 0, 0, 0.320, 0), color = Color3.fromRGB(200, 200, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Brillo", position = UDim2.new(0.473 + 0, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Duck", position = UDim2.new(-0.160 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Buys", position = UDim2.new(0.350 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Reb|Stats", position = UDim2.new(-0.160 + 0.170, 0, 0.495, 0), color = Color3.fromRGB(0, 255, 255), parent = Barra1, size = UDim2.new(0, 75, 0, 36)},
    {text = "PetsF", position = UDim2.new(0.350 + 0.170, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 80, 0, 36)},
    {text = "Goal", position = UDim2.new(-0.140 + 0, 0, 0.570, 0), color = Color3.fromRGB(200, 200, 90), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "F|Vip", position = UDim2.new(0.360 + 0.1, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 120, 0, 36)},
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


-- Tp Players
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



local defaultSpeed = 16 

createBar(0, "Speed", Color3.fromRGB(255, 0, 0), 0.37, 100, function(v)
    speed = v
end, "speed")
game:GetService("RunService").Stepped:Connect(function()
    local char = workspace:FindFirstChild(lplr.Name)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        if not speed or speed == 0 then
            hum.WalkSpeed = defaultSpeed
        else
            hum.WalkSpeed = speed
        end
    end
end)
createBar(0.513, "Ambient", Color3.fromRGB(0, 255, 0), 0.37, 700, function(v) Lighting.Ambient = Color3.fromRGB(v, v, v) end, "ambient")




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


local function Plots()
	for _, plot in pairs(workspace.Plots:GetChildren()) do
		local sign = plot:FindFirstChild("PlotSign")
		local gui = sign and sign:FindFirstChild("SurfaceGui")
		local frame = gui and gui:FindFirstChild("Frame")
		local label = frame and frame:FindFirstChild("TextLabel")
		if label then
			local name = label.Text:match("^(.-)'s Base$") or ""
			if name == lplr.Name or name == lplr.DisplayName then
				return plot
			end
		end
	end
	return nil
end


--Caudro de stats 
local function getRightSideNumber()
	local textLabel = game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Rebirth.Content.Holder.HolderImage.Loader.Bar.ProgressText
	if not textLabel or not textLabel:IsA("TextLabel") then
		return nil
	end
	local text = textLabel.Text
	local numberPart, suffix = string.match(text, "/%s*%$?%s*([%d%.]+)([KMB]?)")
	if not numberPart then
		return nil
	end
	local number = tonumber(numberPart)
	if not number then
		return nil
	end
	if suffix == "K" then
		number = number * 1000
	elseif suffix == "M" then
		number = number * 1000000
	elseif suffix == "B" then
		number = number * 1000000000
	end
	return number
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local player = LocalPlayer
local frameWidth = 430
local maxVisibleLines = 15
local lineHeight = 24
local frameHeight = lineHeight * maxVisibleLines

local scrollFrame = Instance.new("ScrollingFrame", Barra2)
scrollFrame.Size = UDim2.new(0, frameWidth, 0, frameHeight)
scrollFrame.Position = UDim2.new(0, 10, 0, 10)
scrollFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
scrollFrame.CanvasSize = UDim2.new(0,0,0,0)

local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0,2)

local suffixes = {'', 'K', 'M', 'B', 'T'}
local function formatNumber(num)
	local absNum = math.abs(num)
	for i = 1, #suffixes do
		if absNum < 10^(i*3) then
			local div = 10^((i-1)*3)
			local val = math.floor((num/div)*100)/100
			return val..suffixes[i]
		end
	end
	return tostring(num)
end

local function extractMoney(text)
	local amountStr = text:match(">(%$[%d%.]+[KMB]?)<")
	if not amountStr then return 0 end
	local num = tonumber(amountStr:match("[%d%.]+")) or 0
	local suffix = amountStr:match("[KMB]") or ""
	if suffix == "K" then num = num * 1e3
	elseif suffix == "M" then num = num * 1e6
	elseif suffix == "B" then num = num * 1e9 end
	return num
end

local function getPlayerByDisplayName(displayName)
	for _, plr in pairs(Players:GetPlayers()) do
		if plr.DisplayName == displayName then
			return plr
		end
	end
	return nil
end

local function getPlayerStatsByDisplayName(displayName)
	local plr = getPlayerByDisplayName(displayName)
	if not plr then return nil end
	local stats = plr:FindFirstChild("leaderstats")
	if not stats then return nil end
	local cash = stats:FindFirstChild("Cash")
	local rebirths = stats:FindFirstChild("Rebirths")
	local steals = stats:FindFirstChild("Steals")
	return {
		Cash = cash and cash.Value or 0,
		Rebirths = rebirths and rebirths.Value or 0,
		Steals = steals and steals.Value or 0
	}
end

local function walkToPosition(pos)
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end
	humanoid:MoveTo(pos)
end

local expandedStates = {}

local function extractApodo(text)
	local name = text:match("^(.-)'s Base$") or text:match("^(.-) Base$") or text
	if name:lower():find("empty") then
		return nil
	end
	return name
end

local function getBasesData()
	local bases = {}
	for _, plot in pairs(workspace.Plots:GetChildren()) do
		local sign = plot:FindFirstChild("PlotSign")
		local gui = sign and sign:FindFirstChild("SurfaceGui")
		local frame = gui and gui:FindFirstChild("Frame")
		local label = frame and frame:FindFirstChild("TextLabel")
		if label then
			local ownerApodo = extractApodo(label.Text)
			if not ownerApodo then continue end

			local mascotas = {}
			local totalCoins = 0
			if plot:FindFirstChild("AnimalPodiums") then
				for _, podium in pairs(plot.AnimalPodiums:GetChildren()) do
					local displayNameObj = podium.Base and podium.Base:FindFirstChild("Spawn")
						and podium.Base.Spawn:FindFirstChild("Attachment")
						and podium.Base.Spawn.Attachment:FindFirstChild("AnimalOverhead")
						and podium.Base.Spawn.Attachment.AnimalOverhead:FindFirstChild("DisplayName")
					local collectObj = podium.Claim and podium.Claim:FindFirstChild("Main")
						and podium.Claim.Main:FindFirstChild("Collect")
						and podium.Claim.Main.Collect:FindFirstChild("Collect")
					if displayNameObj and collectObj and (collectObj:IsA("TextLabel") or collectObj:IsA("TextButton")) then
						local name = displayNameObj.Text or "Mascota"
						local moneyNum = extractMoney(collectObj.Text)
						totalCoins = totalCoins + moneyNum
						table.insert(mascotas, {name = name, moneyNum = moneyNum})
					end
				end
			end
			table.sort(mascotas, function(a,b) return a.moneyNum > b.moneyNum end)
			local stats = getPlayerStatsByDisplayName(ownerApodo)
			table.insert(bases, {
				plot = plot,
				owner = ownerApodo,
				isMine = (ownerApodo == LocalPlayer.DisplayName),
				pets = mascotas,
				totalCoins = totalCoins,
				stats = stats
			})
		end
	end
	table.sort(bases, function(a,b)
		local cashA = (a.stats and a.stats.Cash) or 0
		local cashB = (b.stats and b.stats.Cash) or 0
		return cashA > cashB
	end)
	return bases
end

task.spawn(function()
	while true do
		for _, c in pairs(scrollFrame:GetChildren()) do
			if not c:IsA("UIListLayout") then
				c:Destroy()
			end
		end

		local bases = getBasesData()

		for _, baseData in ipairs(bases) do
			local container = Instance.new("Frame", scrollFrame)
			container.Size = UDim2.new(1, 0, 0, lineHeight)
			container.BackgroundTransparency = 1

			local ownerText = baseData.isMine and "Tu base" or ("Base de " .. baseData.owner)
			local ownerColor = baseData.isMine and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,255,255)

			local statsText = ""
			if baseData.stats then
				statsText = string.format(
					" | Cash: %s | Rebirths: %s | Steals: %s",
					formatNumber(baseData.stats.Cash),
					formatNumber(baseData.stats.Rebirths),
					formatNumber(baseData.stats.Steals)
				)
			end

			local label = Instance.new("TextLabel", container)
			label.Size = UDim2.new(0.65, -5, 1, 0)
			label.Position = UDim2.new(0, 5, 0, 0)
			label.BackgroundTransparency = 1
			label.TextColor3 = ownerColor
			label.Font = Enum.Font.SourceSansBold
			label.TextScaled = true
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Text = ownerText .. statsText

			local toggleBtn = Instance.new("TextButton", container)
			toggleBtn.Size = UDim2.new(0.1, 0, 0.8, 0)
			toggleBtn.Position = UDim2.new(0.7, 0, 0.1, 0)
			toggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			toggleBtn.TextColor3 = Color3.new(1,1,1)
			toggleBtn.Font = Enum.Font.SourceSansBold
			toggleBtn.TextScaled = true
			toggleBtn.Text = expandedStates[baseData.owner] and "▼" or "▶"

			local btnGo = Instance.new("TextButton", container)
			btnGo.Size = UDim2.new(0.15, 0, 0.8, 0)
			btnGo.Position = UDim2.new(0.8, 0, 0.1, 0)
			btnGo.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
			btnGo.TextColor3 = Color3.new(1,1,1)
			btnGo.Font = Enum.Font.SourceSansBold
			btnGo.TextScaled = true
			btnGo.Text = "Ir"

			btnGo.MouseButton1Click:Connect(function()
				local pos = baseData.plot.PrimaryPart and baseData.plot.PrimaryPart.Position or baseData.plot:GetModelCFrame().p
				walkToPosition(pos)
			end)

			local petsFrame = Instance.new("Frame", scrollFrame)
			petsFrame.BackgroundTransparency = 1
			petsFrame.Visible = expandedStates[baseData.owner] == true

			local petLayout = Instance.new("UIListLayout", petsFrame)
			petLayout.SortOrder = Enum.SortOrder.LayoutOrder
			petLayout.Padding = UDim.new(0, 0)

			for _, pet in ipairs(baseData.pets) do
				local petLabel = Instance.new("TextLabel", petsFrame)
				petLabel.Size = UDim2.new(1, -20, 0, lineHeight)
				petLabel.Position = UDim2.new(0, 20, 0, 0)
				petLabel.BackgroundTransparency = 1
				petLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				petLabel.Font = Enum.Font.SourceSans
				petLabel.TextScaled = true
				petLabel.TextXAlignment = Enum.TextXAlignment.Left
				petLabel.Text = "  " .. pet.name .. " - " .. formatNumber(pet.moneyNum)
			end

			local plot = baseData.plot
			local remainingTimeLabel = nil
			
			if plot:FindFirstChild("Purchases") then
				local plotBlock = plot.Purchases:FindFirstChild("PlotBlock")
				if plotBlock and plotBlock:FindFirstChild("Main") then
					local billboard = plotBlock.Main:FindFirstChild("BillboardGui")
					if billboard and billboard:FindFirstChild("RemainingTime") then
						remainingTimeLabel = billboard:FindFirstChild("RemainingTime")
					end
				end
			end
			
			if remainingTimeLabel and remainingTimeLabel:IsA("TextLabel") then
				local rawText = remainingTimeLabel.Text
				local cleanNumber = rawText:match("(%d+%.?%d*)") -- extrae solo el número, por ejemplo "23s" → 23
				local numberValue = tonumber(cleanNumber)
			
				if numberValue then
					local label = Instance.new("TextLabel", petsFrame)
					label.Size = UDim2.new(1, -20, 0, lineHeight)
					label.Position = UDim2.new(0, 20, 0, 0)
					label.BackgroundTransparency = 1
					label.Font = Enum.Font.SourceSansBold
					label.TextScaled = true
					label.TextXAlignment = Enum.TextXAlignment.Left
					label.Text = "🔒 Lock de Base: " .. rawText
			
					if numberValue >= 16 then
						label.TextColor3 = Color3.fromRGB(255, 0, 0) -- rojo
					else
						label.TextColor3 = Color3.fromRGB(0, 255, 0) -- verde
					end
				end
			end
			petsFrame.Size = UDim2.new(1, 0, 0, (#baseData.pets + 1) * lineHeight)

			toggleBtn.MouseButton1Click:Connect(function()
				local expanded = not petsFrame.Visible
				petsFrame.Visible = expanded
				toggleBtn.Text = expanded and "▼" or "▶"
				expandedStates[baseData.owner] = expanded
			end)
		end		
		task.wait(1)
	end
end)


--Lock
local yaMostroCamara = false
local ultimoObjetivo = nil

task.spawn(function()
	while true do
		pcall(function()
			if getIsActive1() or getIsActive2() then
				local char = lplr.Character or lplr.CharacterAdded:Wait()
				local hrp = char:WaitForChild("HumanoidRootPart")
				local humanoid = char:WaitForChild("Humanoid")
				local base = Plots()
				if not base then return end

				local blocks = {}
				local purchases = base:FindFirstChild("Purchases")
				if purchases and purchases:FindFirstChild("PlotBlock") then
					for _, block in pairs(purchases.PlotBlock:GetChildren()) do
						if block:IsA("BasePart") and block:FindFirstChild("BillboardGui") then
							local label = block.BillboardGui:FindFirstChild("RemainingTime")
							if label and label:IsA("TextLabel") then
								table.insert(blocks, {
									block = block,
									label = label,
									dist = (hrp.Position - block.Position).Magnitude,
									height = block.Position.Y
								})
							end
						end
					end
				end

				table.sort(blocks, function(a, b)
					if math.abs(a.height - b.height) <= 3 then
						return a.dist < b.dist
					else
						return a.height < b.height
					end
				end)

				local selected = blocks[1]
				if selected then
					local label = selected.label
					local text = label.Text
					local seconds = tonumber(text:match("(%d+)"))
					if seconds then
						local tiempoParaLlegar = selected.dist / (16 * 0.8)
						local maxTiempo = 15

						if seconds <= maxTiempo and seconds <= math.ceil(tiempoParaLlegar) then
							if ultimoObjetivo ~= selected.block then
								yaMostroCamara = false
								ultimoObjetivo = selected.block
							end

							if not yaMostroCamara then
								yaMostroCamara = true

								local cam = workspace.CurrentCamera
								cam.CameraType = Enum.CameraType.Scriptable
								cam.CFrame = CFrame.new(selected.block.Position + Vector3.new(0, 10, 15), selected.block.Position)

								local gui = Instance.new("ScreenGui", lplr:WaitForChild("PlayerGui"))
								gui.Name = "SpeedRunEffect"
								local textLabel = Instance.new("TextLabel", gui)
								textLabel.Size = UDim2.new(1, 0, 0.1, 0)
								textLabel.Position = UDim2.new(0, 0, 0.45, 0)
								textLabel.Text = "⚡ SPEED - ¡CORRE! ⚡"
								textLabel.Font = Enum.Font.FredokaOne
								textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
								textLabel.TextStrokeTransparency = 0
								textLabel.TextScaled = true
								textLabel.BackgroundTransparency = 1

								task.spawn(function()
									for i = 1, 10 do
										textLabel.TextStrokeTransparency = (i % 2 == 0) and 0 or 0.5
										task.wait()
									end
								end)

								task.delay(3, function()
									if gui then gui:Destroy() end
									cam.CameraType = Enum.CameraType.Custom
								end)
							end							
							while true do								
								if not getIsActive1() and not getIsActive2() then
									humanoid:MoveTo(hrp.Position) -- Detener
									local gui = lplr:FindFirstChild("PlayerGui"):FindFirstChild("SpeedRunEffect")
									if gui then gui:Destroy() end
									workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
									break
								end

								local currentText = selected.label.Text
								local currentSeconds = tonumber(currentText:match("(%d+)"))
								if not currentSeconds or currentSeconds > 15 then break end

								local center = selected.block.Position + Vector3.new(0, 2, 0)
								local fuera = selected.block.Position + Vector3.new(5, 2, 0)

								humanoid:MoveTo(center)
								task.wait(0.5)
								humanoid:MoveTo(fuera)
								task.wait(0.6)
							end
						else
							yaMostroCamara = false
							ultimoObjetivo = nil
						end
					end
				else
					yaMostroCamara = false
					ultimoObjetivo = nil
				end
			end
		end)
		task.wait()
	end
end)


--Recoger coins    
local function moveToWithTimeout(pos, timeout)
    local char = lplr.Character or lplr.CharacterAdded:Wait()
    local hrp, humanoid = char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid")
    humanoid:MoveTo(pos + Vector3.new(0, 3, 0))
    local startTime = tick()
    while (hrp.Position - pos).Magnitude > 5 and humanoid.Health > 0 do
        if tick() - startTime > timeout then break end
        if not getIsActive3() and not getIsActive1() then
            humanoid:MoveTo(hrp.Position)
            return
        end
        task.wait()
    end
end

task.spawn(function()
    while true do
        pcall(function()
            if not getIsActive3() and not getIsActive1() then
                task.wait()
                return
            end            
            local base = Plots()
            if base and base:FindFirstChild("AnimalPodiums") then
                for _, podium in pairs(base.AnimalPodiums:GetChildren()) do
                    if not getIsActive3() and not getIsActive1() then
                        return
                    end
                    local claim = podium:FindFirstChild("Claim")
                    local hitbox = claim and claim:FindFirstChild("Hitbox")
                    if hitbox then
                        moveToWithTimeout(hitbox.Position, 1)
                        pcall(function()
                            game:GetService("ReplicatedStorage").Packages.Net:WaitForChild("RE/PlotService/ClaimCoins"):FireServer(1)
                        end)
                        task.wait(.4)
                    end
                end
            else
                task.wait(.1)
            end
        end)
        task.wait(.2)
    end
end)


--Decteter Intruso
local lplr = game:GetService("Players").LocalPlayer
local function Plots()
	for _, plot in pairs(workspace.Plots:GetChildren()) do
		local label = plot:FindFirstChild("PlotSign") and plot.PlotSign:FindFirstChild("SurfaceGui")
			and plot.PlotSign.SurfaceGui:FindFirstChild("Frame")
			and plot.PlotSign.SurfaceGui.Frame:FindFirstChild("TextLabel")
		if label then
			local name = label.Text:match("^(.-)'s Base$") or ""
			if name == lplr.Name or name == lplr.DisplayName then
				return plot
			end
		end
	end
	return nil
end

local function ShowIntruderAlert(intruderNames)
	if not lplr:FindFirstChild("PlayerGui") then return end

	local gui = lplr.PlayerGui:FindFirstChild("IntruderAlert")
	if not gui then
		gui = Instance.new("ScreenGui")
		gui.Name = "IntruderAlert"
		gui.IgnoreGuiInset = true
		gui.ResetOnSpawn = false
		gui.Parent = lplr.PlayerGui

		local label = Instance.new("TextLabel")
		label.Name = "AlertLabel"
		label.Size = UDim2.new(1, 0, 0.25, 0)
		label.Position = UDim2.new(0, 0, 0.4, 0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.fromRGB(255, 0, 0)
		label.Font = Enum.Font.SciFi
		label.TextScaled = true
		label.TextStrokeTransparency = 0
		label.TextStrokeColor3 = Color3.new(0, 0, 0)
		label.Parent = gui

		task.spawn(function()
			while gui and gui.Parent do
				label.TextColor3 = label.TextColor3 == Color3.fromRGB(255, 0, 0) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 0, 0)
				label.Position = UDim2.new(0, math.random(-6,6), 0.4, math.random(-3,3))
				task.wait(0.08)
			end
		end)
	end

	local label = gui:FindFirstChild("AlertLabel")
	if label then
		label.Text = "⚠️ INTRUSOS DETECTADOS ⚠️\n" .. table.concat(intruderNames, ", ")
	end
end

local function HideIntruderAlert()
	local gui = lplr:FindFirstChild("PlayerGui") and lplr.PlayerGui:FindFirstChild("IntruderAlert")
	if gui then
		gui:Destroy()
	end
end

local function HighlightBase(plot)
	if plot:FindFirstChild("BaseHighlight") then return end
	local sel = Instance.new("SelectionBox")
	sel.Name = "BaseHighlight"
	sel.Adornee = plot
	sel.LineThickness = 0.1
	sel.Color3 = Color3.fromRGB(0, 170, 255)
	sel.SurfaceColor3 = sel.Color3
	sel.SurfaceTransparency = 0.7
	sel.Transparency = 0
	sel.Parent = plot
end

local function RemoveHighlight(plot)
	local sel = plot:FindFirstChild("BaseHighlight")
	if sel then
		sel:Destroy()
	end
end

local function DetectIntruders()
	local plot = Plots()
	if not plot then return end

	game:GetService("RunService").Heartbeat:Connect(function()
		if getIsActive5() then
			HighlightBase(plot)

			local intruderNames = {}
			local region = plot:GetExtentsSize()
			local center = plot:GetModelCFrame().Position

			for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
				if plr ~= lplr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
					local pos = plr.Character.HumanoidRootPart.Position
					if (pos - center).Magnitude < (region.Magnitude / 2) then
						table.insert(intruderNames, plr.DisplayName)
					end
				end
			end

			if #intruderNames > 0 then
				ShowIntruderAlert(intruderNames)
			else
				HideIntruderAlert()
			end
		else
			HideIntruderAlert()
			RemoveHighlight(plot)
		end
	end)
end
DetectIntruders()

   
task.spawn(function()
    while wait(1) do
    pcall(function()
        local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
             pingLabel.Text = "Ping: " .. (ping < 1000 and ping or math.floor(ping / 10) * 10) .. " ms"---PING

        local fpsValue = math.floor(game:GetService("Stats").Workspace["Heartbeat"]:GetValue())
             Fps.Text = "FPS: " .. tostring(fpsValue)
             		 	
              Cash.Text = "Cash: " .. formatNumber(lplr.leaderstats.Cash.value)
			
             Rebiths.Text = "Rebirths: " .. tostring(lplr.leaderstats.Rebirths.Value)
            			
				local rebirthValue = lplr.leaderstats.Rebirths.Value
				local strengthValue = lplr.leaderstats.Cash.Value
				local nextRequirement = getRightSideNumber()
				statusLabel.Text = string.format(
				    "%s/%s\n%s",
				    formatNumber(nextRequirement),
				    formatNumber(strengthValue),
				    formatNumber(rebirthValue)
				)		
				local currentRebirthValue = lplr.leaderstats.Rebirths.Value
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
         end)        
    end
end)



--Script marcar Mascota
local savedFile = "mascotas_guardadas.txt"
local mascotasPrevias = {}
local ultimoLadron = nil
local beamObject = nil

local function getMyPlot()
	for _, plot in pairs(workspace.Plots:GetChildren()) do
		local label = plot:FindFirstChild("PlotSign")
			and plot.PlotSign:FindFirstChild("SurfaceGui")
			and plot.PlotSign.SurfaceGui:FindFirstChild("Frame")
			and plot.PlotSign.SurfaceGui.Frame:FindFirstChild("TextLabel")
		if label then
			local name = label.Text:match("^(.-)'s Base$") or ""
			if name == lplr.Name or name == lplr.DisplayName then
				return plot
			end
		end
	end
	return nil
end

local function getPetNames(plot)
	local names = {}
	local podiums = plot:FindFirstChild("AnimalPodiums")
	if not podiums then return names end
	for _, podium in ipairs(podiums:GetChildren()) do
		local overhead = podium:FindFirstChild("Base")
			and podium.Base:FindFirstChild("Spawn")
			and podium.Base.Spawn:FindFirstChild("Attachment")
			and podium.Base.Spawn.Attachment:FindFirstChild("AnimalOverhead")
		if overhead then
			local nameLabel = overhead:FindFirstChild("DisplayName")
			local name = nameLabel and nameLabel.Text or ""
			if name ~= "" then
				table.insert(names, name)
			end
		end
	end
	return names
end

local function anyStolenVisible(plot)
	local podiums = plot:FindFirstChild("AnimalPodiums")
	if not podiums then return false end
	for _, podium in ipairs(podiums:GetChildren()) do
		local overhead = podium:FindFirstChild("Base")
			and podium.Base:FindFirstChild("Spawn")
			and podium.Base.Spawn:FindFirstChild("Attachment")
			and podium.Base.Spawn.Attachment:FindFirstChild("AnimalOverhead")
		if overhead and overhead:FindFirstChild("Stolen") then
			if overhead.Stolen.Visible == true then
				return true
			end
		end
	end
	return false
end

local function guardarMascotas(mascotas)
	if writefile then
		local data = table.concat(mascotas, "\n")
		writefile(savedFile, data)
	end
end

local function sonDiferentes(t1, t2)
	if #t1 ~= #t2 then return true end
	local mapa = {}
	for _, v in ipairs(t1) do mapa[v] = (mapa[v] or 0) + 1 end
	for _, v in ipairs(t2) do
		if not mapa[v] or mapa[v] == 0 then return true end
		mapa[v] = mapa[v] - 1
	end
	return false
end

local function quitarAntena()
	if beamObject then
		local a0 = beamObject.Attachment0
		local a1 = beamObject.Attachment1
		beamObject:Destroy()
		if a0 then a0:Destroy() end
		if a1 then a1:Destroy() end
		beamObject = nil
	end
end

local function crearBeam(plr)
	quitarAntena()
	local miHRP = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
	local otroHRP = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not miHRP or not otroHRP then return end
	local a1 = Instance.new("Attachment", miHRP)
	local a2 = Instance.new("Attachment", otroHRP)
	local beam = Instance.new("Beam")
	beam.Attachment0 = a1
	beam.Attachment1 = a2
	beam.Width0 = 0.5
	beam.Width1 = 0.5
	beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
	beam.LightEmission = 1
	beam.Transparency = NumberSequence.new(0)
	beam.Name = "SpyLink"
	beam.Parent = a1
	beamObject = beam
end

local function conectarPersonaje(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.Died:Connect(function()
		local plot = getMyPlot()
		if plot and not anyStolenVisible(plot) then
			quitarAntena()
		end
	end)
end

local function crearAntenaEntreTuY(plr)
	crearBeam(plr)
	conectarPersonaje(lplr.Character)
	lplr.CharacterAdded:Connect(function(character)
		conectarPersonaje(character)
		task.wait(0.1)
		crearBeam(plr)
	end)
end

local function marcarLadron(plr)
	if not plr or not plr.Character then return end
	if not plr.Character:FindFirstChild("LadrónBorde") then
		local sel = Instance.new("SelectionBox")
		sel.Name = "LadrónBorde"
		sel.Adornee = plr.Character
		sel.Color3 = Color3.fromRGB(255, 0, 0)
		sel.LineThickness = 0.05
		sel.SurfaceTransparency = 0.8
		sel.Transparency = 0
		sel.Parent = plr.Character
	end
end

local function quitarMarcaLadron(plr)
	if not plr or not plr.Character then return end
	local borde = plr.Character:FindFirstChild("LadrónBorde")
	if borde then borde:Destroy() end
end

local screenGui = Instance.new("ScreenGui", lplr:WaitForChild("PlayerGui"))
screenGui.Name = "LadronGui"
local textLabel = Instance.new("TextLabel", screenGui)
textLabel.Size = UDim2.new(0, 300, 0, 50)
textLabel.Position = UDim2.new(0.5, -150, 0.1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = 24
textLabel.Visible = false

task.spawn(function()
	while true do
		pcall(function()
			if getIsActive6 and getIsActive6() then
				local plot = getMyPlot()
				if plot then
					local mascotasActuales = getPetNames(plot)
					local mascotaRobada = anyStolenVisible(plot)
					if mascotaRobada then
						if not ultimoLadron then
							for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
								if plr ~= lplr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
									ultimoLadron = plr
									break
								end
							end
						end
						if ultimoLadron then
							textLabel.Text = "Ladrón: " .. (ultimoLadron.DisplayName or ultimoLadron.Name)
							textLabel.Visible = true
							if not beamObject then crearAntenaEntreTuY(ultimoLadron) end
							marcarLadron(ultimoLadron)
						end
					else
						textLabel.Visible = false
						quitarAntena()
						if ultimoLadron then
							quitarMarcaLadron(ultimoLadron)
							ultimoLadron = nil
						end
					end
					if sonDiferentes(mascotasPrevias, mascotasActuales) then
						guardarMascotas(mascotasActuales)
						mascotasPrevias = mascotasActuales
					end
				end
			else
				textLabel.Visible = false
				quitarAntena()
				if ultimoLadron then
					quitarMarcaLadron(ultimoLadron)
					ultimoLadron = nil
				end
			end
		end)
		task.wait()
	end
end)



--Dectetar mascotas Base/Fila
local lplr = game.Players.LocalPlayer
local playerGui = lplr:WaitForChild("PlayerGui")

local function parseMoney(text)
	text = string.lower(text)
	local number = tonumber(text:match("%d+%.?%d*")) or 0
	if text:find("k") then
		return number * 1000
	elseif text:find("m") then
		return number * 1000000
	else
		return number
	end
end

local function Plots()
	for _, plot in pairs(workspace.Plots:GetChildren()) do
		local sign = plot:FindFirstChild("PlotSign")
		local gui = sign and sign:FindFirstChild("SurfaceGui")
		local frame = gui and gui:FindFirstChild("Frame")
		local label = frame and frame:FindFirstChild("TextLabel")
		if label then
			local name = label.Text:match("^(.-)'s Base$") or ""
			if name == lplr.Name or name == lplr.DisplayName then
				return plot
			end
		end
	end
	return nil
end

local function getMascotasDelPlot(plot)
	if not plot then return {} end
	local mascotas = {}
	local podiums = plot:FindFirstChild("AnimalPodiums")
	if not podiums then return mascotas end

	for _, desc in pairs(podiums:GetDescendants()) do
		if desc.Name == "Spawn" then
			local spawn = desc
			local overhead = spawn:FindFirstChild("Attachment") and spawn.Attachment:FindFirstChild("AnimalOverhead")
			if overhead then
				local gen = overhead:FindFirstChild("Generation")
				local name = overhead:FindFirstChild("DisplayName")
				if gen and name then
					table.insert(mascotas, {
						model = spawn,
						nombre = name.Text,
						generacion = gen.Text,
						valorGen = parseMoney(gen.Text)
					})
				end
			end
		end
	end

	table.sort(mascotas, function(a, b)
		return a.valorGen > b.valorGen
	end)

	return mascotas
end

local function getTodasMascotasFila()
	local mascotas = {}
	for _, animal in pairs(workspace.MovingAnimals:GetChildren()) do
		local root = animal:FindFirstChild("HumanoidRootPart")
		local overhead = root and root:FindFirstChild("Info") and root.Info:FindFirstChild("AnimalOverhead")
		if overhead then
			local gen = overhead:FindFirstChild("Generation")
			local name = overhead:FindFirstChild("DisplayName")
			if gen and name then
				table.insert(mascotas, {
					model = animal,
					nombre = name.Text,
					generacion = gen.Text,
					valorGen = parseMoney(gen.Text)
				})
			end
		end
	end

	table.sort(mascotas, function(a, b)
		return a.valorGen > b.valorGen
	end)

	return mascotas
end

local function compararListas(lista1, lista2)
	if #lista1 ~= #lista2 then return false end
	for i = 1, #lista1 do
		if lista1[i].nombre ~= lista2[i].nombre or lista1[i].generacion ~= lista2[i].generacion then
			return false
		end
	end
	return true
end

local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "MascotasInfoGui"
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 250, 0, 260)
mainFrame.Position = UDim2.new(0, 10, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(100, 100, 255)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, -60, 0, 20)
titleLabel.Position = UDim2.new(0, 10, 0, 2)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🐉 Base Pests"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextWrapped = true

local toggleButton = Instance.new("TextButton", mainFrame)
toggleButton.Size = UDim2.new(0, 25, 0, 25)
toggleButton.Position = UDim2.new(1, -35, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
toggleButton.TextColor3 = Color3.fromRGB(200, 200, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.Text = "▶"
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

local textBox = Instance.new("TextBox", mainFrame)
textBox.Size = UDim2.new(1, -20, 0, 20)
textBox.Position = UDim2.new(0, 10, 0, 10)
textBox.PlaceholderText = "Min Gen (e.g. 100, 1k, 1m)"
textBox.Text = ""
textBox.Visible = false
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
textBox.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local scrolling = Instance.new("ScrollingFrame", mainFrame)
scrolling.Size = UDim2.new(1, 0, 1, -55)
scrolling.Position = UDim2.new(0, 0, 0, 35)
scrolling.BackgroundTransparency = 1
scrolling.ScrollBarThickness = 6
scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
scrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrolling.ScrollingDirection = Enum.ScrollingDirection.Y

local mostrarBase = true
local lastPets = {}
local lastAlerted = {}
local camResetTask = nil

local function resetCamera()
	local cam = workspace.CurrentCamera
	local humanoid = lplr.Character and lplr.Character:FindFirstChild("Humanoid")
	cam.CameraSubject = humanoid or cam
	camResetTask = nil
end

toggleButton.MouseButton1Click:Connect(function()
	mostrarBase = not mostrarBase
	lastPets = {}

	if mostrarBase then
		titleLabel.Text = "🐉 Base Pests"
		textBox.Visible = false
		textBox.Position = UDim2.new(0, 10, 0, 10)
		scrolling.Position = UDim2.new(0, 0, 0, 35)
		scrolling.Size = UDim2.new(1, 0, 1, -55)
	else
		titleLabel.Text = "🐉 Row Pests"
		textBox.Visible = true
		textBox.Position = UDim2.new(0, 10, 0, 28)
		scrolling.Position = UDim2.new(0, 0, 0, 55)
		scrolling.Size = UDim2.new(1, 0, 1, -55)
	end
end)

task.spawn(function()
	while true do
		pcall(function()
			if not getIsActive4() then
				screenGui.Enabled = false
				task.wait()
				return
			else
				screenGui.Enabled = true
			end

			local mascotas
			if mostrarBase then
				local plot = Plots()
				mascotas = getMascotasDelPlot(plot)
			else
				mascotas = getTodasMascotasFila()
			end

			if not compararListas(lastPets, mascotas) then
				lastPets = mascotas
				scrolling:ClearAllChildren()
				local y = 0

				local maxFontSize = 16
				local minFontSize = 10
				local labelWidth = 244

				for i, m in ipairs(mascotas) do
					local petLabel = Instance.new("TextLabel", scrolling)
					petLabel.BackgroundTransparency = 1
					petLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					petLabel.Font = Enum.Font.Gotham
					petLabel.TextWrapped = false
					petLabel.TextXAlignment = Enum.TextXAlignment.Left
					petLabel.Position = UDim2.new(0, 3, 0, y)
					petLabel.Text = string.format("%d. %s | Gen: %s", i, m.nombre, m.generacion)

					local fontSize = maxFontSize
					petLabel.TextSize = fontSize

					while petLabel.TextBounds.X > labelWidth and fontSize > minFontSize do
						fontSize = fontSize - 1
						petLabel.TextSize = fontSize
					end

					petLabel.TextWrapped = true
					local textHeight = petLabel.TextBounds.Y
					petLabel.Size = UDim2.new(1, -6, 0, textHeight)
					y = y + textHeight + 4
				end

				scrolling.CanvasSize = UDim2.new(0, 0, 0, y)
			end

			if not mostrarBase and textBox.Text ~= "" then
				local min = parseMoney(textBox.Text)
				local cam = workspace.CurrentCamera
				local shouldReset = true
				for _, pet in ipairs(lastPets) do
					if pet.valorGen >= min or (mostrarBase and pet.valorGen >= 1000) then
						if pet.valorGen >= min then
							shouldReset = false
						end
						if not lastAlerted[pet.nombre] then
							lastAlerted[pet.nombre] = true
							local humanoidRootPart = pet.model:FindFirstChild("HumanoidRootPart") or pet.model:FindFirstChildWhichIsA("BasePart")
							if humanoidRootPart then
								cam.CameraSubject = humanoidRootPart
								if camResetTask then
									camResetTask:Cancel()
								end
								camResetTask = task.delay(3, resetCamera)
								break
							end
						end
					end
				end
				if shouldReset and camResetTask then
					camResetTask:Cancel()
					resetCamera()
				end
			elseif camResetTask then
				camResetTask:Cancel()
				resetCamera()
			end
		end)
		task.wait(.5)
	end
end)



--Ir ah comprar Mascotas 
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local fileName = "minGeneracionPet.txt"

local function loadGeneracion()
	if isfile(fileName) then
		local contenido = readfile(fileName)
		local val = tonumber(contenido)
		if val then return val end
	end
	return nil
end

local function saveGeneracion(valor)
	writefile(fileName, tostring(valor))
end

local minGeneracion = loadGeneracion()

local function parseMoney(text)
	text = string.lower(text)
	local number = tonumber(text:match("%d+%.?%d*")) or 0
	if text:find("k") then
		return number * 1000
	elseif text:find("m") then
		return number * 1000000
	else
		return number
	end
end

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetAutoBuyGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 280, 0, 200)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
frame.Active = true
frame.Draggable = true
frame.Visible = false

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

local titulo = Instance.new("TextLabel", frame)
titulo.Size = UDim2.new(1, -20, 0, 30)
titulo.Position = UDim2.new(0, 10, 0, 10)
titulo.BackgroundTransparency = 1
titulo.Text = "🐾 Mejor Pet Disponible 🐾"
titulo.Font = Enum.Font.GothamBold
titulo.TextSize = 20
titulo.TextColor3 = Color3.fromRGB(255, 215, 100)

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1, -20, 0, 90)
info.Position = UDim2.new(0, 10, 0, 45)
info.BackgroundTransparency = 1
info.Text = ""
info.Font = Enum.Font.Gotham
info.TextSize = 16
info.TextColor3 = Color3.fromRGB(230, 230, 230)
info.TextWrapped = true
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top

local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(1, -20, 0, 40)
input.Position = UDim2.new(0, 10, 1, -50)
input.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.Font = Enum.Font.Gotham
input.TextSize = 18
input.PlaceholderText = "Generación mínima"
input.Text = minGeneracion and tostring(minGeneracion) or ""
input.ClearTextOnFocus = false
input.TextXAlignment = Enum.TextXAlignment.Left

local inputCorner = Instance.new("UICorner", input)
inputCorner.CornerRadius = UDim.new(0, 8)

input.FocusLost:Connect(function()
	local val = tonumber(input.Text)
	if val then
		minGeneracion = val
		saveGeneracion(val)
	else
		minGeneracion = nil
		saveGeneracion("")
		input.Text = ""
	end
end)

local bordes = {}
for _ = 1, 4 do
	local p = Instance.new("Part")
	p.Anchored = true
	p.CanCollide = false
	p.Material = Enum.Material.Neon
	p.Color = Color3.fromRGB(0, 255, 0)
	p.Size = Vector3.new(1, 0.2, 0.2)
	p.Transparency = 0.2
	p.Parent = workspace
	table.insert(bordes, p)
end

local function updateBorde(pos)
	local w, h, y = 6, 6, pos.Y + 0.5
	bordes[1].Size = Vector3.new(w, 0.2, 0.2)
	bordes[2].Size = Vector3.new(w, 0.2, 0.2)
	bordes[3].Size = Vector3.new(0.2, 0.2, h)
	bordes[4].Size = Vector3.new(0.2, 0.2, h)
	bordes[1].Position = Vector3.new(pos.X, y, pos.Z - h / 2)
	bordes[2].Position = Vector3.new(pos.X, y, pos.Z + h / 2)
	bordes[3].Position = Vector3.new(pos.X - w / 2, y, pos.Z)
	bordes[4].Position = Vector3.new(pos.X + w / 2, y, pos.Z)
end

local function hideBorde()
	for _, b in ipairs(bordes) do
		b.Position = Vector3.new(0, -1000, 0)
	end
end

local function buscarMejorMascota()
	if not minGeneracion then return nil end
	local best = nil
	local maxGen = minGeneracion
	local dinero = player.leaderstats and player.leaderstats.Cash and player.leaderstats.Cash.Value or 0
	for _, a in pairs(workspace:WaitForChild("MovingAnimals"):GetChildren()) do
		local root = a:FindFirstChild("HumanoidRootPart")
		local oh = root and root:FindFirstChild("Info") and root.Info:FindFirstChild("AnimalOverhead")
		if oh then
			local gen = parseMoney(oh:FindFirstChild("Generation") and oh.Generation.Text or "0")
			local precio = parseMoney(oh:FindFirstChild("Price") and oh.Price.Text or "0")
			local nombre = oh:FindFirstChild("DisplayName") and oh.DisplayName.Text or "Sin Nombre"
			if gen >= maxGen and precio <= dinero then
				maxGen = gen
				best = { nombre = nombre, gen = gen, precio = precio, modelo = a }
			end
		end
	end
	return best
end

local ultimaPos = nil
local comprando = false

game:GetService("RunService").RenderStepped:Connect(function()
	if not getIsActive8 or not getIsActive8() then
		frame.Visible = false
		hideBorde()
		return
	end

	if comprando then
		return
	end

	frame.Visible = true
	local mascota = buscarMejorMascota()
	if mascota then
		info.Text = "🦴 " .. mascota.nombre .. "\n💰 Gen: " .. mascota.gen .. "\n💵 Precio: " .. mascota.precio
		local pos = mascota.modelo:GetModelCFrame().Position
		updateBorde(pos)
		if not ultimaPos or (ultimaPos - pos).Magnitude > 4 then
			ultimaPos = pos
			character.Humanoid:MoveTo(Vector3.new(pos.X, character.HumanoidRootPart.Position.Y, pos.Z))
		end
		if (character.HumanoidRootPart.Position - pos).Magnitude < 6 then
			local prompt = mascota.modelo:FindFirstChildWhichIsA("ProximityPrompt", true)
			if prompt then
				comprando = true
				fireproximityprompt(prompt)
				delay(1, function()
					comprando = false
				end)
			end
		end
	else
		info.Text = "❌ Ninguna mascota válida"
		hideBorde()
	end
end)


local lplr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", lplr:WaitForChild("PlayerGui"))
local label = Instance.new("TextLabel", Barra1)
label.Size = UDim2.new(0, 150, 0, 15)
label.Position = UDim2.new(0.420, 0, 0.03, 0)
label.AnchorPoint = Vector2.new(0.5, 0)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = "🔒 Lock: --"

game:GetService("RunService").RenderStepped:Connect(function()
	for _, plot in pairs(workspace.Plots:GetChildren()) do
		local sign = plot:FindFirstChild("PlotSign")
		local textLabel = sign and sign:FindFirstChild("SurfaceGui") and sign.SurfaceGui:FindFirstChild("Frame") and sign.SurfaceGui.Frame:FindFirstChild("TextLabel")
		if textLabel and textLabel.Text:find(lplr.DisplayName) then
			local remaining = plot:FindFirstChild("Purchases") and plot.Purchases:FindFirstChild("PlotBlock") and plot.Purchases.PlotBlock:FindFirstChild("Main") and plot.Purchases.PlotBlock.Main:FindFirstChild("BillboardGui") and plot.Purchases.PlotBlock.Main.BillboardGui:FindFirstChild("RemainingTime")
			if remaining and remaining:IsA("TextLabel") then
				local rawText = remaining.Text
				local numStr = rawText:match("(%d+%.?%d*)") or rawText:match("(%d+)") -- intenta con decimal o entero
				local num = tonumber(numStr)
				if num then
					label.Text = "🔒 Lock: " .. num
					if num >= 16 then
						label.TextColor3 = Color3.new(1, 0, 0)
					else
						label.TextColor3 = Color3.new(0, 1, 0)
					end
				else
					label.Text = "🔒 Lock: --"
					label.TextColor3 = Color3.new(1,1,1)
				end
			end
			break
		end
	end
end)

task.spawn(function()
    while task.wait() do
    pcall(function()
    if getIsActive9() then
game:GetService("ReplicatedStorage").Packages.Net["RF/Rebirth/RequestRebirth"]:InvokeServer()
        end
   end)
 end
end)


--Dectetar bases Mascota más Fuerte
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")


local function extractOwner(text)
    local name = text:match("^(.-)'s Base$") or text:match("^(.-) Base$") or text
    if name and name:lower():find("empty") then return nil end
    return name
end

local function parseGenerate(text)
    local numPart, suffix = text:match("([%d%.]+)([KMB]?)")
    local num = tonumber(numPart) or 0
    if suffix == "K" then num = num * 1e3
    elseif suffix == "M" then num = num * 1e6
    elseif suffix == "B" then num = num * 1e9
    end
    return num
end

local function findStrongestPet()
    local maxGenerate = -math.huge
    local strongestPetData = nil
    local plotsFolder = workspace:FindFirstChild("Plots")
    if not plotsFolder then return nil end
    for _, plot in ipairs(plotsFolder:GetChildren()) do
        local sign = plot:FindFirstChild("PlotSign")
        if not sign then continue end
        local surfaceGui = sign:FindFirstChildWhichIsA("SurfaceGui")
        if not surfaceGui then continue end
        local frame = surfaceGui:FindFirstChild("Frame")
        if not frame then continue end
        local ownerName = extractOwner(frame:FindFirstChildWhichIsA("TextLabel") and frame:FindFirstChildWhichIsA("TextLabel").Text)
        if not ownerName then continue end
        if ownerName == LocalPlayer.DisplayName then continue end
        local animalPodiums = plot:FindFirstChild("AnimalPodiums")
        if not animalPodiums then continue end
        for _, podium in ipairs(animalPodiums:GetChildren()) do
            local spawn = podium.Base and podium.Base:FindFirstChild("Spawn")
            if not spawn then continue end
            local attachment = spawn:FindFirstChild("Attachment")
            if not attachment then continue end
            local animalOverhead = attachment:FindFirstChild("AnimalOverhead")
            if not animalOverhead then continue end
            local generateLabel = animalOverhead:FindFirstChild("Generation")
            local displayNameLabel = animalOverhead:FindFirstChild("DisplayName")
            if generateLabel and displayNameLabel and generateLabel:IsA("TextLabel") and displayNameLabel:IsA("TextLabel") then
                local genValue = parseGenerate(generateLabel.Text)
                if genValue > maxGenerate then
                    maxGenerate = genValue
                    strongestPetData = { name = displayNameLabel.Text, generateText = generateLabel.Text, part = spawn }
                end
            end
        end
    end
    return strongestPetData
end

local function createPetBillboard(petData)
    if not petData or not petData.part then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "StrongestPetBillboard"
    billboard.Adornee = petData.part
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.LightInfluence = 0
    billboard.Parent = petData.part
    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextScaled = true
    textLabel.Text = petData.name .. " | " .. petData.generateText
    billboard.Enabled = getIsActive10()
    return billboard
end

local function createLockBillboard(plot, bill)
    local lockGui = Instance.new("BillboardGui", plot)
    lockGui.Name = "LockUI"
    lockGui.Adornee = plot
    lockGui.Size = UDim2.new(0, 150, 0, 30)
    lockGui.StudsOffset = Vector3.new(0, 10, 0)
    lockGui.AlwaysOnTop = true
    lockGui.MaxDistance = 500
    local lockLabel = Instance.new("TextLabel", lockGui)
    lockLabel.Size = UDim2.new(1, 0, 1, 0)
    lockLabel.BackgroundTransparency = 1
    lockLabel.TextScaled = true
    lockLabel.Font = Enum.Font.SourceSansBold
    lockLabel.TextColor3 = Color3.new(1, 1, 1)
    lockLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    lockLabel.TextStrokeTransparency = 0
    lockLabel.Text = "🔒 Lock: --"
    lockGui.Enabled = getIsActive10()
    RunService.RenderStepped:Connect(function()
        local text = bill.Text
        local numStr = text:match("(%d+%.?%d*)") or text:match("(%d+)")
        local num = tonumber(numStr)
        if num then
            lockLabel.Text = "🔒 Lock: " .. num
        end
        lockGui.Enabled = getIsActive10()
    end)
end

local function updateLockForPlot(plot)
    local existingLock = plot:FindFirstChild("LockUI")
    if existingLock then existingLock:Destroy() end
    local sign = plot:FindFirstChild("PlotSign")
    if not sign then return end
    local surfaceGui = sign:FindFirstChildWhichIsA("SurfaceGui")
    if not surfaceGui then return end
    local frame = surfaceGui:FindFirstChild("Frame")
    if not frame then return end
    local ownerName = extractOwner(frame:FindFirstChildWhichIsA("TextLabel") and frame:FindFirstChildWhichIsA("TextLabel").Text)
    if not ownerName then return end
    if ownerName == LocalPlayer.DisplayName then return end
    local purchases = plot:FindFirstChild("Purchases")
    local main = purchases and purchases:FindFirstChild("PlotBlock") and purchases.PlotBlock:FindFirstChild("Main")
    local bill = main and main:FindFirstChild("BillboardGui") and main.BillboardGui:FindFirstChild("RemainingTime")
    if bill and bill:IsA("TextLabel") then
        createLockBillboard(plot, bill)
    end
end

local function listenPlotChanges(plot)
    plot.ChildAdded:Connect(function(child)
        if child.Name == "PlotSign" or child.Name == "Purchases" then
            updateLockForPlot(plot)
        end
    end)
    plot.ChildRemoved:Connect(function(child)
        if child.Name == "PlotSign" or child.Name == "Purchases" then
            updateLockForPlot(plot)
        end
    end)
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local surfaceGui = sign:FindFirstChildWhichIsA("SurfaceGui")
        if surfaceGui then
            local frame = surfaceGui:FindFirstChild("Frame")
            if frame then
                for _, textLabel in ipairs(frame:GetChildren()) do
                    if textLabel:IsA("TextLabel") then
                        textLabel.Changed:Connect(function()
                            updateLockForPlot(plot)
                        end)
                    end
                end
            end
        end
    end
end

local function processLocksDynamic()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return end
    for _, plot in ipairs(plots:GetChildren()) do
        updateLockForPlot(plot)
        listenPlotChanges(plot)
    end
    plots.ChildAdded:Connect(function(newPlot)
        updateLockForPlot(newPlot)
        listenPlotChanges(newPlot)
    end)
end

local currentPetGui = nil

RunService.Heartbeat:Connect(function()
    local success, petData = pcall(findStrongestPet)
    if success and petData then
        if not currentPetGui or currentPetGui.Adornee ~= petData.part then
            if currentPetGui then currentPetGui:Destroy() end
            currentPetGui = createPetBillboard(petData)
        end
        if currentPetGui then currentPetGui.Enabled = getIsActive10() end
    else
        if currentPetGui then
            currentPetGui:Destroy()
            currentPetGui = nil
        end
    end
end)

processLocksDynamic()

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