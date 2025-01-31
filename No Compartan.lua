local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local KeyFile, HistoryFile = "ClaveGuardada.json", "HistorialClaves.json"

local personalizedUsers = {
    ["Zerincee"] = "Felicidad",
    ["Latios789_2"] = "Felicidad",
    ["armijosfernando2178"] = "Friv"
}

local personalizedKeyDuration = 30 * 86400 
local regularKeyDuration = 24 * 3600  

local function readJsonFile(filename)
    if isfile(filename) then
        local success, result = pcall(HttpService.JSONDecode, HttpService, readfile(filename))
        return success and result or nil
    end
    return nil
end

local function writeJsonFile(filename, data)
    writefile(filename, HttpService:JSONEncode(data))
end

local function saveKey(key, duration)
    writeJsonFile(KeyFile, {key = key, time = os.time(), duration = duration})
end

local function updateHistory(key)
    local history = readJsonFile(HistoryFile) or {}
    table.insert(history, 1, key)
    if #history > 7 then table.remove(history) end
    writeJsonFile(HistoryFile, history)
end

local function isKeyValid()
    local data = readJsonFile(KeyFile)
    if data then
        local duration = data.duration or regularKeyDuration
        return (os.time() - data.time < duration)
    end
    return false
end

local function levenshteinDistance(a, b)
    local m, n = #a, #b
    local dp = {}
    for i = 0, m do dp[i] = {[0] = i} end
    for j = 1, n do
        dp[0][j] = j
        for i = 1, m do
            dp[i][j] = math.min(dp[i-1][j] + 1, dp[i][j-1] + 1, dp[i-1][j-1] + (a:sub(i,i) ~= b:sub(j,j) and 1 or 0))
        end
    end
    return dp[m][n]
end

local gui = Instance.new("ScreenGui")
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.32, 0, 0.32, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
frame.Parent = gui

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
}
gradient.Rotation = 45
gradient.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.9, 0, 0.126, 0)
textBox.Position = UDim2.new(0.05, 0, 0.279, 0)
textBox.PlaceholderText = "Introduce tu clave aquí"
textBox.Font = Enum.Font.Gotham
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
textBox.TextScaled = true
textBox.Parent = frame

function lopp()
local fffg = game.CoreGui:FindFirstChild("fffg")
if fffg then
    return  
end
local Fernando = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local Cuadro1 = Instance.new("Frame")
local Cuadro2 = Instance.new("Frame")
local Barra1 = Instance.new("ScrollingFrame")
local Barra2 = Instance.new("ScrollingFrame")
local Siguiente = Instance.new("TextButton")
local Mix = Instance.new("TextButton")
local Borde1 = Instance.new("UIStroke")
local Borde2 = Instance.new("UIStroke")
local HttpService = game:GetService("HttpService")--Barra
local Lighting = game:GetService("Lighting")--Barra
local UserInputService = game:GetService("UserInputService")--Barra
local lplr = game.Players.LocalPlayer
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)
local Ex = game:GetService("ReplicatedStorage").Package.Events
local HttpService = game:GetService("HttpService")
local KeyFile = "ClaveGuardada.json"

Fernando.Name = "fffg"
Fernando.Parent = game.CoreGui

local function formatNumber(number)
    if number < 1000 then
        return tostring(number)
    end
    local suffixes = {"", "K", "M", "B", "T", "QD"}
    local suffix_index = 1
    while math.abs(number) >= 1000 and suffix_index < #suffixes do
        number = number / 1000.0
        suffix_index = suffix_index + 1
    end
    return string.format("%.2f%s", number, suffixes[suffix_index])
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
VS.Text = "V [0.5]"
VS.Size = UDim2.new(0, 100, 0, 10)
VS.Position = UDim2.new(0.783, 0, 0.009, 0)
VS.TextColor3 = Color3.fromRGB(255, 255, 255)
VS.BackgroundTransparency = 1
VS.TextSize = 7
VS.TextStrokeTransparency = 0.8


local worldIds = {
    [3311165597] = "Tierra",
    [5151400895] = "Bilss",
    [3608495586] = "Time",
    [3608496430] = "Grvd"
}

