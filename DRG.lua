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
local lplr = game.Players.LocalPlayer
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)
local Ex = game:GetService("ReplicatedStorage").Package.Events

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
TextLabel.Text = "DBU                                                "
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

local ligaLabel = Instance.new("TextLabel")
ligaLabel.Size = UDim2.new(0, 200, 0, 50)
ligaLabel.Position = UDim2.new(0.5, -210, 0.5, -25)
ligaLabel.Text = "Loading..."
ligaLabel.TextSize = 24
ligaLabel.TextStrokeTransparency = 0.8
ligaLabel.BackgroundTransparency = 1
ligaLabel.Parent = TextLabel

local questLabel = Instance.new("TextLabel")
questLabel.Size = UDim2.new(0, 200, 0, 30)
questLabel.Position = UDim2.new(0.3, 36, 0, 0)
questLabel.BackgroundTransparency = 1
questLabel.TextSize = 9
questLabel.Text = "Mission: | Form: "
questLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
questLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
questLabel.TextStrokeTransparency = 0
questLabel.TextScaled = false
questLabel.Parent = TextLabel


local userId = lplr.UserId
local thumbnailUrl = game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 58, 0, 58)
imageLabel.Position = UDim2.new(0.07, 0, 0.04, 0)
imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = thumbnailUrl
imageLabel.Parent = Barra1

local masteryLabel = Instance.new("TextLabel")
masteryLabel.Size = UDim2.new(0, 100, 0, 10)
masteryLabel.Position = UDim2.new(0.120, 0, 0.009, 0)
masteryLabel.BackgroundTransparency = 1
masteryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
masteryLabel.TextScaled = true
masteryLabel.Text = "Mastery"
masteryLabel.Parent = Barra1


