local HttpService = game:GetService("HttpService")
local ArchivoClaveGuardada = "jses_syn"

local function guardarClaveGuardada(clave)
    writefile(ArchivoClaveGuardada, HttpService:JSONEncode({clave = clave, fecha = os.time()}))
end

local function claveEsValida()
    if isfile(ArchivoClaveGuardada) then
        local datos = HttpService:JSONDecode(readfile(ArchivoClaveGuardada))
        if os.time() - datos.fecha < (23 * 60 * 60) then
            return true
        else
            delfile(ArchivoClaveGuardada)
        end
    end
    return false
end

local function resetearClave()
    if isfile(ArchivoClaveGuardada) then
        delfile(ArchivoClaveGuardada)
    end
end

local function script()
    print("¡La clave es válida! Ejecutando el script principal...")


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
local KeyFile = "jses_syn"

Fernando.Name = "fffg"
Fernando.Parent = game.CoreGui


local function formatNumber(number)
    local suffixes = {"", "K", "M", "B", "T", "QD"}
    local suffix_index = 1
    while math.abs(number) >= 1000 and suffix_index < #suffixes do
        number = number / 1000.0
        suffix_index = suffix_index + 1
    end
    local formatted_number = string.format("%.2f", number)
    if math.floor(number) == number then
        formatted_number = string.format("%d", number)
    end
    return formatted_number .. suffixes[suffix_index]
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
VS.Text = "V [0.6]"
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
button.Text = "Reset"
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

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0.135, 0, 0.05, 0)
textLabel.Position = UDim2.new(0.42, 0, 0.012, 0)
textLabel.Font = Enum.Font.GothamBold
textLabel.TextScaled = true
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundTransparency = 1
textLabel.Text = "0"
textLabel.Parent = Barra1

local Contenedor = Instance.new("ScrollingFrame", Barra1)
Contenedor.Size = UDim2.new(0, 400, 0, 200)
Contenedor.Position = UDim2.new(0.490, 0, 0.731, 0)
Contenedor.AnchorPoint = Vector2.new(0.5, 0.5)
Contenedor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Contenedor.BorderSizePixel = 0
Contenedor.ScrollBarThickness = 6
Contenedor.CanvasSize = UDim2.new(0, 0, 0, 400)
Contenedor.ScrollingDirection = Enum.ScrollingDirection.Y

local Kill = Instance.new("ScrollingFrame", Barra3)
Kill.Size = UDim2.new(0, 400, 0, 200)
Kill.Position = UDim2.new(0.490, 0, 0.131, 0)
Kill.AnchorPoint = Vector2.new(0.5, 0.5)
Kill.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
Kill.BorderSizePixel = 0
Kill.ScrollBarThickness = 6
Kill.CanvasSize = UDim2.new(0, 0, 0, 400)
Kill.ScrollingDirection = Enum.ScrollingDirection.Y


local Selct = Instance.new("ScrollingFrame", Barra2)
Selct.Size = UDim2.new(0, 320, 0, 170)
Selct.Position = UDim2.new(0.990, 0, 0.165, 0)
Selct.AnchorPoint = Vector2.new(0.5, 0.5)
Selct.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Selct.BorderSizePixel = 0
Selct.ScrollBarThickness = 6
Selct.CanvasSize = UDim2.new(0, 0, 0, 400)
Selct.ScrollingDirection = Enum.ScrollingDirection.Y