local searchFrame = Instance.new("Frame", Barra2)
searchFrame.Size = UDim2.new(0.3, 0, 0, 100)
searchFrame.Position = UDim2.new(0.35, 0, 0, 0)
searchFrame.BackgroundTransparency = 1

local searchBox = Instance.new("TextBox", searchFrame)
searchBox.Size = UDim2.new(2, 0, 0, 30)
searchBox.Position = UDim2.new(-1.1, 0, 0, 10)
searchBox.PlaceholderText = "Cantidad de jugadores"
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.TextScaled = true
searchBox.BackgroundTransparency = 0
searchBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
searchBox.BorderColor3 = Color3.fromRGB(169, 169, 169)  -- Gris
searchBox.BorderSizePixel = 2

local searchButton = Instance.new("TextButton", searchFrame)
searchButton.Size = UDim2.new(0.3, 0, 0, 32)
searchButton.Position = UDim2.new(.940, 0, 0, 9) 
searchButton.Text = "TP"
searchButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
searchButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local resultLabel = Instance.new("TextLabel", searchFrame)
resultLabel.Size = UDim2.new(-0.5, 0, 0, 30)
resultLabel.Position = UDim2.new(0.05, 0, 0, 50)
resultLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
resultLabel.TextScaled = true
resultLabel.Text = ""
resultLabel.BackgroundTransparency = 1


local afkLabel = Instance.new("TextLabel", Barra1)
afkLabel.Size = UDim2.new(0, 100, 0, 50)
afkLabel.Position = UDim2.new(-.03, 0, 0.06, 0)
afkLabel.Text = "Tiempo AFK: 0s"
afkLabel.TextColor3 = Color3.new(1, 1, 1)
afkLabel.Font = Enum.Font.SourceSans
afkLabel.TextSize = 13
afkLabel.BackgroundTransparency = 1 -- Fondo completamente transparente

local uiStroke = Instance.new("UIStroke", afkLabel)
uiStroke.Thickness = 3
uiStroke.Color = Color3.fromRGB(0, 0, 255)


local button = Instance.new("TextButton", Barra1)
button.Size = UDim2.new(0.120, 0, 0.03, 0)
button.Position = UDim2.new(0.840, 0, 0.03, 0)
button.Text = "Ret[Mode]"
button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 100, 200)

local totalInfoLabel = Instance.new("TextLabel", Barra2)
totalInfoLabel.Size = UDim2.new(1, 0, 0, 100)
totalInfoLabel.Position = UDim2.new(-0.2, 0, 0.06, 0)
totalInfoLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
totalInfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
totalInfoLabel.BackgroundTransparency = 1
totalInfoLabel.TextScaled = true
totalInfoLabel.TextWrapped = true


local tierra = Instance.new("ImageButton", Barra2)
tierra.Size = UDim2.new(0, 31, 0, 31)
tierra.Position = UDim2.new(0.440, 0, 0.205, 0)
tierra.BackgroundTransparency = 1
tierra.Image = "rbxassetid://105319560378349"
tierra.MouseButton1Click:Connect(function()
    local playerCount = #game.Players:GetPlayers()
    if playerCount > 3 then
        game:GetService("TeleportService"):Teleport(3311165597, game.Players.LocalPlayer)
    elseif playerCount < 3 then
        Ex.TP:InvokeServer("Earth")
    end
end)

local bills = Instance.new("ImageButton", Barra2)
bills.Size = UDim2.new(0, 41, 0, 41)
bills.Position = UDim2.new(0.03, 0, 0.205, 0)
bills.BackgroundTransparency = 1
bills.Image = "rbxassetid://17345700746"
bills.MouseButton1Click:Connect(function()
    local playerCount = #game.Players:GetPlayers()
    if playerCount > 3 then
        game:GetService("TeleportService"):Teleport(5151400895, game.Players.LocalPlayer)
    elseif playerCount < 3 then
        Ex.TP:InvokeServer("Vills Planet")
    end
end)