local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 100, 0, 23)
statusLabel.Position = UDim2.new(0.134, 0, 0.03, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.Text = "Stats..."
statusLabel.Parent = Barra1

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


local tierra = Instance.new("ImageButton", Barra2)
tierra.Size = UDim2.new(0, 31, 0, 31)
tierra.Position = UDim2.new(0.440, 0, 0.205, 0)
tierra.BackgroundTransparency = 1
tierra.Image = "rbxassetid://105319560378349"
tierra.MouseButton1Click:Connect(function()
    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
end)

local UICorner_1 = Instance.new("UICorner")
UICorner_1.CornerRadius = UDim.new(0, 5)
UICorner_1.Parent = tierra

local bills = Instance.new("ImageButton", Barra2)
bills.Size = UDim2.new(0, 41, 0, 41)
bills.Position = UDim2.new(0.03, 0, 0.205, 0)
bills.BackgroundTransparency = 1
bills.Image = "rbxassetid://17345700746"
bills.MouseButton1Click:Connect(function()
    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
end)

local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(0, 12)
UICorner_2.Parent = bills

local grvd = Instance.new("ImageButton", Barra2)
grvd.Size = UDim2.new(0, 41, 0, 41)
grvd.Position = UDim2.new(0.165, 0, 0.205, 0)
grvd.BackgroundTransparency = 1
grvd.Image = "rbxassetid://129453529806060"
grvd.MouseButton1Click:Connect(function()
    Ex.TP:InvokeServer("Gravity Room")
end)

local UICorner_3 = Instance.new("UICorner")
UICorner_3.CornerRadius = UDim.new(0, 10)
UICorner_3.Parent = grvd

local time = Instance.new("ImageButton", Barra2)
time.Size = UDim2.new(0, 41, 0, 41)
time.Position = UDim2.new(0.3, 0, 0.205, 0)
time.BackgroundTransparency = 1
time.Image = "rbxassetid://126015597245029"
time.MouseButton1Click:Connect(function()
Ex.TP:InvokeServer("Hyperbolic Time Chamber")
end)

local UICorner_4 = Instance.new("UICorner")
UICorner_4.CornerRadius = UDim.new(0, 10)
UICorner_4.Parent = time


local Contenedor = Instance.new("ScrollingFrame", Barra1)
Contenedor.Size = UDim2.new(0, 400, 0, 200)
Contenedor.Position = UDim2.new(0.490, 0, 0.731, 0)
Contenedor.AnchorPoint = Vector2.new(0.5, 0.5)
Contenedor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Contenedor.BorderSizePixel = 0
Contenedor.ScrollBarThickness = 6
Contenedor.CanvasSize = UDim2.new(0, 0, 0, 400)
Contenedor.ScrollingDirection = Enum.ScrollingDirection.Y


--Multi Rebirths

local inputBox = Instance.new("TextBox", Barra1)
inputBox.Size = UDim2.new(0, 84, 0, 30)
inputBox.Position = UDim2.new(0.735, 0, 0.195, 0)
inputBox.PlaceholderText = "Cantidad (Max 20)"
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.ClearTextOnFocus = false
inputBox.Name = "RebirthInput"
inputBox.TextScaled = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = inputBox

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(128, 0, 0)
UIStroke.Thickness = 2
UIStroke.Parent = inputBox

local MAX_VALOR = 23
local valorGuardado = 4

if isfile("rebirthAmount.txt") then
    local contenido = tonumber(readfile("rebirthAmount.txt"))
    if contenido then
        valorGuardado = math.clamp(contenido, 1, MAX_VALOR)
    end
end

inputBox.Text = tostring(valorGuardado)

local function guardar(valor)
    local num = tonumber(valor)
    if num then
        num = math.clamp(num, 1, MAX_VALOR)
        valorGuardado = num
        inputBox.Text = tostring(num)
        writefile("rebirthAmount.txt", tostring(num))
    else
        inputBox.Text = tostring(valorGuardado)
    end
end

inputBox.FocusLost:Connect(function()
    guardar(inputBox.Text)
end)

inputBox:GetPropertyChangedSignal("Text"):Connect(function()
    local onlyNumbers = inputBox.Text:gsub("%D", "")
    inputBox.Text = onlyNumbers
    if onlyNumbers ~= "" then
        guardar(onlyNumbers)
    end
end)


local Selct = Instance.new("ScrollingFrame", Barra2)  
Selct.Size = UDim2.new(0, 110, 0, 190)  
Selct.Position = UDim2.new(0.820, 0, 0.165, 0)  
Selct.AnchorPoint = Vector2.new(0.5, 0.5)  
Selct.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
Selct.BorderSizePixel = 0  
Selct.ScrollBarThickness = 5
Selct.ScrollingDirection = Enum.ScrollingDirection.Y  
Selct.CanvasSize = UDim2.new(0, 0, 0, 0)  -- lo actualizaremos después

local forms = { 'Ultra Super Villain', 'Nephalem', 'Seraphim Of Destruction', 'Seraphim', 'Ego Instinct 2', 'Ego Instinct', 'Divine Rose Prominence', 'Divine Blue', 'God of Destruction', 'God of Creation', 'Beast', 'Mastered Ultra Instinct', 'SSJR2', 'SSJB2', 'Ultra Instinct Omen', 'Dark Rose', 'Blue Evolution', 'SSJ Rose', 'SSJ Blue', 'SSJ4', 'SSJG', 'Mystic', 'SSJ3', 'LSSJ', 'SSJ2', 'SSJ', 'FSSJ', 'Kaioken' }

local frame = Instance.new("Frame", Selct)  
frame.Size = UDim2.new(1, 0, 0, 0)  -- ancho igual al ScrollingFrame, altura dinámica  
frame.Position = UDim2.new(0, 0, 0, 0)  
frame.BackgroundTransparency = 1  

local list = Instance.new("UIListLayout", frame)  
list.Padding = UDim.new(0, 5)  -- separacion entre botones  
list.SortOrder = Enum.SortOrder.LayoutOrder





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
    {text = "...", position = UDim2.new(0.350 + 0, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Reb|Stats", position = UDim2.new(-0.160 + 0.170, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255), parent = Barra1, size = UDim2.new(0, 75, 0, 36)},
    {text = "MltReb", position = UDim2.new(0.360 + 0, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "...", position = UDim2.new(-0.160 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "...", position = UDim2.new(0.350 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Fly", position = UDim2.new(-0.04 + 0, 0, 0.320, 0), color = Color3.fromRGB(200, 200, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Brillo", position = UDim2.new(0.473 + 0, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Duck", position = UDim2.new(-0.160 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Protect", position = UDim2.new(0.350 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Req", position = UDim2.new(-0.160 + 0, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Tp|Planet", position = UDim2.new(0.350 + 0.170, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 80, 0, 36)},
    {text = "Form", position = UDim2.new(-0.140 + 0, 0, 0.570, 0), color = Color3.fromRGB(200, 200, 90), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Form|Vip", position = UDim2.new(0.360 + 0.1, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1, size = UDim2.new(0, 100, 0, 36)},
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
local saveFileName = "DBU_Switches.json"
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

--Fly
local activeBar, speed = nil, 0
local flying = true
local function saveValue(name, value)
    writefile(name..".json", HttpService:JSONEncode({v=value,t=os.time()}))
end

local function loadValue(name)
    return isfile(name..".json") and HttpService:JSONDecode(readfile(name..".json")).v or 0
end

--Formas
local selectedForm, transforming = nil, false
local function saveForm(form)
    writefile("SelectedForm.json", game:GetService("HttpService"):JSONEncode({form = form, time = os.time()}))
end

local function loadForm()
    return isfile("SelectedForm.json") and game:GetService("HttpService"):JSONDecode(readfile("SelectedForm.json")).form or nil
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


--Formas
local buttonHeight = 25
for _, form in ipairs(forms) do  
    local btn = Instance.new("TextButton", frame)  
    btn.Size = UDim2.new(0.9, 0, 0, buttonHeight)  
    btn.Text = form  
    btn.TextColor3 = Color3.new(1, 1, 1)  
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)  
    btn.TextScaled = true   
    btn.TextWrapped = true   
    local corner = Instance.new("UICorner", btn)  
    corner.CornerRadius = UDim.new(0, 12)  
      
    btn.MouseButton1Click:Connect(function()  
        selectedForm = (selectedForm ~= form) and form or nil  
        saveForm(selectedForm)  
        for _, b in ipairs(frame:GetChildren()) do  
            if b:IsA("TextButton") then  
                b.BackgroundColor3 = (b == btn and selectedForm) and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(60, 60, 60)  
            end  
        end  
    end)  
end  

local totalHeight = (#forms * (buttonHeight + list.Padding.Offset)) + list.Padding.Offset
frame.Size = UDim2.new(1, 0, 0, totalHeight)
Selct.CanvasSize = UDim2.new(0, 0, 0, totalHeight)


selectedForm = loadForm()  
if selectedForm then  
    for _, btn in ipairs(frame:GetChildren()) do  
        if btn:IsA("TextButton") and btn.Text == selectedForm then  
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)  
            break  
        end  
    end  
end


--Menu de Contador 1H:30M
local lplr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "TimerGui"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 40)
frame.Position = UDim2.new(0, 20, 0, 20)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.Active = true
frame.Draggable = true

local lbl = Instance.new("TextLabel", frame)
lbl.Size = UDim2.new(1, 0, 1, 0)
lbl.BackgroundTransparency = 1
lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl.TextScaled = true
lbl.Font = Enum.Font.SourceSansBold
lbl.Text = "Tiempo: 1:04:00"

local function destinoFijo()
	local id = game.PlaceId
	if id == 3311165597 then
		return "Earth", 3311165597
	elseif id == 5151400895 then
		return "Vills Planet", 5151400895
	end
end

local function formatTime(seconds)
	local h = math.floor(seconds / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60
	return string.format("%d:%02d:%02d", h, m, s)
end

task.spawn(function()
	local t = 3275
	while task.wait(1) do
		pcall(function()
		t -= 1
		lbl.Text = "Tiempo: " .. formatTime(t)
		if t <= 0 then
			local destino, actualId = destinoFijo()
			if destino then
				repeat
					pcall(function()
						game.ReplicatedStorage.Package.Events.TP:InvokeServer(destino)
					end)
					task.wait()
				until game.PlaceId ~= actualId
			end
			t = 3275
		end
		end)
	end
end)



local getIsActive1 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.120, 0), "DBU1", LoadSwitchState("DBU1")) -- Farm  
local getIsActive2 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.115, 0), "DBU2", LoadSwitchState("DBU2")) -- Form  
local getIsActive3 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.2, 0), "DBU3", LoadSwitchState("DBU3")) -- Rebirth  
local getIsActive5 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.275, 0), "DBU5", LoadSwitchState("DBU5")) -- Black  
local getIsActive6 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.275, 0), "DBU6", LoadSwitchState("DBU6")) -- Hallowen🎃  
local getIsActive7 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.420, 0), "DBU7", LoadSwitchState("DBU7")) -- Duck  
local getIsActive8 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.420, 0), "DBU8", LoadSwitchState("DBU8")) -- Protecion server  
local getIsActive9 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.495, 0), "DBU9", LoadSwitchState("DBU9")) -- Graf  
local getIsActive10 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.495, 0), "DBU10", LoadSwitchState("DBU10")) -- Planet  
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.570, 0), "DBU11", LoadSwitchState("DBU11")) -- Mapa  
local getIsActive12 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.570, 0), "DBU12", LoadSwitchState("DBU12")) -- Klirin