local forms = {"Divine Rose Prominence", "Astral Instinct", "Ultra Ego", "SSJBUI", "Beast", "LSSJ4"}
local frame = Instance.new("Frame", Selct)
frame.Size = UDim2.new(0, 100, 0, #forms * 30 + 10)
frame.Position = UDim2.new(0.8, -220, 0.270, -frame.Size.Y.Offset / 2)
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
    {text = "Farm", position = UDim2.new(-0.155, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra1},
    {text = "Form", position = UDim2.new(0.350, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0), parent = Barra1},
    {text = "Atck", position = UDim2.new(-0.160, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255), parent = Barra1},
    {text = "Puch", position = UDim2.new(0.360, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255), parent = Barra1},
    {text = "Reb", position = UDim2.new(-0.160, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0), parent = Barra1},
    {text = "Main", position = UDim2.new(0.350, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255), parent = Barra1},
    {text = "Fly", position = UDim2.new(-0.04, 0, 0.320, 0), color = Color3.fromRGB(200, 300, 400), parent = Barra1},
    {text = "Brillo", position = UDim2.new(0.473, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100), parent = Barra1},
    {text = "Duck", position = UDim2.new(-0.160, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 300), parent = Barra1},
    {text = "Ɓºrª", position = UDim2.new(0.350, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70), parent = Barra1},
    {text = "Graf", position = UDim2.new(-0.160, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1},
    {text = "Plant", position = UDim2.new(0.350, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1},
    {text = "Black", position = UDim2.new(-0.160, 0, 0.570, 0), color = Color3.fromRGB(200, 380, 90), parent = Barra1},
    {text = "HA🎃", position = UDim2.new(0.360, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100), parent = Barra1},
    
    {text = "Klirin", position = UDim2.new(-0.155, 0, 0.085, 0), color = Color3.fromRGB(200, 190, 255), parent = Contenedor},
    {text = "Mapa", position = UDim2.new(0.350, 0, 0.085, 0), color = Color3.fromRGB(255, 190, 150), parent = Contenedor},
    {text = "Tp", position = UDim2.new(-0.160, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3},
    {text = "Actk", position = UDim2.new(0.350, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3},
    {text = "Fijar", position = UDim2.new(-0.160, 0, 0.345, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3},
    {text = "Camr", position = UDim2.new(0.350, 0, 0.345, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra3},
}

for _, props in pairs(textProperties) do
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = props.parent
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
local clickCount = 0

-- Botón para cambiar entre cuadros
local currentPanel = 1
local isMinimized = true
local clickCount = 0

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
    if isMinimized then
        Cuadro1.Visible = false
        Cuadro2.Visible = false
        Cuadro3.Visible = false
        Mix.Text = "+"
    else
        if currentPanel == 1 then
            Cuadro1.Visible = true
        elseif currentPanel == 2 then
            Cuadro2.Visible = true
        else
            Cuadro3.Visible = true
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
        local remainingTime = (data.fecha + 86400) - os.time() 
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

--Tp Players
local getIsActive15 = createSwitch(Barra3, UDim2.new(0.2, 0, 0.275, 0), "Switch15", LoadSwitchState("Switch15"))--Tp
local getIsActive17 = createSwitch(Barra3, UDim2.new(0.2, 0, 0.345, 0), "Switch17", LoadSwitchState("Switch17"))--Tp
local getIsActive18 = createSwitch(Barra3, UDim2.new(0.740, 0, 0.345, 0), "Switch18", LoadSwitchState("Switch178"))--Tp
--[Xd]
local selectedPlayer = nil
local teleportConnection = nil

local function teleportToPlayer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        lplr.Character:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3))
        lplr.Character.Humanoid:ChangeState(11)
        lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0) 
    end
end

local function toggleTeleport(player)
    if selectedPlayer == player then
        selectedPlayer = nil
    else    
        selectedPlayer = player        
        spawn(function()
            while selectedPlayer == player do
                if getIsActive15() then
                    teleportToPlayer(player)                                   
                end
                task.wait()
            end
        end)        
    end
end

local function createClickableFrame(size, position, parent, player)
    local frame = Instance.new("TextButton", parent)
    frame.Size, frame.Position, frame.BackgroundColor3 = size, position, Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel, frame.BorderColor3, frame.Text, frame.AutoButtonColor = 2, Color3.fromRGB(255, 0, 0), "", false
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    frame.MouseButton1Click:Connect(function()
        toggleTeleport(player)
    end)
    
    return frame
end

local function createLabel(parent, text)
    local label = Instance.new("TextLabel", parent)
    label.Size, label.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
    label.TextColor3, label.Font, label.TextSize, label.Text = Color3.new(1, 1, 1), Enum.Font.SourceSans, 18, text
    return label
end

local function getStat(player, statName)
    local statsFolder = game.Workspace.Living:FindFirstChild(player.Name) and game.Workspace.Living[player.Name]:FindFirstChild("Stats")
    if statsFolder then
        local stat = statsFolder:FindFirstChild(statName)
        return stat and stat.Value or 0
    end
    return 0
end

local function updateList()
    Kill:ClearAllChildren()
    local playerList = {}
    
    
    for _, player in ipairs(game.Players:GetPlayers()) do
        table.insert(playerList, {player = player, strength = getStat(player, "Strength")})
    end
    
    table.sort(playerList, function(a, b) return a.strength > b.strength end)

    local frameWidth = Kill.AbsoluteSize.X
    local columnWidth = (frameWidth - 20) / 3  -- 20 para padding

    for i, info in ipairs(playerList) do
        local yPos = (i - 1) * 35
        local player, strength = info.player, info.strength
        local rebirth = getStat(player, "Rebirth")

        local function createFrame(xPos, value, player)
            local frame = createClickableFrame(UDim2.new(0, columnWidth, 0, 30), UDim2.new(0, xPos, 0, yPos), Kill, player)
            createLabel(frame, value)
        end

        
        createFrame(5, player.Name, player)
        createFrame(10 + columnWidth, formatNumber(rebirth), player)
        createFrame(15 + columnWidth * 2, formatNumber(strength), player)
    end
    Kill.CanvasSize = UDim2.new(0, 0, 0, #playerList * 35)
end

Kill:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateList)


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

local getIsActive13 = createSwitch(Contenedor, UDim2.new(0.2, 0, 0.090, 0), "Switch13", LoadSwitchState("Switch13"))--Klirin
local getIsActive14 = createSwitch(Contenedor, UDim2.new(0.755, 0, 0.090, 0), "Switch14", LoadSwitchState("Switch14"))--Mapa

local getIsActive16 = createSwitch(Barra3, UDim2.new(0.740, 0, 0.275, 0), "Switch16", LoadSwitchState("Switch16"))--Atakes

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


function player()
	return lplr.Character and lplr.Character.Humanoid and lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart")
end


task.spawn(function()
    while task.wait() do
        pcall(function()
        if player() and getIsActive2() then
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
                if not getIsActive2() and selectedForm and not transforming and lplr.Status.Transformation.Value ~= selectedForm and player() then
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

local Mel = { 
    "Super Dragon Fist", "God Slicer", "Spirit Barrage", "Mach Kick", "Wolf Fang Fist", 
    "High Power Rush", "Meteor Strike", "Meteor Charge", "Spirit Breaking Cannon", 
    "Vital Strike", "Flash Kick", "Vanish Strike", "Uppercut", "Sledgehammer", "Rock Impact"
}

local Atck = { 
    "Super Dragon Fist", "God Slicer", "Spirit Barrage", "Mach Kick", "Wolf Fang Fist", 
    "High Power Rush", "Meteor Strike"
}

local function invokeMove(move)
    Ex.mel:InvokeServer(move, "Blacknwhite27")
    Ex.voleys:InvokeServer("Energy Volley", { FaceMouse = false, MouseHit = CFrame.new() }, "Blacknwhite27")
    Ex.block:InvokeServer(true)
    if game.PlaceId ~= 5151400895 and yo() <= 80e9 then
        Ex.cha:InvokeServer("Blacknwhite27")
    end
end

task.spawn(function()
    data.Quest.Value = ""
    while wait() do
        pcall(function()
            if getIsActive3() and player() then
                local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
                local Ki = lplr.Character.Stats.Ki
                if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and data.Quest.Value ~= "" then
                    for _, move in pairs(moves) do
                        if not lplr.Status:FindFirstChild(move.name) and yo() >= move.condition and Ki.Value > Ki.MaxValue * 0.11 then
                            task.spawn(function()
                                invokeMove(move.name)
                            end)
                        end
                    end
                end
            end           
            local bossPosition = Vector3.new(848.1, 362.7, 2219.8)
            local dat = (game.PlaceId == 5151400895) and game.Workspace.Living:FindFirstChild(lplr.Name) or lplr
            local distance = (game.Workspace.Living:FindFirstChild("Goku Black").HumanoidRootPart.Position - bossPosition).Magnitude
            if getIsActive11() and game.Workspace.Living:FindFirstChild("Goku Black") and game.Workspace.Living["Goku Black"]:FindFirstChild("Humanoid") and game.Workspace.Living["Goku Black"].Humanoid.Health > 0 and distance <= 900 then
                if dat:FindFirstChild("Status") then
                    for _, Atck in ipairs(Atck) do
                        if not dat.Status:FindFirstChild(Atck) then
                            task.spawn(function()
                                game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(Atck, "Blacknwhite27")
                                Ex.voleys:InvokeServer("Energy Volley", { FaceMouse = false, MouseHit = CFrame.new() }, "Blacknwhite27")
                                Ex.block:InvokeServer(true)
                                if game.PlaceId ~= 5151400895 and yo() <= 80e9 then
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
    while wait() do
        pcall(function()
            local dat = (game.PlaceId == 5151400895) and game.Workspace.Living:FindFirstChild(lplr.Name) or lplr
            if getIsActive16() and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") and selectedPlayer.Character.Humanoid.Health > 0 then
                if dat:FindFirstChild("Status") then
                    for _, Mel in ipairs(Mel) do
                        if not dat.Status:FindFirstChild(Mel) then
                            task.spawn(function()
                                invokeMove(Mel)
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
            if questValue ~= "" and getIsActive1() and player() then
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
            local character = lplr.Character
            if not character or not character:FindFirstChild("Stats") then return end

            local stats = character.Stats
            local ki = stats:FindFirstChild("Ki")
            local humanoid = character:FindFirstChild("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")

            if not (ki and humanoid and rootPart) then return end

            if ki.Value < ki.MaxValue * 0.25 and player() and getIsActive4() and yo() <= 800e9 then
                Ex.cha:InvokeServer("Blacknwhite27")
            end

            if getIsActive4() then
                humanoid:ChangeState(11)
                rootPart.Velocity = Vector3.zero
            end

            if getIsActive11() and player() then
                local gokuBlack = game.Workspace.Living:FindFirstChild("Goku Black")
                local bossPosition = Vector3.new(848.1, 362.7, 2219.8)

                if gokuBlack and gokuBlack:FindFirstChild("Humanoid") and gokuBlack.Humanoid.Health > 0 then
                    local distance = (gokuBlack.HumanoidRootPart.Position - bossPosition).Magnitude
                    if distance <= 900 then
                        rootPart.CFrame = gokuBlack.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    end
                end
            end

            if player() then
                if lplr.Status.Blocking.Value ~= true and getIsActive4() then
                    Ex.block:InvokeServer(true)
                end

                local rebirthValue = data.Rebirth.Value
                local rebirthThreshold = (rebirthValue * 3e6) + 2e6
                if yo() >= rebirthThreshold and yo() < (rebirthThreshold * 2) and getIsActive5() then
                    Ex.reb:InvokeServer()
                end
            end
        end)
    end
 end)
  
  
     


 npcList = {
    {"Vekuta (SSJBUI)", 2.375e9, true},
    {"Wukong Rose", 1.65e9, true},
    {"Vekuta (LBSSJ4)", 1.05e9, true},
    {"Wukong (LBSSJ4)", 950e6, true},
    {"Vegetable (LBSSJ4)", 650e6, true},
    {"Vis (20%)", 500e6, true},
    {"Vills (50%)", 350e6, true},
    {"Wukong (Omen)", 200e6, true},
    {"Vegetable (GoD in-training)", 100e6, true},
    {"SSJG Kakata", 70e6, true},
    {"Broccoli", 35.5e6, true},
    {"SSJB Wukong", 4e6, true},
    {"Kai-fist Master", 3025000, true},
    {"SSJ2 Wukong", 2250000, true},
    {"Perfect Atom", 1275000, true},
    {"Chilly", 950000, true},
    {"Super Vegetable", 358000, true},
    {"Mapa", 0, true},
    {"Radish", 55000, true},
    {"Kid Nohag", 40000, true},
    {"Klirin", 0, true}
}


task.spawn(function() 
    while true do     
    pcall(function()  
    if data.Quest.Value == "" and getIsActive1() and player() then
                for i, npc in ipairs(npcList) do
                    local npcName, requisito, isActive = npc[1], npc[2], npc[3]
                    if isActive then
                        if yo() >= requisito then
                            local npcInstance = game.Workspace.Others.NPCs:FindFirstChild(npcName)
                            local bossInstance = game.Workspace.Living:FindFirstChild(npcName)
                            if npcInstance and npcInstance:FindFirstChild("HumanoidRootPart") and
                               (bossInstance and bossInstance:FindFirstChild("Humanoid") and bossInstance.Humanoid.Health > 0) then
                                lplr.Character.HumanoidRootPart.CFrame = npcInstance.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.4)  
                                 pcall(function()
                                  if getIsActive1() then    
                                game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(npcInstance)
                                   end
                                end)
                                break
                                end
                             end
                         end
                     end
                 end         
            end)
            task.wait()
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
           
 task.spawn(function()
    while task.wait() do        
            if getIsActive13() then
            npcList[21][3] = true  
            else
            npcList[21][3] = false
            end
            if getIsActive14() then
            npcList[18][3] = true  
            else
            npcList[18][3] = false
            end    
         if getIsActive10() then
            if yo() >= 150e6 and data.Zeni.Value >= 15000 and game.PlaceId == 3311165597  then
                game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
                wait(5)
            end
            if yo() < 50e6 and game.PlaceId == 5151400895  then
                game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
                wait(5)
            end
         end 
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
loadServerData()  
end)
   end
end)

task.spawn(function()
    while task.wait(.4) do
   if data.Quest.Value ~= "" and player() and game.PlaceId == 3311165597 then
         wait(2)
       for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
          if npc:FindFirstChild("HumanoidRootPart") and (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude <= 500 and npc.Name ~= "Halloween NPC" then
              data.Quest.Value = ""
                break
               end
          end
       end
       updateList()
    end
 end)            
 
 local Q = data:WaitForChild("Quest")
local notified = false
local function NotyQ()
    if Q.Value ~= "" and not notified then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Misión Iniciada",
            Text = tostring(Q.Value),
            Duration = 2
        })
        notified = true
    elseif Q.Value == "" then
        notified = false
    end
end
NotyQ()
game.ReplicatedStorage.Datas[lplr.UserId].Quest.Changed:Connect(function()
    NotyQ()
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
            
           if tick() - lastActivity >= 1 then
            afkTime = afkTime + 1
            afkLabel.Text = "Tiempo AFK: " .. afkTime .. "s"
          end

        lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false

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
           
           if getIsActive9() then
            for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj.Name == "Effects" or obj:IsA("ParticleEmitter") then
              obj:Destroy()
                end
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



if claveEsValida() then
    print("Clave válida detectada. No se mostrará la GUI.")
    script() 
    return
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.318, 0, 0.318, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Frame.BorderSizePixel = 0
Frame.Parent = KeyGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.05, 0)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.95, 0, 0.15, 0)
Title.Position = UDim2.new(0.025, 0, 0.05, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Text = "🔐 Sistema de Claves"
Title.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.9, 0, 0.13, 0)
TextBox.Position = UDim2.new(0.05, 0, 0.28, 0)
TextBox.PlaceholderText = "Introduce tu clave aquí"
TextBox.Font = Enum.Font.Gotham
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
TextBox.BorderSizePixel = 0
TextBox.TextScaled = true
TextBox.ClearTextOnFocus = false
TextBox.Parent = Frame

local BotonUrl = Instance.new("TextButton")
BotonUrl.Size = UDim2.new(0.7, 0, 0.15, 0)
BotonUrl.Position = UDim2.new(0.15, 0, 0.45, 0)
BotonUrl.Text = "Generar URL de Clave"
BotonUrl.Font = Enum.Font.GothamBold
BotonUrl.TextScaled = true
BotonUrl.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonUrl.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
BotonUrl.BorderSizePixel = 0
BotonUrl.Parent = Frame

local BotonVerificar = Instance.new("TextButton")
BotonVerificar.Size = UDim2.new(0.7, 0, 0.15, 0)
BotonVerificar.Position = UDim2.new(0.15, 0, 0.65, 0)
BotonVerificar.Text = "Verificar Clave"
BotonVerificar.Font = Enum.Font.GothamBold
BotonVerificar.TextScaled = true
BotonVerificar.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonVerificar.BackgroundColor3 = Color3.fromRGB(0, 204, 122)
BotonVerificar.BorderSizePixel = 0
BotonVerificar.Parent = Frame

local function generarLink()
    local identifier = "roblox-client-" .. game.Players.LocalPlayer.UserId
    local datos = {
        service = 1951,
        identifier = identifier
    }

    local success, response = pcall(function()
        return http_request({
            Url = "https://api.platoboost.com/public/start",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Accept"] = "application/json"
            },
            Body = HttpService:JSONEncode(datos)
        })
    end)

    if success and response and response.StatusCode == 200 then
        local data = HttpService:JSONDecode(response.Body)
        if data.success then
            return data.data.url
        else
            return "Error del servidor: " .. (data.message or "Mensaje de error no disponible")
        end
    else
        return "Error en la solicitud: " .. tostring(response and response.StatusMessage or "Sin mensaje disponible")
    end
end

local function verificarClave(clave)
    local identifier = "roblox-client-" .. game.Players.LocalPlayer.UserId
    local url = string.format(
        "https://api.platoboost.com/public/whitelist/1951?identifier=%s&key=%s",
        HttpService:UrlEncode(identifier),
        HttpService:UrlEncode(clave)
    )

    local success, response = pcall(function()
        return http_request({
            Url = url,
            Method = "GET",
            Headers = {
                ["Accept"] = "application/json"
            }
        })
    end)

    if success and response then
        local statusCode = response.StatusCode
        local responseBody
        pcall(function()
            responseBody = HttpService:JSONDecode(response.Body)
        end)

        if statusCode == 200 then
            if responseBody and responseBody.success and responseBody.data and responseBody.data.valid then
                guardarClaveGuardada(clave)
                return true, "Clave válida"
            else
                return false, "Respuesta inesperada: " .. tostring(response.Body)
            end
        elseif statusCode == 400 then
            return false, responseBody and responseBody.message or "Clave inválida"
        else
            return false, "Error desconocido. Código: " .. tostring(statusCode)
        end
    else
        return false, "Error en la solicitud: " .. tostring(response and response.StatusMessage or "Sin mensaje")
    end
end


BotonUrl.MouseButton1Click:Connect(function()
    TextBox.Text = "Generando link..."
    local linkGenerado = generarLink()
    
    if string.sub(linkGenerado, 1, 4) == "http" then
        setclipboard(linkGenerado)
        TextBox.Text = "¡Link generado y copiado!"
        TextBox.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        TextBox.Text = linkGenerado
        TextBox.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

BotonVerificar.MouseButton1Click:Connect(function()
    local clave = TextBox.Text
    if clave == "" then
        TextBox.Text = "Por favor, introduce una clave"
        TextBox.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end

    local esValida, mensaje = verificarClave(clave)
    if esValida then
        TextBox.Text = "¡Clave válida!"
        TextBox.TextColor3 = Color3.fromRGB(100, 255, 100)
        KeyGui:Destroy() -- Cierra el GUI
        script() -- Ejecuta la función script()
    else
        TextBox.Text = mensaje or "Clave inválida"
        TextBox.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