local grvd = Instance.new("ImageButton", Barra2)
grvd.Size = UDim2.new(0, 41, 0, 41)
grvd.Position = UDim2.new(0.165, 0, 0.205, 0)
grvd.BackgroundTransparency = 1
grvd.Image = "rbxassetid://129453529806060"
grvd.MouseButton1Click:Connect(function()
    Ex.TP:InvokeServer("Gravity Room")
end)

local time = Instance.new("ImageButton", Barra2)
time.Size = UDim2.new(0, 41, 0, 41)
time.Position = UDim2.new(0.3, 0, 0.205, 0)
time.BackgroundTransparency = 1
time.Image = "rbxassetid://126015597245029"
time.MouseButton1Click:Connect(function()
Ex.TP:InvokeServer("Hyperbolic Time Chamber")
end)

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0.135, 0, 0.05, 0)
textLabel.Position = UDim2.new(0.42, 0, 0.012, 0)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextScaled = true
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundTransparency = 1
textLabel.Text = "0"
textLabel.Parent = Barra1


local forms = {"Divine Rose Prominence", "Astral Instinct", "Ultra Ego", "SSJBUI", "Beast", "LSSJ4"}
local frame = Instance.new("Frame", Barra2)
frame.Size = UDim2.new(0, 200, 0, #forms * 30 + 10)
frame.Position = UDim2.new(1, -220, 0.5, -frame.Size.Y.Offset / 2)
frame.BackgroundTransparency = 1

local list = Instance.new("UIListLayout", frame)
list.Padding = UDim.new(0, 5)

--incio Borde color\/
Borde1.Parent = Cuadro1
Borde1.Thickness = 2
Borde1.Color = Color3.fromRGB(255, 0, 0) 

Borde2.Parent = Cuadro2
Borde2.Thickness = 2
Borde2.Color = Color3.fromRGB(255, 0, 0) 
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
    {text = "Farm", position = UDim2.new(-0.155, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0)},
    {text = "Form", position = UDim2.new(0.350, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0)},
    {text = "Atck", position = UDim2.new(-0.160, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255)},   
    {text = "Puch", position = UDim2.new(0.360, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255)},
    {text = "Reb", position = UDim2.new(-0.160, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0)},
    {text = "Main", position = UDim2.new(0.350, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255)},
    {text = "Fly", position = UDim2.new(-0.04, 0, 0.320, 0), color = Color3.fromRGB(200, 300, 400)},
    {text = "Brillo", position = UDim2.new(0.473, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100)},
    {text = "Duck", position = UDim2.new(-0.160, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 300)},
    {text = "Ɓºrª", position = UDim2.new(0.350, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70)},    
    {text = "Graf", position = UDim2.new(-0.160, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},   
    {text = "Plant", position = UDim2.new(0.350, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},
    {text = "Zom", position = UDim2.new(-0.160, 0, 0.570, 0), color = Color3.fromRGB(200, 380, 90)},   
    {text = "HA🎃", position = UDim2.new(0.360, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100)},  
}

for _, props in pairs(textProperties) do
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Barra1
    TextLabel.Size = UDim2.new(0, 200, 0, 36)
    TextLabel.Position = props.position
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextStrokeColor3 = props.color
    TextLabel.TextStrokeTransparency = 0
    TextLabel.Text = props.text
    TextLabel.TextScaled = true
end
 --Fin del color txt/\
 
--Codeg Para Button Minimizar = Maximizar
local currentPanel = 1
local isMinimized = true  
Siguiente.MouseButton1Click:Connect(function()
    if not isMinimized then
        if currentPanel == 1 then
            Cuadro1.Visible = false
            currentPanel = 2
            Cuadro2.Visible = true
        else
            Cuadro2.Visible = false
            currentPanel = 1
            Cuadro1.Visible = true
        end
    end
end)

local clickCount = 0
button.MouseButton1Click:Connect(function()
    clickCount = clickCount + 1
    if clickCount == 1 then
        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health = 0
        game.ReplicatedStorage.Modules2.Name = "Invalido"
    elseif clickCount == 2 then
         game.ReplicatedStorage.Invalido.Name = "Modules2"
        clickCount = 0 
    end
end)

Mix.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Cuadro1.Visible = false
        Cuadro2.Visible = false
        Mix.Text = "+"
    else
        if currentPanel == 1 then
            Cuadro1.Visible = true
        else
            Cuadro2.Visible = true
        end
        Mix.Text = "×"
    end
end)

--Aki ya es del interrutor <: \/
local function SaveSwitchState(isActive, switchName)
    writefile(switchName.."_SwitchState.json", game:GetService("HttpService"):JSONEncode({SwitchOn = isActive, LastModified = os.time()}))
end

local function LoadSwitchState(switchName)
    return isfile(switchName.."_SwitchState.json") and game:GetService("HttpService"):JSONDecode(readfile(switchName.."_SwitchState.json")).SwitchOn or false
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

local allServerData = {}
local function loadServerData()
    local httpService = game:GetService("HttpService")
    for _, worldId in pairs(worldIds) do
        local success, serverData = pcall(function()
            return httpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. _ .. "/servers/Public?limit=100"))
        end)
        if success and serverData then
            allServerData[worldId] = serverData.data
        end
    end