--Barras
createBar(0, "Flight", Color3.fromRGB(255, 0, 0), 0.37, 100, function(v) speed = v end, "flight")
createBar(0.513, "Ambient", Color3.fromRGB(0, 255, 0), 0.37, 700, function(v) Lighting.Ambient = Color3.fromRGB(v, v, v) end, "ambient")


--Casi fin del interrutor /\
--Ciclo Para Auto = Main y Start
spawn(function()
    Ex.Start:InvokeServer()
    lplr.Character.Humanoid:ChangeState(15)
end)


task.spawn(function()
    pcall(function()
local sts = {"Strength", "Speed", "Defense", "Energy"}
function yo()
	local min = nil
	for _, statName in ipairs(sts) do
		local stat = data:FindFirstChild(statName)
		if stat and stat:IsA("IntValue") or stat:IsA("NumberValue") then
			if min == nil or stat.Value < min then
				min = stat.Value
			end
		else
			return 0
		end
	end
	return min or 0
end

local stats = getgenv().Stats
function checkplr()
    found = false
    for i,v in pairs(stats) do
        if v[1] == lplr.Name then
            found = true
            return v -- Name, Reb cap, Stat cap
        end
    end
    local table = {lplr.Name, math.huge, math.huge, true}
    if not found then return table end
end

function player()
	if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
		if lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart") then
			return true
		else
			data.Quest.Value = ""
		end
	end
	return false
end

--SCRIPTS PARA PROTEGER
--Script 1 \/ Para Pausar Los Bucles 
local lplr = game.Players.LocalPlayer
local estadoCongela = false

function Congela()
    return estadoCongela
end
if #game.Players:GetPlayers() == 1 and getIsActive8() then
    task.spawn(function()
        while true do
            pcall(function()
                local players = game.Players:GetPlayers()
                if #players == 1 and players[1] == lplr then
                    estadoCongela = true
                else
                    estadoCongela = false
                end
            end)
            task.wait(.7)
        end
    end)
else
    if getIsActive8() and #game.Players:GetPlayers() > 1 then
        estadoCongela = true 
        elseif not getIsActive8() then
        estadoCongela = true 
    end
end--Script 1 \/ Para Pausar Los Bucles 

--Script 2 \/ Tp ah wiis
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer

local coordenadas = {
    Vector3.new(5054.7, 1288.8, -6006.0),
    Vector3.new(5056.3, 1288.5, -5994.1),
    Vector3.new(5019.3, 1288.8, -6005.7),
    Vector3.new(5041.5, 1288.8, -6008.1),
    Vector3.new(5041.7, 1288.8, -5996.1),
}

local function elegirCoordenada()
    return coordenadas[math.random(#coordenadas)]
end

local function enZona(val)
    local pos = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character.HumanoidRootPart.Position
    if not pos then return false end
    for _, zona in ipairs(coordenadas) do
        if (pos - zona).Magnitude <= val then
            return true
        end
    end
    return false
end

local function teletransportar()
    local char = lplr.Character or lplr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local pos = elegirCoordenada()
    hrp.CFrame = CFrame.new(pos)
end

if #Players:GetPlayers() == 1 and getIsActive8() then
    Players.PlayerAdded:Connect(function(p)
        if p ~= lplr then
            teletransportar()
            task.spawn(function()
                while true do            
                    task.wait()
                    if not enZona(70) then
                        teletransportar()
                    else
                        break
                    end
                end
            end)
        end 
    end)
end--Script 2 \/ Tp ah wiis


--Script 3 \/ Duplicar server
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer

if #Players:GetPlayers() == 1 and getIsActive8() then
task.spawn(function()
    local tpHecho = false
    while not tpHecho do
        pcall(function()
            local char = lplr.Character or lplr.CharacterAdded:Wait()
            if #Players:GetPlayers() > 1 and getIsActive8() then
                local destino = (game.PlaceId == 5151400895) and "Vills Planet" or "Earth"
                game:GetService("ReplicatedStorage").Package.Events.TP:InvokeServer(destino)
                tpHecho = true
             end
          end)
           task.wait(.5)
      end
   end)
end--FIN DE LA PROTECION SCRIPTS


task.spawn(function()
    while task.wait() do
        pcall(function()
            if getIsActive11() and player() and Congela() then
                local Forms = {
                    'Ultra Super Villain',
                    'Nephalem',
                    'Seraphim Of Destruction',
                    'Seraphim',
                    'Ego Instinct 2', 
                    'Ego Instinct',
                    'Divine Rose Prominence',
                    'Divine Blue',
                    'God of Destruction',
                    'God of Creation',
                    'Beast',
                    'Mastered Ultra Instinct',
                    'SSJR2',
                    'SSJB2',
                    'Ultra Instinct Omen',
                    'Dark Rose',
                    'Blue Evolution',
                    'SSJ Rose',
                    'SSJ Blue',
                    'SSJ4',
                    'SSJG',
                    'Mystic',
                    'SSJ3',
                    'LSSJ',
                    'SSJ2',
                    'SSJ',
                    'FSSJ',
                    'Kaioken'
                }
              local status = lplr.Status    
                  for _, form in ipairs(Forms) do 
                   if Ex.equipskill:InvokeServer(form) then break end  
             end
        if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
            Ex.ta:InvokeServer()
            end                
         end      
         if not getIsActive11() and not getIsActive12()  and selectedForm and not transforming and lplr.Status.Transformation.Value ~= selectedForm  then
                  transforming = true
                    pcall(function()
                if Ex.equipskill:InvokeServer(selectedForm) then
                    Ex.ta:InvokeServer()
                    end
                  end)
                transforming = false
              end
        end)
    end
end)
     
     
     
task.spawn(function()
    while task.wait() do
        pcall(function()
        if getIsActive12() and not getIsActive11()  and player() and Congela() then
        local Forms = {                                
                                  'True SSJG',
                                  'Blanco',
                                  'CSSJB3',
                                  'SSJ6',
                                  'SSJB4',
                                  'SSJR4',
                                  'LSSJ5',
                                  'True God of Creation',
                                  'True God of Destruction',
                                  'CSSJB2',
                                  'CSSJB',
                                  'Super Broly',
                                  'LSSJB',
                                  'False God of Destruction',
                                  'False God of Creation',
                                  'SSJG4',
                                  'LSSJ4',
                                  'LSSJ3',
                                  'Mystic Kaioken',
                                  'LSSJ2',
                                  'LSSJ Kaioken',
                                  'SSJ2 Kaioken'}
                             local status = lplr.Status    
                           for _, form in ipairs(Forms) do 
                   if Ex.equipskill:InvokeServer(form) then break end  
             end
        if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
            Ex.ta:InvokeServer()
            end                
         end      
      end)
   end
end)   
     

local tiempo = tick()
task.spawn(function()
    while true do
        pcall(function()
        if Congela() then
            local char = workspace.Living:FindFirstChild(lplr.Name)
            if not char then return end
            local stats = char:FindFirstChild("Stats")
            if not stats then return end
            local ki = stats:FindFirstChild("Ki")
            local maxKi = stats:FindFirstChild("MaxKi")
            if not ki or not maxKi then return end
            if not ki:IsA("NumberValue") or not maxKi:IsA("NumberValue") then return end
            local limite = maxKi.Value * 0.20
            if ki.Value < limite then
                if tick() - tiempo >= 2 then
                    game.ReplicatedStorage.Package.Events.cha:InvokeServer(false, "dbuexploiterssucklol")
                    task.wait(0.1)
                    tiempo = tick()
                end
                game.ReplicatedStorage.Package.Events.cha:InvokeServer(true, "dbuexploiterssucklol")
            else
                game.ReplicatedStorage.Package.Events.cha:InvokeServer(false, "dbuexploiterssucklol")
                tiempo = tick()
               end
            end
         end)
        task.wait()
    end
end)



task.spawn(function()
    while task.wait(.5) do
        pcall(function()
        if player() then
        if getIsActive1()  and data.Quest.Value ~= "" and Congela() then         
           game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol", 1)
           game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol", 2)
               end          
            end --player() 
         end)         
      end
  end)
  
  
task.spawn(function()
    while task.wait() do
        pcall(function()
            if getIsActive1() and player() and Congela() then
                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        end)
    end
end)


local multipliers = {
    K = 1e3,
    M = 1e6,
    B = 1e9,
    T = 1e12,
    Q = 1e15
}
function getRebirthRequirement()
    local text = lplr.PlayerGui.Main.MainFrame.Frames.Rebirth.req.Text
    local number, suffix = text:match("([%d%.]+)(%a?)")
    number = tonumber(number)
    if number and suffix ~= "" and multipliers[suffix] then
        return number * multipliers[suffix]
    end
    return number or 0
end



task.spawn(function()
    while true do
        pcall(function()
            if getIsActive3() and player() and Congela() then
                local rebirthLabel = lplr.PlayerGui.Main.MainFrame.Frames.Rebirth.MultiRebirth.TextLabel
                local text = rebirthLabel.Text
                local count = tonumber(text:match("%((%d+)%)")) or 0
                local valor = tonumber(inputBox.Text) or 4
                valor = math.clamp(valor, 1, MAX_VALOR)
                if count >= valor then
                    game.ReplicatedStorage.Package.Events.reb:InvokeServer(valor)
                end
            end
            if getIsActive3() and player() then
                local text = lplr.PlayerGui.Main.MainFrame.Frames.Rebirth.MultiRebirth.TextLabel.Text
                local count = tonumber(text:match("%((%d+)%)")) or 0
                if count >= 1 then
                    game.ReplicatedStorage.Package.Events.reb:InvokeServer(20)            
                end
            end
        end)
        task.wait(0.8)
    end
end)

task.spawn(function()
    while true do
        pcall(function()
        if data.Quest.Value ~= "" and player() and getIsActive1() and Congela() then
         wait(2)
       for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
          if npc:FindFirstChild("HumanoidRootPart") and (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude <= 50 and npc.Name ~= "X Fighter Trainer" then
              data.Quest.Value = ""
                break
                 end
              end
           end
        end)
        task.wait()
    end
end)

local emptyStartTime = nil
local sameQuestStartTime = nil
local lastQuest = nil
local lastExecutionTime = 0
local cooldown = 15

task.spawn(function()
    while task.wait() do
        pcall(function()
            if getIsActive1() and Congela() then
                local char = lplr.Character
                local humanoid = char and char:FindFirstChild("Humanoid")
                local hrp = char and char:FindFirstChild("HumanoidRootPart")        
                if humanoid and humanoid.Health > 0 and hrp and hrp:IsDescendantOf(workspace) then
                    local currentQuest = data.Quest.Value
                    local now = os.clock()

                    if currentQuest == "" then
                        sameQuestStartTime = nil
                        if not emptyStartTime then
                            emptyStartTime = now
                        elseif now - emptyStartTime >= 15 then
                            if now - lastExecutionTime >= cooldown then
                                humanoid:ChangeState(15)
                                lastExecutionTime = now
                            end
                        end
                    else
                        emptyStartTime = nil
                        if currentQuest == lastQuest then
                            if not sameQuestStartTime then
                                sameQuestStartTime = now
                            elseif now - sameQuestStartTime >= 150 then
                                if now - lastExecutionTime >= cooldown then
                                    humanoid:ChangeState(15)
                                    lastExecutionTime = now
                                end
                            end
                        else
                            sameQuestStartTime = now
                        end
                    end
                    lastQuest = currentQuest
                else
                    emptyStartTime = nil
                    sameQuestStartTime = nil
                end
            end
        end)
    end
end)


task.spawn(function()
    while task.wait() do
        pcall(function()       
            if player() and Congela() then
            if game.Players.LocalPlayer.Status.Blocking.Value == false and getIsActive1() then
                    game.Players.LocalPlayer.Status.Blocking.Value = true               
             end                                                    
            pcall(function()
            task.spawn(function()
            if player() and game.PlaceId == 3311165597 and getIsActive1() then
                 if data.Quest.Value ~= "X Fighter Trainer" and yo() <= 100e3 then
                 local npc = workspace.Others.NPCs["X Fighter Trainer"]
                    lplr.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
                       local args = {
                          [1] = npc }
                   game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(unpack(args))        
             elseif data.Quest.Value == "X Fighter Trainer" then
                  for _, boss in ipairs(workspace.Living:GetChildren()) do
             if boss.Name == "X Fighter" and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                 lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
                   game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol", 1)
                   game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol", 2) 
                           break
                             end
                          end
                       end 
                    end--if fin if game.PlaceId == 3311165597 then                
                 end)
              end)
           end
        end)
     end
 end)
 



local npcList = {
	{"Ultra Super Villain Jiran", 200e12, true},
	{"Mira (final form)", 50e12, true},
	{"Android 21 (janemba absorbed)", 20e12, true},
	{"Ultra Vekuta", 5e12, true},
	{"Seraphim of Destruction Vegetable", 2.30e12, true},
	{"Wukong Seraphim", 1.50e12, true},
	{"Ego Instinct Kakata (Buu absorbed)", 396e9, true},
    {"Kakata (Ego Instinct)", 150e9, true}, 
    {"Wukong True God", 100e9, true},
    {"Wukong (SSJB3)", 75e9, true},
    {"Xicor", 46e9, true},
    {"Vis (Ultra Instinct)", 35e9, true},
    {"Vills (True God of Destruction)", 25e9, true},
    {"Black Chilly", 15e9, true},
    {"Vegetable (Ultra Ego)", 9e9, true},
    {"Jiran The Gray", 7e9, true},
    {"Broccoli", 5e9, true},
    {"Merged Zamas", 3.5e9, true},
    {"Gold Chilly", 2e9, true},
    {"Vills (1%)", 1e9, true},
    {"Kakata (SSJ)", 800e6, true},
    {"Super Boo", 500e6, true},
    {"Z Broccoli", 390e6, true},
    {"Perfect Atom", 210e6, true},
    {"Chilly", 75e6, true},
    {"Lord Sloog", 7e6, true},   
    {"Mapa", 750e3, true},
    {"Radish", 400e3, true},
    {"Kid Nohag", 200e3, true},
    {"Roshi", 150e3, true},
    {"Klirin", 100e3, true}
}
    

task.spawn(function()
    while task.wait() do       
       pcall(function() 
       if Congela() then
       if game.PlaceId == 3311165597 or lplr.Status.Transformation.Value ~= "None" then   
       if getIsActive1() and player()  then
       if data.Quest.Value ~= "" then
                        local currentQuest = data.Quest.Value
                        local playerStats = yo()
                        for _, npc in ipairs(npcList) do
                            if npc[1] == currentQuest and playerStats < npc[2] then
                                data.Quest.Value = ""
                                break
                            end
                        end
                    end
                for i, npc in ipairs(npcList) do
                    local npcName, requisito, isActive = npc[1], npc[2], npc[3]
                    if isActive then
                        if yo() >= requisito then
                            local npcInstance = game.Workspace.Others.NPCs:FindFirstChild(npcName)
                            local bossInstance = game.Workspace.Living:FindFirstChild(npcName)                  
                            local Jefe = game.Workspace.Living:FindFirstChild(data.Quest.Value)
                            if npcInstance and npcInstance:FindFirstChild("HumanoidRootPart") and
                               (bossInstance and bossInstance:FindFirstChild("Humanoid") and bossInstance.Humanoid.Health > 0) then
                              if getIsActive1() and player() and data.Quest.Value == "" then
                                   lplr.Character.HumanoidRootPart.CFrame = npcInstance.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.4)  
                                        local args = {
                                            [1] = npcInstance
                                        }
                                        game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(unpack(args))        
                                    end
                                lplr.Character.HumanoidRootPart.CFrame = CFrame.new(Jefe.HumanoidRootPart.CFrame * CFrame.new(0,0,6.2).p, Jefe.HumanoidRootPart.Position)	           
                                break
                             end
                          end
                        end
                     end 
                 end
              end
           end
        end)
    end
end) 


canvolley = true        
task.spawn(function() 
    while true do
       pcall(function()
        if player() and Congela() then  
        if game.PlaceId == 3311165597 or lplr.Status.Transformation.Value ~= "None" then        
        if (yo() >= 40000 and data.Quest.Value ~= "" and getIsActive1())  then                                                     
                    local stats = yo()
                    local moves = {}
                    local attacked = false                    
                    if stats < 900e16 then             
                        if stats >= 5000 then table.insert(moves, "Wolf Fang Fist") end
                        if stats >= 40000 then table.insert(moves, "Meteor Crash") end
                        if stats >= 100000 then table.insert(moves, "High Power Rush") end
                        if stats >= 125000 then table.insert(moves, "Mach Kick") end                  
                             if stats >= 125000 then table.insert(moves, "Super Dragon Fist") end                               
                    end
                    for i, move in pairs(moves) do
                        if not lplr.Status:FindFirstChild(move) then
                            spawn(function()
                                game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(move, "dbuexploiterssucklol")                                        
                            end)
                            attacked = true
                        end
                    end
                    if stats > 5000 and canvolley then
                        canvolley = false
                           game.ReplicatedStorage.Package.Events.voleys:InvokeServer("Energy Volley", {FaceMouse = false, MouseHit = CFrame.new()}, "dbuexploiterssucklol")
                        attacked = true
                        spawn(function()
                            wait(.01)
                            canvolley = true
                        end)
                    end                                  
                  end              
                end
            end
        end)
        task.wait()
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

 
task.spawn(function()
    while task.wait() do       
       pcall(function() 
            if getIsActive10() then
            if yo() >= 7e9  and game.PlaceId == 3311165597  then
                game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
                wait(5)
            end
            if yo() < 7e9 and game.PlaceId == 5151400895  then
                game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
                wait(5)
            end
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
    if data:FindFirstChild("Allignment") then
        local alignment = data.Allignment.Value
        if alignment == "Evil" then
            ligaLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            ligaLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
            ligaLabel.TextStrokeTransparency = 0
        elseif alignment == "Good" then
            ligaLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            ligaLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 250)
            ligaLabel.TextStrokeTransparency = 0
        end
        ligaLabel.Text = alignment
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
         
        local questValue = data.Quest.Value or ""
        local Trf = lplr.Status.Transformation.Value
       questLabel.Text = "Mission: " .. questValue .. " | Form: " .. Trf
            
        local clockTime = game.Lighting.ClockTime
        local hour = math.floor(clockTime)
        local minute = math.floor((clockTime - hour) * 60)
        local period = (hour >= 7 and hour < 19) and "Dia" or "Nch"
        local ampm = (hour >= 12) and "PM" or "AM"
        local displayHour = (hour % 12 == 0) and 12 or hour % 12
        timeLabel.Text = string.format("%s: %02d:%02d %s", period, displayHour, minute, ampm)
 
            local maxMastery = 332526
            local currentMastery = 0
            local transformation = lplr.Status.Transformation.Value
            if data:FindFirstChild(transformation) then
                currentMastery = data[transformation].Value
            end
            if currentMastery > 0 then
                masteryLabel.Text = string.format("%d (%.1f%%)", currentMastery, (currentMastery / maxMastery) * 100)
            else
                masteryLabel.Text = "Mastery"
            end
           

        lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
        


        local rebirthValue = data.Rebirth.Value
        local strengthValue = data.Strength.Value
        local nextRebirth = getRebirthRequirement()
        local additionalStrength = lplr.Character and lplr.Character:FindFirstChild("Stats") and lplr.Character.Stats:FindFirstChild("Strength") and lplr.Character.Stats.Strength.Value or 0
        statusLabel.Text = string.format(
            "%s/%s/%s\n%s",
            formatNumber(nextRebirth),
            formatNumber(strengthValue),
            formatNumber(additionalStrength),
            formatNumber(rebirthValue))    
            
              local currentRebirthValue = data.Rebirth.Value
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
    while flying do
        pcall(function()
            local hum = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = lplr.Character and lplr.Character:FindFirstChild("Humanoid")
            if hum and humanoid then
                local moveDir = humanoid.MoveDirection
               local yDirection = 0
                if humanoid.WalkSpeed >= 32 then
                    if humanoid.Jump then
                        yDirection = speed * 0.60
                    end          
                    if moveDir.Magnitude > 0 or yDirection ~= 0 then
                        hum.CFrame = hum.CFrame + Vector3.new(moveDir.X, yDirection, moveDir.Z) * speed
                    end
                end
            end
        end)
        task.wait()
    end
end)



--REQUISITOS LEER
local npcList = {
    {"Kid Nohag", 17801},
    {"Klirin", 90551},
    {"Roshi", 130071},
    {"Radish", 200000},
    {"Mapa", 750000},
    {"Lord Sloog", 7000000},
    {"Chilly", 75000000},
    {"Perfect Atom", 110000000},
    {"Z Broccoli", 190000000},
    {"Super Boo", 350000000},
    {"Kakata (SSJ)", 530000000},
    {"Vills (1%)", 700000000},
    {"Gold Chilly", 990000000},
    {"Merged Zamas", 1e9},
    {"Broccoli", 2e9},
    {"Jiran The Gray", 7e9},
    {"Vegetable (Ultra Ego)", 9e9},
    {"Black Chilly", 15e9},
    {"Vills (True God of Destruction)", 25e9},
    {"Vis (Ultra Instinct)", 35e9},
    {"Xicor", 46e9},
    {"Wukong (SSJB3)", 75e9},
    {"Wukong True God", 100e9},
    {"Kakata (Ego Instinct)", 150e9},
    {"Ego Instinct Kakata (Buu absorbed)", 396e9},
    {"Wukong Seraphim", 1.5e12},
    {"Seraphim of Destruction Vegetable", 2.3e12},
    {"Ultra Vekuta", 5e12}
}


local expLabel = lplr.PlayerGui.Main.MainFrame.Frames.Quest.Yas.Rewards.EXP
   
local saveFile = "frame_position.txt"
local palabrasProhibidas = {"All Stats", "Stat", "Stats"}

local function limpiarTexto(texto)
    for _, palabra in ipairs(palabrasProhibidas) do
        texto = texto:gsub(palabra, "")
    end
    return texto
end

local function savePosition(frame)
    local pos = frame.Position
    local data = tostring(pos.X.Scale) .. "," .. tostring(pos.X.Offset) .. "," .. tostring(pos.Y.Scale) .. "," .. tostring(pos.Y.Offset)
    writefile(saveFile, data)
end

local function resetPosition()
    return UDim2.new(0.5, -125, 0.5, -30) 
end

local function loadPosition()
    if isfile(saveFile) then
        local data = readfile(saveFile)
        local values = {}
        for num in string.gmatch(data, "([^,]+)") do
            table.insert(values, tonumber(num))
        end
        if #values == 4 then
            return UDim2.new(values[1], values[2], values[3], values[4])
        end
    end
    return resetPosition()
end


local function getLastMissionByRebirthRequirement(rebirthReq)
    local lastMission = "Ninguna"
    for i = #npcList, 1, -1 do
        if npcList[i][2] <= rebirthReq then
            lastMission = npcList[i][1]
            break
        end
    end
    return lastMission
end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 80)
frame.Position = loadPosition()
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true
frame.Parent = screenGui

frame.Changed:Connect(function(property)
    if property == "Position" then
        savePosition(frame)
    end
end)

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -10, 1, -10)
textLabel.Position = UDim2.new(0, 5, 0, 5)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
textLabel.TextScaled = true
textLabel.TextWrapped = true
textLabel.Font = Enum.Font.SourceSansBold
textLabel.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 0, 0)
stroke.Parent = textLabel

local lastState = getIsActive9()


task.spawn(function()
    while task.wait() do
        pcall(function()
local expLabel = lplr.PlayerGui.Main.MainFrame.Frames.Quest.Yas.Rewards.EXP
    local currentState = getIsActive9()
    if currentState ~= lastState then  
        if not currentState then  
            frame.Position = resetPosition()   
        end  
        lastState = currentState  
    end  
    frame.Visible = currentState  
    if not currentState then return end  

    local fuerzaActual = yo()  
    local rebirthReq = getRebirthRequirement()  
    local ultimaMision = getLastMissionByRebirthRequirement(rebirthReq)  

    local siguienteMision = nil  
    for i = 1, #npcList do  
        if fuerzaActual < npcList[i][2] then  
            siguienteMision = npcList[i]  
            break  
        end  
    end  

    local fuerzaUltimoJefe = npcList[#npcList][2]
    local baseText = ""

    if fuerzaActual >= rebirthReq then  
        baseText = " REBIRTH COMPLETE \nRq: " .. formatNumber(rebirthReq) .. " | STATS: " .. formatNumber(fuerzaActual)  
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)  
    elseif fuerzaActual >= fuerzaUltimoJefe then  
        baseText = " QUEST FINAL \nRq: " .. formatNumber(rebirthReq) .. " | STATS: " .. formatNumber(fuerzaActual)  
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)  
    elseif siguienteMision then  
        local nombreMision = siguienteMision[1]  
        local faltaFuerza = formatNumber(siguienteMision[2] - fuerzaActual)  
        baseText = nombreMision .. " | " .. faltaFuerza .. "\nReq: " .. formatNumber(rebirthReq) .. " | " .. ultimaMision  
        textLabel.TextColor3 = Color3.fromRGB(150, 250, 255)  
    else  
        baseText = " QUEST FINAL \nRq: " .. formatNumber(rebirthReq) .. " | STATS: " .. formatNumber(fuerzaActual)  
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)  
    end

    local expText = "Cargando..."
    if data.Quest.Value ~= "" then
        expText = limpiarTexto(expLabel.Text)
    end
    textLabel.Text = baseText .. "\nExp: " .. expText
    end)
        end
     end)   
    
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local lplr = game.Players.LocalPlayer
local timeFileName = "SavedTime_" .. lplr.Name .. ".json"
local rebirthFileName = "SavedRebirth_" .. lplr.Name .. ".json"
local lastRebirthTimeFileName = "LastRebirthTime_" .. lplr.Name .. ".json"
local savedTimestamp = os.time()
local savedRebirth = 0
local elapsedTime = 0
local isPaused = false
local rebirthIncreased = false
local lastRebirthTime = 0

local function createOrUpdateFile(fileName, value)
    writefile(fileName, HttpService:JSONEncode({v = value}))
end

if not isfile(timeFileName) then
    createOrUpdateFile(timeFileName, os.time())
end

if not isfile(rebirthFileName) then
    createOrUpdateFile(rebirthFileName, data.Rebirth.Value)
end

if not isfile(lastRebirthTimeFileName) then
    createOrUpdateFile(lastRebirthTimeFileName, 0)
end

local function loadValue(fileName, default)
    if isfile(fileName) then
        local data = HttpService:JSONDecode(readfile(fileName))
        return data.v
    end
    return default
end

savedTimestamp = loadValue(timeFileName, os.time())
savedRebirth = loadValue(rebirthFileName, data.Rebirth.Value)
lastRebirthTime = loadValue(lastRebirthTimeFileName, 0)
elapsedTime = os.time() - savedTimestamp

local function resetTimer()
    savedTimestamp = os.time()
    elapsedTime = 0
    createOrUpdateFile(timeFileName, savedTimestamp)
    savedRebirth = data.Rebirth.Value
    createOrUpdateFile(rebirthFileName, savedRebirth)
    isPaused = false
    rebirthIncreased = false
end

local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0, 200, 0, 50)
timerLabel.Position = UDim2.new(0.200, 0, -0.7, 0)
timerLabel.Text = "Cargando..."
timerLabel.BackgroundTransparency = 1  
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timerLabel.TextStrokeTransparency = 0  
timerLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) 
timerLabel.Font = Enum.Font.SourceSansBold
timerLabel.TextSize = 30
timerLabel.Parent = frame