end
local function teleportToServer(playerCount)
    local foundServer = nil
    for worldId, worldData in pairs(allServerData) do
        for _, server in ipairs(worldData) do
            if server.playing == playerCount then
                foundServer = server
                break
            end
        end
        if foundServer then break end
    end
    
    if foundServer then
        local teleportService = game:GetService("TeleportService")
        teleportService:TeleportToPlaceInstance(game.PlaceId, foundServer.id, game.Players.LocalPlayer)
    else
        resultLabel.Text = "No se encontró un servidor con esa cantidad."
    end
end

local function updateWorldInfo()
    local httpService = game:GetService("HttpService")
    local infoText = ""  
    for worldId, worldName in pairs(worldIds) do
        local success, serverData = pcall(function()
            return httpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. worldId .. "/servers/Public?sortOrder=Asc&limit=100"))
        end)       
        if success and serverData then
            local worldServers, worldPlayers = #serverData.data, 0
            for _, server in ipairs(serverData.data) do
                worldPlayers = worldPlayers + server.playing
            end
            infoText = infoText .. worldName .. ": " .. worldServers .. " Servs, " .. worldPlayers .. " Jug.\n"
        else
            infoText = infoText .. worldName .. ": 0 Servs, 0 Jug.\n"
        end
    end
    totalInfoLabel.Text = infoText
end

local function getServers()
    local httpService = game:GetService("HttpService")
    local worldId = game.PlaceId
    local success, serverData = pcall(function()
        return httpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. worldId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    return success and serverData.data or {}
end
local function teleportToServer(serverId)
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId, lplr)
end

local function createButton(size, position, text)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(0, 60, 200)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Text = text
    button.Parent = Barra2
    return button
end

--Formas
for i, form in ipairs(forms) do
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, 0, 0, 25)
    btn.Text = form
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextSize = 14  
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
selectedForm = loadForm()
if selectedForm then
    for _, btn in ipairs(frame:GetChildren()) do
        if btn:IsA("TextButton") and btn.Text == selectedForm then
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
            break
        end
    end
end

--Key lector
local function getTimeRemaining()
    if isfile(KeyFile) then
        local data = HttpService:JSONDecode(readfile(KeyFile))
        local remainingTime = data.duration - (os.time() - data.time)
        return remainingTime > 0 and remainingTime or 0
    end
    return 0
end

local function formatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end