local lastRecordLabel = Instance.new("TextLabel")
lastRecordLabel.Size = UDim2.new(0, 200, 0, 50)
lastRecordLabel.Position = UDim2.new(0.200, 0, -0.4, 0)
lastRecordLabel.Text = "Ultimo record:| 00:00"
lastRecordLabel.BackgroundTransparency = 1  
lastRecordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
lastRecordLabel.TextStrokeTransparency = 0  
lastRecordLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) 
lastRecordLabel.Font = Enum.Font.SourceSansBold
lastRecordLabel.TextSize = 24
lastRecordLabel.Parent = frame

spawn(function()
    while true do
        local playerStats = yo()
        local rebirthRequirement = getRebirthRequirement()
        if playerStats >= rebirthRequirement then
            if not isPaused then
                isPaused = true
            end
        else
            isPaused = false
        end

        if game.PlaceId == 3311165597 then
            if isPaused then
                savedTimestamp = os.time() - elapsedTime
            else
                elapsedTime = os.time() - savedTimestamp
            end
        elseif rebirthIncreased then
            if not isPaused then
                elapsedTime = os.time() - savedTimestamp
                isPaused = true
            end
        else
            if not isPaused then
                elapsedTime = os.time() - savedTimestamp
            end
        end

        local minutes = math.floor(elapsedTime / 60)
        local seconds = elapsedTime % 60
        timerLabel.Text = isPaused 
            and string.format("%02d:%02d (Stop)", minutes, seconds)
            or string.format("Time:|%02d:%02d", minutes, seconds)

        local lastMinutes = math.floor(lastRebirthTime / 60)
        local lastSeconds = lastRebirthTime % 60
        lastRecordLabel.Text = string.format("Ultimo record:| %02d:%02d", lastMinutes, lastSeconds)
        task.wait()
    end
end)