local getIsActive1 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.120, 0), "Switch1", LoadSwitchState("Switch1"))--Farm
local getIsActive2 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.115, 0), "Switch2", LoadSwitchState("Switch2"))--Ozaru
local getIsActive3 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.2, 0), "Switch3", LoadSwitchState("Switch3"))--Atack
local getIsActive4 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.195, 0), "Switch4", LoadSwitchState("Switch4"))--Puch
local getIsActive5 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.275, 0), "Switch5", LoadSwitchState("Switch5"))--Rebirth
local getIsActive6 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.275, 0), "Switch6", LoadSwitchState("Switch6"))--Main
local getIsActive7 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.420, 0), "Switch7", LoadSwitchState("Switch7"))--Duck
local getIsActive8 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.420, 0), "Switch8", LoadSwitchState("Switch8"))--Bºrª
local getIsActive9 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.495, 0), "Switch9", LoadSwitchState("Switch9"))--Graf
local getIsActive10 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.495, 0), "Switch10", LoadSwitchState("Switch10"))--Planet
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.570, 0), "Switch11", LoadSwitchState("Switch11"))--Black
local getIsActive12 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.570, 0), "Switch12", LoadSwitchState("Switch12"))--Hall🎃

--Barras
createBar(0, "Flight", Color3.fromRGB(255, 0, 0), 0.37, 100, function(v) speed = v end, "flight")
createBar(0.513, "Ambient", Color3.fromRGB(0, 255, 0), 0.37, 700, function(v) Lighting.Ambient = Color3.fromRGB(v, v, v) end, "ambient")

local rejoiButton = createButton(UDim2.new(0.07, 0, 0, 32), UDim2.new(0.740, 0, 0, 9), "Rejoi")
local plusButton = createButton(UDim2.new(0.07, 0, 0, 32), UDim2.new(.825, 0, 0, 9), "+")
local minusButton = createButton(UDim2.new(0.07, 0, 0, 32), UDim2.new(.912, 0, 0, 9), "-")

rejoiButton.MouseButton1Click:Connect(function()
    for _, server in ipairs(getServers()) do
        if server.id == game.JobId then
            teleportToServer(server.id)
            break
        end
    end
end)

plusButton.MouseButton1Click:Connect(function()
    local targetServer = nil
    for _, server in ipairs(getServers()) do
        if not targetServer or server.playing > targetServer.playing then
            targetServer = server
        end
    end
    if targetServer then teleportToServer(targetServer.id) end
end)

minusButton.MouseButton1Click:Connect(function()
    local targetServer = nil
    for _, server in ipairs(getServers()) do
        if not targetServer or server.playing < targetServer.playing then
            targetServer = server
        end
    end
    if targetServer then teleportToServer(targetServer.id) end
end)

searchButton.MouseButton1Click:Connect(function()
    local playerCount = tonumber(searchBox.Text)
    if playerCount then
        teleportToServer(playerCount)
    else
        resultLabel.Text = "Por favor, ingresa una cantidad válida."
    end
end)



--Casi fin del interrutor /\

--Ciclo Para Auto = Main y Start
spawn(function()
    if lplr.PlayerGui:FindFirstChild("Start") then
        Ex.Start:InvokeServer()
        if game:GetService("Workspace").Others:FindFirstChild("Title") then
            game:GetService("Workspace").Others.Title:Destroy()
        end
        local cam = Workspace.CurrentCamera
        cam.CameraType = Enum.CameraType.Custom
        cam.CameraSubject = lplr.Character.Humanoid
        _G.Ready = true
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
        lplr.PlayerGui.Main.Enabled = true
        if lplr.PlayerGui:FindFirstChild("Start") then
            lplr.PlayerGui.Start:Destroy()
        end
        lplr.PlayerGui.Main.bruh.Enabled = false
        lplr.PlayerGui.Main.bruh.Enabled = true
    end
end)