spawn(function()
    while true do
        if data.Rebirth.Value > savedRebirth then
            if game.PlaceId == 5151400895 then
                lastRebirthTime = elapsedTime
                createOrUpdateFile(lastRebirthTimeFileName, lastRebirthTime)
            end
            if game.PlaceId == 3311165597 then
                resetTimer()
            else
                rebirthIncreased = true
                isPaused = true
            end
        end
        task.wait()
    end
end)

TeleportService.LocalPlayerArrivedFromTeleport:Connect(function()
    if game.PlaceId == 3311165597 and rebirthIncreased then
        resetTimer()
    end
end)

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Name = "FormMsg"
gui.Parent = game:GetService("CoreGui")

local txt = Instance.new("TextLabel")
txt.Size = UDim2.new(0, 600, 0, 100)
txt.Position = UDim2.new(0.5, -300, 0.5, -50)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.fromRGB(255, 0, 0)
txt.TextStrokeTransparency = 0
txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 255)
txt.Font = Enum.Font.Arcade
txt.TextSize = 45
txt.Text = "Active [Form] or [F|Vip]"
txt.Visible = false
txt.Parent = gui

task.spawn(function()
    while true do
        local s11, a11 = pcall(getIsActive11)
        local s12, a12 = pcall(getIsActive12)
        local s1, a1 = pcall(getIsActive1)
        if s11 and s12 and s1 then
            txt.Visible = (a11 == false and a12 == false and a1 == true)
        else
            txt.Visible = false
        end
        task.wait(1)
    end
end)

--fin de todo \/
       end)    
    task.wait()
  end)