task.spawn(function()
    pcall(function()
local sts = {"Strength", "Speed", "Defense", "Energy"}
function yo()
    local l = math.huge
    for _, v in pairs(sts) do
        local stat = data:FindFirstChild(v)
        if not stat then return end
        local st = stat.Value
        if st < l then
            l = st
        end
    end
    return l
end

function characterInvisible()
	return lplr.Character
end

function player()
	return lplr.Character and lplr.Character.Humanoid and lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart")
end


task.spawn(function()
    while task.wait() do
        pcall(function()
        if player() and characterInvisible() and getIsActive2() then
        local Forms = {'Divine Rose Prominence', 'Astral Instinct', 'Ultra Ego', 'SSJB4', 'True God of Creation', 
    'True God of Destruction', 'Super Broly', 'LSSJG', 'LSSJ4', 'SSJG4', 'LSSJ3', 'Mystic Kaioken', 
    'LSSJ Kaioken', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 
    'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 
    'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 'SSJ Blue', 
    'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 'Spirit SSJ', 'SSJ2 Majin', 
    'SSJ2', 'SSJ Kaioken', 'SSJ', 'FSSJ', 'Kaioken'}
        local status = lplr.Status    
        for _, form in ipairs(Forms) do 
            if Ex.equipskill:InvokeServer(form) then break end 
        end
        if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
            Ex.ta:InvokeServer()
                       end
                end
                if not getIsActive2() and selectedForm and not transforming and lplr.Status.Transformation.Value ~= selectedForm and player() and characterInvisible() then
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
     
    
     

local moves = {
    {name = "Wolf Fang Fist", condition = 5000},
    {name = "Meteor Crash", condition = 40000},
    {name = "High Power Rush", condition = 100000},
    {name = "Mach Kick", condition = 125000},
    {name = "Spirit Barrage", condition = 60e6},
    {name = "God Slicer", condition = 60e6}
}     

task.spawn(function()
  data.Quest.Value = ""
    while wait() do
        pcall(function()
        if getIsActive3() and player() and characterInvisible() then
            local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            local Ki = lplr.Character.Stats.Ki
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and data.Quest.Value ~= "" then
                for _, move in pairs(moves) do
                    if not lplr.Status:FindFirstChild(move.name) and yo() >= move.condition and Ki.Value > Ki.MaxValue * 0.11 then
                        task.spawn(function()
                            Ex.mel:InvokeServer(move.name, "Blacknwhite27")
                            Ex.voleys:InvokeServer("Energy Volley", { FaceMouse = false, MouseHit = CFrame.new() }, "Blacknwhite27")    
                         if game.PlaceId ~= 5151400895 then
                          Ex.cha:InvokeServer("Blacknwhite27")            
                            end                
                        end)
                    end
                end
            end
          end
        end)
    end
end)

 task.spawn(function()
 lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-35233, 18, -28942)                        
    while true do
        pcall(function()
        local boss = game.Workspace.Living:FindFirstChild("Halloween Boss")
            if game.PlaceId ~= 5151400895 and data.Quest.Value == "" and getIsActive12() and boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0  and yo() >= 5e7 then
                        lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-35233, 18, -28942)                        
                        if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                            lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)                 
                          spawn(function()                  
                           Ex.p:FireServer("Blacknwhite27",1)    
                           Ex.mel:InvokeServer("Wolf Fang Fist", "Blacknwhite27") 
                           Ex.mel:InvokeServer("High Power Rush", "Blacknwhite27")        
                       end)                
                    end
            end
        end)
        task.wait()
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
        local questValue = data.Quest.Value
            if questValue ~= "" and getIsActive1() and player() and characterInvisible() then
                local boss = game.Workspace.Living:FindFirstChild(questValue)
                if boss and boss:FindFirstChild("HumanoidRootPart") then
                    if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health <= 0 then
                    end
                    lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5.7)      
                     Ex.p:FireServer("Blacknwhite27",1)             
                    end                 
               end               
         end)
      end
  end)
  
task.spawn(function()
    while task.wait() do
      pcall(function()
    local Ki = lplr.Character.Stats.Ki
    if Ki.Value < Ki.MaxValue * 0.25 and player() and characterInvisible() and getIsActive4() then
         Ex.cha:InvokeServer("Blacknwhite27")        
         end
         if getIsActive1() then
         lplr.Character.Humanoid:ChangeState(11)
	      lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) 
	       end
       end)
     end    
   end)             
   


local npcList = {
    {"Vekuta (SSJBUI)", 2.375e9},
    {"Wukong Rose", 1.65e9},
    {"Vekuta (LBSSJ4)", 1.05e9},
    {"Wukong (LBSSJ4)", 850e6},
    {"Vegetable (LBSSJ4)", 650e6},
    {"Vis (20%)", 450e6},
    {"Vills (50%)", 300e6},
    {"Wukong (Omen)", 200e6},
    {"Vegetable (GoD in-training)", 150e6},
    {"SSJG Kakata", 100e6},
    {"Broccoli", 45.5e6},
    {"SSJB Wukong", 4e6},
    {"Kai-fist Master", 3025000},
    {"SSJ2 Wukong", 2250000},
    {"Perfect Atom", 1275000},
    {"Chilly", 950000},
    {"Super Vegetable", 358000},
    {"Mapa", 0},
    {"Radish", 55000},
    {"Kid Nohag", 40000},
    {"Klirin", 0}
}



task.spawn(function()
    while wait() do
        pcall(function()        
        if player() and characterInvisible() then
           if lplr.Status.Blocking.Value ~= true and getIsActive4() then
           pcall(function()
             Ex.block:InvokeServer(true)
                   end)
                 end
                 if (yo() >= ((data.Rebirth.Value * 3e6) + 2e6)) and 
               (yo() < (((data.Rebirth.Value * 3e6) + 2e6) * 2)) and getIsActive5() then
                Ex.reb:InvokeServer()   
                   end
                  if game.PlaceId == 5151400895 and yo() <= 100000000 and getIsActive10() then
                Ex.TP:InvokeServer("Earth")
            elseif game.PlaceId ~= 5151400895 and yo() >= 100000000 and getIsActive10() then
                Ex.TP:InvokeServer("Vills Planet")
                end    
              if data.Quest.Value == "" and getIsActive1() then
            for i, npc in ipairs(npcList) do
                local npcName, requisito = npc[1], npc[2]
                if (data.Rebirth.Value > 1500 or npcName ~= "Mapa") and yo() >= requisito then
                    local npcInstance = game.Workspace.Others.NPCs:FindFirstChild(npcName)
                    local bossInstance = game.Workspace.Living:FindFirstChild(npcName)                    
                    if npcInstance and npcInstance:FindFirstChild("HumanoidRootPart") and
                       (bossInstance and bossInstance:FindFirstChild("Humanoid") and bossInstance.Humanoid.Health > 0) then
                        lplr.Character.HumanoidRootPart.CFrame = npcInstance.HumanoidRootPart.CFrame
                        game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(npcInstance)
                        break
                    elseif i > 1 then
                        local prevNpc = npcList[i-1][1]
                        local prevNpcInstance = game.Workspace.Others.NPCs:FindFirstChild(prevNpc)
                        if prevNpcInstance and prevNpcInstance:FindFirstChild("HumanoidRootPart") then
                            lplr.Character.HumanoidRootPart.CFrame = prevNpcInstance.HumanoidRootPart.CFrame
                            game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(prevNpcInstance)
                            break
                         end
                        end
                    end
                end
           end
            end
        end)       
    end
end)

spawn(function()
while wait(100) do
   pcall(function()
        lplr.Idled:Connect(function()
         local bb = game:GetService('VirtualUser')
         bb:CaptureController()
          bb:ClickButton2(Vector2.new())          
          keypress(Enum.KeyCode.L)  
        end)
  end)
    end
end)    
           


function quets()
   if data.Quest.Value ~= "" and player() and characterInvisible() then
         wait(2)
       for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
          if npc:FindFirstChild("HumanoidRootPart") and (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude <= 500 and npc.Name ~= "Halloween NPC" then
              data.Quest.Value = ""
                break
               end
          end
       end
    end            

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
    game:GetService("Lighting").ClockTime = 18
    updateWorldInfo()    
end)
             
 
local afkTime = 0
local lastActivity = tick()
game:GetService("UserInputService").InputBegan:Connect(function()
    lastActivity = tick()
    afkTime = 0
    afkLabel.Text = "Tiempo AFK: 0s"
end)



task.spawn(function()
    while wait(.4) do
    pcall(function()
    loadServerData()
    quets() 
      end)
    end
 end)


task.spawn(function()
    while wait(.8) do
    pcall(function()
    if player() and characterInvisible() then
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
            
           if tick() - lastActivity >= 1 then
            afkTime = afkTime + 1
            afkLabel.Text = "Tiempo AFK: " .. afkTime .. "s"
          end

        local rebirthValue = data.Rebirth.Value
        local strengthValue = data.Strength.Value
        local nextRebirth = (rebirthValue * 3e6) + 2e6
        local additionalStrength = lplr.Character and lplr.Character:FindFirstChild("Stats") and lplr.Character.Stats:FindFirstChild("Strength") and lplr.Character.Stats.Strength.Value or 0
        statusLabel.Text = string.format(
            "%s/%s/%s\n%s",
            formatNumber(nextRebirth),
            formatNumber(strengthValue),
            formatNumber(additionalStrength),
            formatNumber(rebirthValue))    
            
            local remainingTime = getTimeRemaining()
           textLabel.Text = formatTime(remainingTime)
           
           
            for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj.Name == "Effects" or obj:IsA("ParticleEmitter") then
              obj:Destroy()
                end
            end          
           
               updateTimer()
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
            local hum = lplr.Character and lplr.Character:FindFirstChild("Humanoid")
            if hum and hum.MoveDirection.Magnitude > 0 then
                lplr.Character:TranslateBy(hum.MoveDirection * speed)
            end
        end)
        task.wait()
    end
end)


--fin de todo \/
       end)    
    task.wait()
end)
end

local function validateAndSaveKey(key)
    local player = Players.LocalPlayer
    if personalizedUsers[player.Name] and key == personalizedUsers[player.Name] then
        saveKey(key, personalizedKeyDuration)
        gui.Enabled = false
        lopp()
        return true
    elseif key and #key == 64 and key:match("%u") and key:match("%l") and key:match("%d") then
        local history = readJsonFile(HistoryFile) or {}
        if not table.find(history, function(v) return levenshteinDistance(v, key) <= 14 end) then
            saveKey(key, regularKeyDuration)  -- Regular key duration (18 hours)
            updateHistory(key)
            gui.Enabled = false
            lopp()
            return true
        else
            return false, "Clave Igual"
        end
    end
    return false, "Clave inválida"
end

textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local key = textBox.Text:match("KEY:%[(.-)%]$") or textBox.Text
        local success, message = validateAndSaveKey(key)
        if not success then
            textBox.Text = message
            textBox.TextColor3 = Color3.new(1, 0, 0)
            wait(1)
            textBox.TextColor3 = Color3.new(1, 1, 1)
            textBox.Text = ""
        end
    end
end)

local urlButton = Instance.new("TextButton")
urlButton.Size = UDim2.new(0.715, 0, 0.147, 0)
urlButton.Position = UDim2.new(0.142, 0, 0.55, 0)
urlButton.Text = "Copiar URL de Clave"
urlButton.Font = Enum.Font.GothamBold
urlButton.TextScaled = true
urlButton.TextColor3 = Color3.new(1, 1, 1)
urlButton.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
urlButton.Parent = frame

urlButton.MouseButton1Click:Connect(function()
    setclipboard("https://luatt11.github.io/Keysistema/")
end)

local discordButton = Instance.new("ImageButton")
discordButton.Size = UDim2.new(0.098, 0, 0.116, 0)
discordButton.Position = UDim2.new(0.871, 0, 0.562, 0)
discordButton.Image = "rbxassetid://17085964685"
discordButton.BackgroundTransparency = 1
discordButton.Parent = frame

discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.com/invite/P6b85GfDdF")
end)

for _, v in ipairs({frame, textBox, urlButton}) do
    Instance.new("UICorner", v).CornerRadius = UDim.new(0.05, 0)
end

spawn(function()
    while wait(10) do
        if not isKeyValid() then
            if isfile(KeyFile) then delfile(KeyFile) end
            gui.Enabled = true            
        end
    end
end)

if isKeyValid() then
    lopp()
else
    local player = Players.LocalPlayer
    if personalizedUsers[player.Name] then
        textBox.PlaceholderText = "Introduce tu clave personalizada"
    end
end

gui.Enabled = not isKeyValid()
