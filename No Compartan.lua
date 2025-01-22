--Hola soy Fernando el q logre Descodificar este codeg fue fácil solo use página gratis para eso bueno les pido que la script no los compartan vivo en Latan y intento ganar dinero por Key otro lo coguen  y lo usan si esfuerzo esto me demore asiendo 6meses IA/Manualmente 
--Porfa solo no comparta script toy dando gratis no es nada sacar la Key les pido  🙏 
local ArchivoClaveGuardada = "ClaveGuardada.json"
local ArchivoHistorial = "HistorialClaves.json"
local HttpService = game:GetService("HttpService")

local KeyGui = Instance.new("ScreenGui")
KeyGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.318272662, 0, 0.318272662, 0)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Frame.BorderSizePixel = 0
Frame.Parent = KeyGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.05, 0)
UICorner.Parent = Frame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
}
Gradient.Rotation = 45
Gradient.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.950000000, 0, 0.150000000, 0)
Title.Position = UDim2.new(0.025000000, 0, 0.050000000, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Text = "🔐 Sistema de Claves"
Title.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.900635200, 0, 0.126137561, 0)
TextBox.Position = UDim2.new(0.049682240, 0, 0.278634136, 0)
TextBox.PlaceholderText = "Introduce tu clave aquí"
TextBox.Font = Enum.Font.Gotham
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
TextBox.BorderSizePixel = 0
TextBox.TextScaled = true
TextBox.ClearTextOnFocus = false
TextBox.Parent = Frame

local UICornerTextBox = Instance.new("UICorner")
UICornerTextBox.CornerRadius = UDim.new(0.05, 0)
UICornerTextBox.Parent = TextBox

local BotonUrl = Instance.new("TextButton")
BotonUrl.Size = UDim2.new(0.715488320, 0, 0.147448120, 0)
BotonUrl.Position = UDim2.new(0.142255450, 0, 0.550486350, 0)
BotonUrl.Text = "Copiar URL de Clave"
BotonUrl.Font = Enum.Font.GothamBold
BotonUrl.TextScaled = true
BotonUrl.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonUrl.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
BotonUrl.BorderSizePixel = 0
BotonUrl.Parent = Frame

local UICornerBotonUrl = Instance.new("UICorner")
UICornerBotonUrl.CornerRadius = UDim.new(0.05, 0)
UICornerBotonUrl.Parent = BotonUrl

local BotonInvitacion = Instance.new("ImageButton")
BotonInvitacion.Size = UDim2.new(0.097682243, 0, 0.116241136, 0)
BotonInvitacion.Position = UDim2.new(0.870682243, 0, 0.562241136, 0)
BotonInvitacion.Image = "rbxassetid://17085964685"
BotonInvitacion.BackgroundTransparency = 1
BotonInvitacion.BorderSizePixel = 0
BotonInvitacion.Parent = Frame


local UICornerBotonUrl = Instance.new("UICorner")
UICornerBotonUrl.CornerRadius = UDim.new(0.1, 0)
UICornerBotonUrl.Parent = BotonUrl

local claveValida = false

local function guardarClaveGuardada(clave)
    writefile(ArchivoClaveGuardada, HttpService:JSONEncode({clave = clave, fecha = os.time()}))
end

local function actualizarHistorial(clave)
    local historial = isfile(ArchivoHistorial) and HttpService:JSONDecode(readfile(ArchivoHistorial)) or {}
    table.insert(historial, clave)
    if #historial > 7 then table.remove(historial, 1) end
    writefile(ArchivoHistorial, HttpService:JSONEncode(historial))
end

local function claveEsValida()
    if isfile(ArchivoClaveGuardada) then
        local datos = HttpService:JSONDecode(readfile(ArchivoClaveGuardada))
        return os.time() - datos.fecha < (24 * 60 * 60)
    end
    return false
end

local function resetearClave()
    if isfile(ArchivoClaveGuardada) then delfile(ArchivoClaveGuardada) end
end


local function lopoi()
local lplr = game.Players.LocalPlayer
    spawn(function()
        
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
local lplr = game.Players.LocalPlayer
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)
local Ex = game:GetService("ReplicatedStorage").Package.Events

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
        game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
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
        game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
    end
end)

local grvd = Instance.new("ImageButton", Barra2)
grvd.Size = UDim2.new(0, 41, 0, 41)
grvd.Position = UDim2.new(0.165, 0, 0.205, 0)
grvd.BackgroundTransparency = 1
grvd.Image = "rbxassetid://129453529806060"
grvd.MouseButton1Click:Connect(function()
    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Gravity Room")
end)

local time = Instance.new("ImageButton", Barra2)
time.Size = UDim2.new(0, 41, 0, 41)
time.Position = UDim2.new(0.3, 0, 0.205, 0)
time.BackgroundTransparency = 1
time.Image = "rbxassetid://126015597245029"
time.MouseButton1Click:Connect(function()
game.ReplicatedStorage.Package.Events.TP:InvokeServer("Hyperbolic Time Chamber")
end)

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
    {text = "Ozaru", position = UDim2.new(0.350, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0)},
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
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.570, 0), "Switch11", LoadSwitchState("Switch11"))--Zom
local getIsActive12 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.570, 0), "Switch12", LoadSwitchState("Switch12"))--Hall🎃

--Casi fin del interrutor /\

--Ciclo Para Auto = Main y Start
local gui = lplr.PlayerGui.Main.bruh
if workspace.Others:FindFirstChild("Title") then
    Ex.Start:InvokeServer()
    gui.Disabled = true
    gui.Disabled = false
end

task.spawn(function()
pcall(function()
while not game:IsLoaded() do wait() end
while not game.Players.LocalPlayer do wait() end
local lplr = game.Players.LocalPlayer
while not lplr.Character do wait() end
local ldata = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)

local r = math.random(1,2e9) -- This changes when you re-execute, so the gui doesn't stack
_G.AY = r
_G.Fast = false

local t = {"Rebirth","Strength","Speed","Defense","Energy","Zeni"}
for i,a in pairs(t) do
	while not ldata:FindFirstChild(a) do wait() end
end
local users = {""}

local corner = UDim.new(0,5)
-- Functions required for logs
local suffixes = {'','K','M','B','T','qd','Qn'}
function format(val)
	for i=1, #suffixes do
		if tonumber(val) < 10^(i*3) then
			return math.floor(val/((10^((i-1)*3))/100))/(100)..suffixes[i]
		end
	end
end

function format2(n)
	n = tostring(n)
	return n:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local sts = {"Strength","Speed","Defense","Energy"}
function getloweststat(plr)
	local data = game.ReplicatedStorage.Datas:WaitForChild(plr.UserId)
	local l = math.huge
	for i,v in pairs(sts) do
		if not data:FindFirstChild(v) then return end
		local st = data[v]
		if st.Value < l then l = st.Value end
	end
	return l
end

local LocalPlayer = game:GetService("Players").LocalPlayer
--Player Info

local DName = game.Players.LocalPlayer.DisplayName  -- PlayerInfo Display Name
local Name = game.Players.LocalPlayer.Name -- Name
local Userid = game.Players.LocalPlayer.UserId -- UserId

-- Load the character in
if lplr.PlayerGui:FindFirstChild("Start") then
	game:GetService("ReplicatedStorage").Package.Events.Start:InvokeServer()
	if workspace.Others:FindFirstChild("Title") then
		workspace.Others.Title:Destroy();
	end;
	local cam = game.Workspace.CurrentCamera;
	cam.CameraType = Enum.CameraType.Custom;
	cam.CameraSubject = lplr.Character.Humanoid;
	_G.Ready = true
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true);
	lplr.PlayerGui:WaitForChild("Main").Enabled = true
	if lplr.PlayerGui:FindFirstChild("Start") then
		lplr.PlayerGui.Start:Destroy()
	end
    lplr.PlayerGui.Main.bruh.Enabled = false
    lplr.PlayerGui.Main.bruh.Enabled = true
end


-- Begin basic functions
local NPCs = workspace:WaitForChild("Others"):WaitForChild("NPCs")
c = nil
local rainbows = {} -- {Object, Color Property}
local rainbows2 = {}
spawn(function()
	while _G.AY == r do
		for i = 1,6 do 
			if i == 1 then c = Color3.new(1,0,0)
			elseif i == 2 then c = Color3.new(1,1,0)
			elseif i == 3 then c = Color3.new(0,1,0)
			elseif i == 4 then c = Color3.new(0,1,1)
			elseif i == 5 then c = Color3.new(0,0,1)
			elseif i == 6 then c = Color3.new(1,0,1)
			end
			for a,v in pairs(rainbows) do
				game:GetService("TweenService"):Create(v[1], TweenInfo.new(1), {[v[2]] = c}):Play()
			end
			wait(1)
		end
		wait()
	end
end)
spawn(function()
	while _G.AY == r do
		for a,v in pairs(rainbows2) do
			game:GetService("TweenService"):Create(v[1], TweenInfo.new(.1), {[v[2]] = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
			task.wait()
		end
		wait(.1)
	end
end)

--GUI
local vL = lplr.PlayerGui:WaitForChild("Main"):WaitForChild("Version") 
vL.Visible = false 

--local guilocation = game.CoreGui
local guilocation = game.Players.LocalPlayer.PlayerGui
if guilocation:FindFirstChild("StatsGUI") then guilocation.StatsGUI:Destroy() end
local scgui = Instance.new("ScreenGui")
scgui.Parent = game.CoreGui
scgui.DisplayOrder = math.huge
local espdirectory = Instance.new("Folder")
espdirectory.Name = "ESPs"
espdirectory.Parent = scgui
scgui.ResetOnSpawn = false
scgui.Name = "StatsGUI"
local colortheme = Color3.new(.1,.1,.1)

-- Frames
local fr = Instance.new("Frame") -- This holds the playerlist frame
fr.Parent = scgui
fr.Name = "fr"
fr.BackgroundColor3 = colortheme --Color3.new(.2,.2,.2)
fr.BackgroundTransparency = 1
fr.AnchorPoint = Vector2.new(1,0)
fr.Position = UDim2.new(1.16,-5,.05,0)
fr.Size = UDim2.new(.15,0,0,40*18)
fr.BorderSizePixel = 0

local fr12 = Instance.new("Frame") -- Playerlist goes here
fr12.Parent = fr
fr12.Name = "fr12"
fr12.BackgroundColor3 = Color3.new(1,1,1) --Color3.new(.2,.2,.2)
fr12.BorderSizePixel = 3
fr12.BackgroundTransparency = 0
local layout12 = Instance.new("UIGridLayout") -- Organizes the players
layout12.Parent = fr12
layout12.CellPadding = UDim2.new(0,0,0,5) --
layout12.SortOrder = Enum.SortOrder.LayoutOrder
local stroke1 = Instance.new("UIStroke")
stroke1.Parent = fr12
stroke1.Thickness = 2
local corner1 = Instance.new("UICorner")
corner1.Parent = fr12
corner1.CornerRadius = corner
local UIGradient = Instance.new("UIGradient")
UIGradient.Parent = fr12
UIGradient.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(20,20,20)),
	ColorSequenceKeypoint.new(.5, Color3.fromRGB(50,50,50)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(20,20,20)),
}
--
local Grad = UIGradient
local frames = 60
local speed = 0.01

function colour_change(colour1, colour2, colour3)
	local originalColour1 = Grad.Color.Keypoints[1].Value
	local originalColour2 = Grad.Color.Keypoints[2].Value
	local originalColour3 = Grad.Color.Keypoints[3].Value

	for i=frames,0,-1 do
		wait(speed)

		local x = math.sqrt((i-frames)^2)/frames

		Grad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0,originalColour1:Lerp(colour1, x)),
			ColorSequenceKeypoint.new(.5,originalColour2:Lerp(colour2, x)),
			ColorSequenceKeypoint.new(1,originalColour3:Lerp(colour3, x)),

		}


	end
end
-- pink blue purple 
task.spawn(function()
	while c == nil do wait() end
	while scgui do
		colour_change(Color3.new(.1,.1,.1), Color3.new(.7,0,0), Color3.new(.1,.1,.1))
		colour_change(Color3.new(.1,.1,.1), Color3.new(0,.7,0), Color3.new(.1,.1,.1))
		colour_change(Color3.new(.1,.1,.1), Color3.new(0,0,.7), Color3.new(.1,.1,.1))
        task.wait()
	end
end)
--

UIGradient.Rotation = 45

layout12.CellSize = UDim2.new(1,0,0,30)--1/(#fr12:GetChildren()-2),0)

local fr2fade = Instance.new("Frame")
fr2fade.Parent = scgui
fr2fade.Position = UDim2.new(.75,-5,.05,-4)
fr2fade.Size = UDim2.new(.1,0,.7,4)
fr2fade.BackgroundTransparency = 1
fr2fade.ClipsDescendants = true
fr2fade.Name = "fr2back"
local fr2 = Instance.new("Frame") -- Normal Buttons go here
fr2.Parent = fr2fade
fr2.Name = "fr2"
fr2.ZIndex = -2
fr2.BackgroundColor3 = colortheme--Color3.new(.2,.2,.2)
--fr2.AnchorPoint = Vector2.new(1,0)
fr2.Position = UDim2.new(1,4,0,4)
fr2.BorderSizePixel = 3
fr2.BackgroundTransparency = 0.1
fr2.Visible = true
fr2.ClipsDescendants = true
local layout2 = Instance.new("UIGridLayout") -- Organizes the players
layout2.Parent = fr2
layout2.CellPadding = UDim2.new(0,0,0,4)
layout2.CellSize = UDim2.new(1,0,0,20)

layout2.SortOrder = "LayoutOrder"
local stroke2 = Instance.new("UIStroke")
stroke2.Parent = fr2
stroke2.Thickness = 2
local corner2 = Instance.new("UICorner")
corner2.Parent = fr2
corner2.CornerRadius = corner

local fr3 = Instance.new("Frame") -- Third Frame, holds lplr buttons
fr3.Parent = scgui
fr3.Name = "fr3"
fr3.ZIndex = -4
fr3.BackgroundTransparency = 0
fr3.BorderSizePixel = 0
fr3.BackgroundColor3 = colortheme
fr3.Position = UDim2.new(.31,0,1,5)
--fr3.Visible = true
local layout3 = Instance.new("UIGridLayout")
layout3.Parent = fr3
layout3.SortOrder = "LayoutOrder"
layout3.CellPadding = UDim2.new(0,0,0,5)
layout3.CellSize = UDim2.new(1,0,0,20)
layout3.HorizontalAlignment = "Center"
local corner3 = Instance.new("UICorner")
corner3.Parent = fr3
corner3.CornerRadius = corner
local stroke3 = Instance.new("UIStroke")
stroke3.Parent = fr3
stroke3.ApplyStrokeMode = "Border"
stroke3.Thickness = 2

local fr32 = Instance.new("Frame", scgui) -- Holds teleports
fr32.Name = "fr32"
fr32.ZIndex = -4
fr32.BackgroundTransparency = 0
fr32.BorderSizePixel = 0
fr32.BackgroundColor3 = colortheme
fr32.Visible = false
local layout32 = Instance.new("UIGridLayout")
layout32.Parent = fr32
layout32.SortOrder = "LayoutOrder"
layout32.CellPadding = UDim2.new(0,0,0,5)
layout32.CellSize = UDim2.new(1,0,0,20)
layout32.HorizontalAlignment = "Center"
local corner32 = Instance.new("UICorner")
corner32.Parent = fr32
corner32.CornerRadius = corner
local stroke32 = Instance.new("UIStroke")
stroke32.Parent = fr32
stroke32.ApplyStrokeMode = "Border"
stroke32.Thickness = 2

local srvrs = Instance.new("TextButton")
srvrs.Parent = scgui

function rainbow(object, property, which)
	if not object:FindFirstChild(property.."_Rainbow") then
		local a = Instance.new("BoolValue")
		a.Parent = object
		a.Name = property.."_Rainbow"
		table.insert(which, {object, property})
	end
end

local buttons = { -- Frame, ButtonName, Class, BG Color, Txt Color
	-- "R" = Rainbow
	-- All buttons will become colortheme with an outline
	{2,"Display","TextLabel",},
	{2,"HP","TextLabel",},
	{2,"Formlbl","TextLabel",},
	{2,"Quest","TextLabel",},
	{2,"Fusion","TextLabel",},
	{2,"Zeni","TextLabel",},
	{2,"Copy Stats","TextButton", Color3.new(.15,.15,.15), Color3.new(1,1,1)},
	{2,"View","TextButton", Color3.new(.15,.15,.15),"R"},
	{2,"Teleport","TextButton", Color3.new(.15,.15,.15),"R"},
	{3,"Ping","TextLabel", nil,"R"},
	{3,"FlySpeed","TextBox", "R",Color3.new(1,1,1)},
	{3,"Suicide","TextButton", Color3.new(0,0,0), Color3.new(1,0,0)},
	{3,"Abbreviate","TextButton", Color3.new(.15,.15,.15)},
	{3,"ESPHighlight","TextButton", Color3.new(.15,.15,.15)},
	{3,"ESPLabels","TextButton", Color3.new(.15,.15,.15)},
	{3,"Stack","TextButton", Color3.new(.15,.15,.15)},
	{3,"Block","TextButton", Color3.new(.15,.15,.15)},
}

function addbutton(button)
	local lbl = Instance.new(button[3])
	lbl.TextScaled = false
	if button[1] == 2 then
		lbl.Parent = fr2
		lbl.TextSize = 15
	elseif button[1] == 3 then
		lbl.Parent = fr3
		lbl.TextSize = 15
	elseif button[1] == 4 then
		lbl.Parent = fr32
		lbl.TextXAlignment = "Left"
	end
	lbl.ZIndex = lbl.Parent.ZIndex + 1
	lbl.Name = button[2]
	lbl.BackgroundTransparency = .5
	if button[3] ~= "TextLabel" then
		lbl.Text = button[2]
	else 
		lbl.BackgroundTransparency = 1
	end
	lbl.Font = Enum.Font.Code
	lbl.BorderSizePixel = 0
	if button[4] then
		if button[4] == "R" then
			rainbow(lbl, "BackgroundColor3",rainbows)
		else
			lbl.BackgroundColor3 = button[4]
		end
	else
		lbl.BackgroundColor3 = colortheme
	end
	lbl.TextColor3 = Color3.new(1,1,1)
	if button[5] then
		if button[5] == "R" then
			rainbow(lbl, "TextColor3",rainbows)
		else 
			lbl.TextColor3 = button[5]
		end
	end
	lbl.LayoutOrder = i
	local corner = Instance.new("UICorner")
	corner.Parent = lbl
	--corner.CornerRadius = corner
	return lbl
end

for i,button in pairs(buttons) do
	addbutton(button)
end

local b = Instance.new("TextButton")--addbutton({4, "Beerus", "TextButton", Color3.new(.5,0,.5)})
b.Parent = scgui
b.Name = "TP_Beerus"
b.Size = UDim2.new(.017,0,0,30)
b.Position = UDim2.new(.95,0,-.1,0)
b.BackgroundColor3 = colortheme
b.BackgroundTransparency = .5
b.Font = Enum.Font.Gotham
b.TextStrokeTransparency = 1
b.TextSize = 30
local bcorner = Instance.new("UICorner")
bcorner.Parent = b
bcorner.CornerRadius = UDim.new(0,5)

srvrs.Size = UDim2.new(.017,0,0,30)
srvrs.Position = UDim2.new(.93,5,-.1,0)
srvrs.BackgroundColor3 = Color3.new(.1,.1,.1)
srvrs.BackgroundTransparency = .5
srvrs.TextColor3 = Color3.new(1,0,0)
srvrs.TextStrokeTransparency = 1
srvrs.BorderSizePixel = 0
srvrs.TextScaled = true
srvrs.Text = "S"
srvrs.Activated:Connect(function()
	pcall(function()
		game.CoreGui["ServerBrowser"]:Destroy()
	end)
	loadstring(game:HttpGet('https://gist.githubusercontent.com/JellyJrl/894aec3c4cbf7a698339515656be7af9/raw/serverlist'))()
end)
local scorner = Instance.new("UICorner")
scorner.Parent = srvrs
scorner.CornerRadius = UDim.new(0,5)

local job = Instance.new("TextLabel")--addbutton({4, "Beerus", "TextButton", Color3.new(.5,0,.5)})
job.Parent = scgui
job.Name = "JobId"
job.Size = UDim2.new(.1225,0,0,30)
job.Position = UDim2.new(.8,0,-.1,0)
job.BackgroundColor3 = colortheme
job.BackgroundTransparency = .5
job.Font = Enum.Font.Gotham
job.TextStrokeTransparency = 1
job.TextColor3 = Color3.new(1,1,1)
job.TextScaled = true
job.TextSize = 30
job.Text = game.JobId
local jobcorner = Instance.new("UICorner")
jobcorner.Parent = job
jobcorner.CornerRadius = UDim.new(0,5)

if game.Workspace.Others.NPCs:FindFirstChild("Kid Nohag") then
	b.Text = "B"
	b.TextColor3 = Color3.new(1,0,1)
	b.Activated:Connect(function()
		game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
	end)
else 
	b.Text = "E"
	b.TextColor3 = Color3.new(0,1,0)
	b.Activated:Connect(function()
		game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
	end)
end

fr32.Size = UDim2.new(.1,0,0,25*(#fr32:GetChildren()-3)-5)


local display = fr2.Display
local hp = fr2.HP
local quest = fr2.Quest
local zeni = fr2.Zeni
local fusion = fr2.Fusion
local formlbl = fr2.Formlbl
local CopyStats = fr2["Copy Stats"]
local View = fr2.View
local Teleport = fr2.Teleport
local pingL = fr3.Ping
local espH = fr3.ESPHighlight
local espL = fr3.ESPLabels
local Block = fr3.Block
local Abbreviate = fr3.Abbreviate
local Suicide = fr3.Suicide
local SpeedBox = fr3.FlySpeed
local Stack = fr3.Stack

L2_Offset = layout2.CellSize.Y.Offset
L2_Cushion = layout2.CellPadding.Y.Offset
fr2.Size = UDim2.new(1,-4,0,((L2_Offset+L2_Cushion)*(#fr2:GetChildren()-3))-5)

fr3.Size = UDim2.new(.1,0,0,(25*(#fr3:GetChildren()-3))-5)
fr32.Position = UDim2.new(.75,0,1,(-25*(#fr32:GetChildren()-3)+5)) -- Starting position, slides down

formlbl.Text = "Not Fused"

local f3p = fr3.Position -- Original Position
fr3.MouseEnter:Connect(function()
	game:GetService("TweenService"):Create(fr3, TweenInfo.new(.2), {Position = f3p + UDim2.new(0,0,0,-(25*(#fr3:GetChildren()-3)))}):Play()
end)
fr3.MouseLeave:Connect(function()
	game:GetService("TweenService"):Create(fr3, TweenInfo.new(.2), {Position = UDim2.new(.31,0,1,-20)}):Play()
end)
-- rainbow(object, property which)
rainbow(stroke1, "Color", rainbows)
rainbow(stroke2, "Color", rainbows)
rainbow(stroke3, "Color", rainbows)
rainbow(stroke32, "Color", rainbows)

--[[Teleport.Activated:Connect(function()
    local targetp = targetval.Value
    if targetp ~= nil and targetp ~= lplr and targetp.Character then
        local targetc = targetp.Character
        if not (targetc and lplr.Character) then return end
        local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
        if targetc:FindFirstChild("Head") and hrp then
            hrp.CFrame = targetc.Head.CFrame * CFrame.new(0,3,0)
            hrp.Velocity = Vector3.new(0,0,0)
            lplr.Character.Humanoid:ChangeState(14)
        end
    end
end)]]

Stack.MouseButton1Up:Connect(function()
	local form = lplr.Status:WaitForChild("Transformation").Value
	if form ~= "None" then
		game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(form)
		game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
		-- unform
	end
	lplr.Character:BreakJoints()
	task.wait(5)

	game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer("Godly SSJ2")
	game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
	
	if ldata.Allignment.Value == "Evil" then
		game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer("Ultra Ego")
	else
		game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer("SSJBUI")
	end
	game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
end)

--Flyspeed
SpeedBox.FocusLost:Connect(function()
	if tonumber(SpeedBox.Text) then
		while tonumber(SpeedBox.Text) and _G.AY == r and task.wait() do
			while not lplr.Character:FindFirstChild("HumanoidRootPart") do wait() end
			local s = tonumber(SpeedBox.Text)
			if _G.Fast == true then
				lplr.Character.HumanoidRootPart.Anchored = false
				if s < 1e6 then -- If number is below 1M do that sps, otherwise do that stat speed
					getrenv()._G.FlightSpeed = s
					lplr.Character.Humanoid.WalkSpeed = s/1.5
				else
					getrenv()._G.FlightSpeed = 150 + (s^.2)
					lplr.Character.Humanoid.WalkSpeed = 150 + ((s^.2)/1.5)
				end
			end
		end
	else
		SpeedBox.Text = "FlySpeed"
	end
end)


CopyStats.Activated:Connect(function()
    local plr = game.Players:FindFirstChild(targetval.Value.Name)
    if plr then
        local data = game.ReplicatedStorage.Datas:WaitForChild(plr.UserId)
        local nam = "("..plr.Name..", "..plr.DisplayName..")"
        if plr.Name == plr.DisplayName then
            nam = "("..plr.Name..")"
        end
        local strength = format(data.Strength.Value)
        local zeni = format(data.Zeni.Value)
        local rebs = data.Rebirth.Value
        local rebst = rebs
        local stats = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
        local statFormatted = format(stats)
        local health = format(plr.Character:WaitForChild("Humanoid").Health)
        
        local maxMastery = 332526
        local maxedTransformations = {}
        local transformations = { 
            'Divine Rose Prominence', 'Astral Instinct', 'Ultra Ego', 'SSJB4', 'True God of Creation', 
            'True God of Destruction', 'Super Broly', 'LSSJG', 'LSSJ4', 'SSJG4', 'LSSJ3', 'Mystic Kaioken', 
            'LSSJ Kaioken', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 
            'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 
            'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 
            'SSJ Blue', 'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 
            'Spirit SSJ', 'SSJ2 Majin', 'SSJ2', 'SSJ Kaioken', 'SSJ', 'FSSJ', 'Kaioken'
        }

        for _, transformation in ipairs(transformations) do
            if data:FindFirstChild(transformation) and data[transformation].Value == maxMastery then
                table.insert(maxedTransformations, transformation)
            end
        end

        local transformationsText = ""
        if #maxedTransformations > 0 then
            transformationsText = " | Maxed: " .. table.concat(maxedTransformations, ", ")
        end

        local txt = "["..strength.."] ["..zeni.."] | "..nam..", Rebirths: "..rebst.." Stats: "..statFormatted.." ["..health.."]"..transformationsText
        setclipboard(txt)
    end
end)

_G.Down = nil
Teleport.MouseButton1Down:Connect(function()
	_G.Down = "One"
end)
Teleport.MouseButton1Up:Connect(function()
	_G.Down = nil
end)

function Mel()
local lplr = game.Players.LocalPlayer

local moves = { 
    "Super Dragon Fist", "God Slicer", "Spirit Barrage", "Mach Kick", "Wolf Fang Fist", 
    "High Power Rush", "Meteor Strike", "Meteor Charge", "Spirit Breaking Cannon", 
    "Vital Strike", "Flash Kick", "Vanish Strike", "Uppercut", "Sledgehammer", "Rock Impact" 
}

for _, move in ipairs(moves) do
    if not lplr:FindFirstChild("Status"):FindFirstChild(move) then
        game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(move, "Blacknwhite27")
        game.ReplicatedStorage.Package.Events.voleys:InvokeServer("Energy Volley", {FaceMouse = false, MouseHit = CFrame.new()}, "Blacknwhite27")               
        game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")            
    end
end
end

spawn(function()
	while _G.AY == r do
		task.spawn(function()
			if _G.Down then
				local targetp = targetval.Value -- Player value
				if targetp ~= nil and targetp ~= lplr then
					local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(targetp.UserId)
					local targetc = targetp.Character
					if not (targetc and lplr.Character) then task.wait() return end
					local hrp = lplr.Character:FindFirstChild("HumanoidRootPart")
					--task.spawn(function()
						if ldata.Quest.Value ~= data.Quest.Value and data.Quest.Value ~= "" then
							game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(game.Workspace.Others.NPCs[data.Quest.Value])
							lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
						end
					--end)
					task.spawn(function()
						if targetc:FindFirstChild("HumanoidRootPart") and hrp then
							if _G.Down == "One" then
								hrp.CFrame = targetc.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
								Mel()
							end
							hrp.Velocity = Vector3.new(0,0,0)
							lplr.Character.Humanoid:ChangeState(14)
						end
					end)
				end
			end
		end)
		task.wait()
	end
end)

local togglescgui = scgui.Parent:FindFirstChild("togglescgui") or Instance.new("ScreenGui")
togglescgui.Parent = scgui.Parent
togglescgui.Name = "togglescgui"
local ToggleGuiButton = scgui.Parent:FindFirstChild("ToggleGuiButton") or Instance.new("TextButton")--addbutton({4, "Beerus", "TextButton", Color3.new(.5,0,.5)})
ToggleGuiButton.Parent = togglescgui
ToggleGuiButton.Name = "ToggleGuiButton"
ToggleGuiButton.Size = UDim2.new(.05,0,0,30)
ToggleGuiButton.Position = UDim2.new(.2,0,0,-31)
ToggleGuiButton.BackgroundColor3 = colortheme
ToggleGuiButton.BackgroundTransparency = .5
ToggleGuiButton.Font = Enum.Font.Gotham
ToggleGuiButton.TextStrokeTransparency = 1
ToggleGuiButton.TextColor3 = Color3.new(1,1,1)
ToggleGuiButton.TextScaled = true
ToggleGuiButton.TextSize = 30
ToggleGuiButton.Text = "Hide GUI"
ToggleGuiButton.TextColor3 = Color3.new(1,1,1)
local toggleguicorner = Instance.new("UICorner")
toggleguicorner.Parent = ToggleGuiButton
toggleguicorner.CornerRadius = UDim.new(0,5)

ToggleGuiButton.Activated:Connect(function()
	if scgui.Enabled == true then  -- If visible, and want to hide
		pcall(function()
			find_iy().Enabled = false
		end)
		scgui.Enabled = false
		vL.Visible = true
		ToggleGuiButton.Text = "Show GUI"
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true)
		game.CoreGui.Fernando.Enabled = false
		game.Players.LocalPlayer.PlayerGui:WaitForChild("Main").Enabled = true
	elseif scgui.Enabled == false then -- If hiding, and want to show
		scgui.Enabled = true		
		pcall(function()
			find_iy().Enabled = true
		end)
		vL.Visible = false
		ToggleGuiButton.Text = "Hide GUI"		
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		game.CoreGui.Fernando.Enabled = true
		game.Players.LocalPlayer.PlayerGui:WaitForChild("Main").Enabled = false
	end
end)

Suicide.MouseButton1Up:Connect(function()
    lplr.Character.UpperTorso:Destroy()
end)

local Viewing = Instance.new("ObjectValue")
Viewing.Parent = scgui
Viewing.Changed:Connect(function(val)
	if val == nil then return end
	local tplr = val
	while Viewing.Value == tplr and task.wait() and _G.AY == r do
		if s == lplr then Viewing.Value = nil return end
		while not tplr.Character do wait() end
		game.Workspace.CurrentCamera.CameraSubject = tplr.Character:WaitForChild("Humanoid")
	end
	if lplr.Status.Fused.Value == "None" then
		game.Workspace.CurrentCamera.CameraSubject = lplr.Character:WaitForChild("Humanoid")
	else
		game.Workspace.CurrentCamera.CameraSubject = game.Players[lplr.Status.Fused.Value].Character:WaitForChild("Humanoid")
	end
end)

View.Activated:Connect(function()
	local tplr = targetval.Value
	local v = Viewing.Value
	if Viewing.Value ~= tplr and tplr ~= lplr then -- If not viewing plr, and isn't lplr
		Viewing.Value = tplr
		View.Text = "UnView"
	elseif Viewing.Value == tplr and tplr ~= lplr then -- If alr viewing plr, and isnt lplr
		Viewing.Value = nil
		View.Text = "View"
	elseif Viewing.Value ~= tplr and tplr == lplr then -- If not viewing yourself
		Viewing.Value = nil
		View.Text = "Viewing Yourself"
	elseif Viewing.Value == tplr and tplr == lplr then -- You're already viewing yourself
	end
end)

function getchr(plr)
	return plr.Character
end

-- ESPh
_G.esph = false
if _G.esph == true then
	espH.Text = "Disable ESPH"
else
	espH.Text = "Enable ESPH"
end

function ESPH()
	if _G.esph == true then
		_G.esph = false
		espH.Text = "Enable ESPH"
		for i,gui in pairs(espdirectory:GetChildren()) do
			--gui.Enabled = false
			gui.Highlight.Enabled = false
		end
	elseif _G.esph == false then
		_G.esph = true
		espH.Text = "Disable ESPH"
		for i,gui in pairs(espdirectory:GetChildren()) do
			--gui.Enabled = true
			gui.Highlight.Enabled = true
		end
	end
end
espH.MouseButton1Up:Connect(function()
	ESPH()
end)

-- ESPh
_G.espl = true
if _G.esp == true then
	espL.Text = "Disable ESPL"
else
	espL.Text = "Enable ESPL"
end

function ESPL()
	if _G.espl == true then
		_G.espl = false
		espL.Text = "Enable ESPL"
		for i,gui in pairs(espdirectory:GetChildren()) do
			gui.Enabled = false
			--gui.Highlight.Enabled = false
		end
	elseif _G.espl == false then
		_G.espl = true
		espL.Text = "Disable ESPL"
		for i,gui in pairs(espdirectory:GetChildren()) do
			gui.Enabled = true
			--gui.Highlight.Enabled = true
		end
	end
end
espL.MouseButton1Up:Connect(function()
	ESPL()
end)

--Stat abbreviations
_G.Abv = false
if _G.Abv == true then
	Abbreviate.Text = "UnAbbreviate"
else 
	Abbreviate.Text = "Abbreviate"
end
function abv()
	if _G.Abv == false then
		_G.Abv = true
		Abbreviate.Text = "UnAbbreviate"
	else 
		_G.Abv = false
		Abbreviate.Text = "Abbreviate"
	end
end
Abbreviate.MouseButton1Up:Connect(function()
	abv()
end)

--Block
function block()
	if not (lplr.Character and lplr.Status:FindFirstChild("Blocking")) then return end
	game:GetService("ReplicatedStorage").Package.Events.block:InvokeServer(true)
end
Block.MouseButton1Up:Connect(function()
	block()
end)

targetval = Instance.new("ObjectValue")-- This will change when you click on a player's label, and open frame 2
targetval.Changed:Connect(function()
	if _G.AY ~= r then return end
	if targetval.Value ~= nil then
		if Viewing.Value ~= targetval.Value and targetval.Value ~= lplr then
			View.Text = "View"
		elseif Viewing.Value == targetval.Value and targetval.Value ~= lplr then
			View.Text = "UnView"
		elseif Viewing.Value == nil and targetval.Value == lplr then
			View.Text = "Viewing Yourself"
		elseif Viewing.Value ~= targetval.Value and targetval.Value == lplr then
			View.Text = "View Yourself"
		end
	end
	local target = targetval.Value
	local plr = target
	if target ~= nil then
		game:GetService("TweenService"):Create(fr2, TweenInfo.new(.3), {Position = UDim2.new(0,2,0,4)}):Play()
		local data = game.ReplicatedStorage.Datas:WaitForChild(target.UserId)
		while target == targetval.Value and game.Players:FindFirstChild(target.Name) and _G.AY == r do
			if not target.Character then
				for i,plr in pairs(game.Players:GetChildren()) do -- Looks for all characters that exist 
					-- If this is a plr chr, and has fusion value, 
					if plr:WaitForChild("Status"):FindFirstChild("Fused") then
						if plr.Status.Fused.Value == target.Name then
							hp.Text = "Fused with "..plr.Name
							fusion.Text = "Fused with "..plr.Name
						end 
					end 
				end 
			elseif target.Character and target.Character:FindFirstChild("HumanoidRootPart") and target.Character:FindFirstChild("Humanoid") then
				local st = plr:FindFirstChild("Status")
				if st then
					local fused = st.Fused.Value
					if fused ~= "None" and workspace.Living:FindFirstChild(fused) then -- If not unfused, and this value is a string
						hp.Text = "Fused with "..fused
					else
						hp.Text = "HP: "..format(target.Character.Humanoid.Health).."/"..format(target.Character.Humanoid.MaxHealth)
					end
					if fused ~= "None" then
						fusion.Text = "Fused with "..fused
					else
						fusion.Text = "Not Fused"
					end
					local form = plr.Status:WaitForChild("Transformation").Value
					if form ~= "None" then
						formlbl.Text = form
					else 
						formlbl.Text = "No Form"
					end
				else
					hp.Text = "HP: "..format(target.Character.Humanoid.Health).."/"..format(target.Character.Humanoid.MaxHealth)
					fusion.Text = "Not loaded"
					formlbl.Text = "Not loaded"
				end
			end
			--"<b><font color='rgb(0,0,0)'>", "</font></b>"
			display.RichText = true
			display.Text = target.Name
			display.TextColor3 = Color3.new(1,0,0)
			if data.Allignment.Value == "Good" then
				display.TextColor3 = Color3.fromRGB(150,150,255)
			end
			zeni.Text = "Zeni: "..format(data.Zeni.Value)
			local qval = data.Quest.Value
			if qval == "" then
				quest.Text = "No Quest"
			else
				quest.Text = "Quest: "..qval
			end
			task.wait()
		end
	else 
		game:GetService("TweenService"):Create(fr2, TweenInfo.new(.3), {Position = UDim2.new(1,4,0,4)}):Play()
		wait(.3)
	end
end)

local numplrs = Instance.new("TextLabel")
numplrs.Parent = scgui
numplrs.Size = UDim2.new(.4,0,0,36)
numplrs.Position = UDim2.new(.3,0,-.1,0)
numplrs.BackgroundTransparency = 1
numplrs.Font = Enum.Font.Gotham
numplrs.TextColor3 = Color3.new(1,1,1)
numplrs.TextStrokeColor3 = Color3.new(.2,.2,.2)
numplrs.TextStrokeTransparency = 0
numplrs.TextSize = 30

local formmastery = Instance.new("TextLabel")
formmastery.Parent = scgui
formmastery.Size = UDim2.new(.04,0,0,36)
formmastery.Position = UDim2.new(.55,0,-.1,0)
formmastery.BackgroundTransparency = 1
formmastery.Font = Enum.Font.Gotham
formmastery.TextColor3 = Color3.new(1,1,1)
formmastery.TextStrokeColor3 = Color3.new(.2,.2,.2)
formmastery.TextStrokeTransparency = 0
formmastery.TextSize = 15

function find_iy()
	for i,v in pairs(game.CoreGui:GetDescendants()) do
		if v:FindFirstChild("SettingsButton") then
			return v:FindFirstAncestorOfClass("ScreenGui")
		end
	end
end

-- Key Inputs
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(key)
	if _G.AY ~= r then return end
	if key.KeyCode == Enum.KeyCode.KeypadOne then -- Disable ESP and the gui
		if scgui.Enabled == true then 
			pcall(function()
				find_iy().Enabled = false
			end)
			scgui.Enabled = false
			vL.Visible = true
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true)
		elseif scgui.Enabled == false then 
			scgui.Enabled = true
			pcall(function()
				find_iy().Enabled = true
			end)
			vL.Visible = false
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		end
	end
	if key.KeyCode == Enum.KeyCode.KeypadTwo then block() end -- Block
	if key.KeyCode == Enum.KeyCode.KeypadSeven then abv() end -- Abbreviate
	if key.KeyCode == Enum.KeyCode.KeypadEight then ESPL()  end -- ESP Labels
	if key.KeyCode == Enum.KeyCode.KeypadNine then ESPH()  end -- ESP Highlights
	if key.KeyCode == Enum.KeyCode.LeftShift then _G.Fast = true  end -- Fast Fly
	if key.KeyCode == Enum.KeyCode.X then
		if lplr.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame:WaitForChild("ChatBar"):IsFocused() then return end
		charging = true
		while charging and _G.AY == r do game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27") task.wait() end
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(key)
	if _G.AY ~= r then return end
	if key.KeyCode == Enum.KeyCode.LeftShift then -- Stop fast fly
		_G.Fast = false
	end
	if key.KeyCode == Enum.KeyCode.X then
		if not table.find(alts, lplr.Name) then return end
		if lplr.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame:WaitForChild("ChatBar"):IsFocused() then return end
		charging = false
	end
end)


local rebcolors = { -- >Rebs, Textcolor
	{50000,Color3.fromRGB(255,255,255), "<i><font color='rgb(255,255,255)'>", "</font></i>"}, -- Italic 
	{33333,Color3.fromRGB(0,0,0), "<b><font color='rgb(0,0,0)'>", "</font></b>"}, -- Bold Black
	{20000,Color3.fromRGB(255,255,255), "<i><b><font color='rgb(255,255,255)'>", "</font></b></i>"}, -- Bold Italic White with fast rainbow outline
	{10000,Color3.fromRGB(0,0,0), "<i><b><font color='rgb(0,0,0)'>", "</font></b></i>"}, -- Bold Italic Black with slow rainbow outline
	{5000,Color3.fromRGB(0,255,255), "<b><font color='rgb(0,255,255)'>", "</font></b>"}, -- Bolded Teal
	{2500,Color3.fromRGB(255,0,0), "<b><font color='rgb(255,0,0)'>", "</font></b>"}, -- Bolded Red
	{1000,Color3.fromRGB(255,200,0), "<b><font color='rgb(255,200,0)'>", "</font></b>"}, -- Bolded Orange
	{100,Color3.fromRGB(255,255,255), "<font color='rgb(255,255,255)'>", "</font>"}, -- White
	{3,Color3.fromRGB(0,150,0), "<font color='rgb(0,200,0)'>", "</font>"}, -- Forest Green
	{0,Color3.fromRGB(100,100,100), "<font color='rgb(100,100,100)'>", "</font>"}, -- Gray
}
local statcolors = {
	{1e16,Color3.fromRGB(255,0,255), "<i><b><font color='rgb(255,0,255)'>", "</font></b></i>"}, -- 10qd+ Purple with thin black outline
	{1e15,Color3.fromRGB(255,255,255), "<i><b><font color='rgb(255,255,255)'>", "</font></b></i>"}, -- 1qd+ White with fast rainbow outline
	{1e14,Color3.fromRGB(0,0,0), "<i><b><font color='rgb(0,0,0)'>", "</font></b></i>"}, --- 100T - 1qd Black with slow rainbow outline
	{1e13,Color3.fromRGB(0,255,255), "<i><b><font color='rgb(0,255,255)'>", "</font></b></i>"}, -- 10T - 100T Cyan
	{1e12,Color3.fromRGB(255,0,0), "<i><b><font color='rgb(255,0,0)'>", "</font></b></i>"}, -- 1T - 10T Red
	{1e11,Color3.fromRGB(75,75,255), "<b><font color='rgb(75,75,255)'>", "</font></b>"}, -- 100B - 1T Blue
	{1e9,Color3.fromRGB(250,255,0), "<b><font color='rgb(255,255,0)'>", "</font></b>"}, -- 1B - 100B Yellow
	{1e8,Color3.fromRGB(255,255,255), "<font color='rgb(255,255,255)'>", "</font>"}, -- 100M - 1B White
	{1e6,Color3.fromRGB(0,150,0), "<font color='rgb(0,200,0)'>", "</font>"}, -- 1M - 100M Green
	{0,Color3.fromRGB(100,100,100), "<font color='rgb(100,100,100)'>", "</font>"},-- 0 - 1M gray
}


local labels = { -- Name, XSize, XPos
	{"Rebs",.2,0},
	{"PlrName",.6,.2},
	{"Stats",.2,.79},
}

local function esp(plr)
	if _G.AY ~= r then return end
	while not (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.MaxHealth ~= 413) do
		if _G.AY ~= r then return end
		wait()
	end
	local sgui = espdirectory:FindFirstChild("ESP_"..plr.Name)
	if not (sgui and sgui:FindFirstChild("Lbl")) then
		local chr = plr.Character
		local espgui = Instance.new("BillboardGui")
		espgui.Parent = espdirectory
		local sgui = espdirectory:FindFirstChild("ESP_"..plr.Name)
		if sgui then 
			espgui:Destroy() 
			espgui = sgui
		end
		espgui.Name = "ESP_"..plr.Name
		espgui.Adornee = chr:WaitForChild("Head")
		espgui.MaxDistance = math.huge
		espgui.Size = UDim2.new(0,100,0,150)
		espgui.ZIndexBehavior = "Global"
		espgui.StudsOffset = Vector3.new(0,3,0)
		espgui.ResetOnSpawn = false
		espgui.AlwaysOnTop = true
		local Lbl = Instance.new("TextLabel")
		if _G.espl == false then
			espgui.Enabled = false
		end
		Lbl.Parent = espgui
		Lbl.Name = "Lbl"
		Lbl.Position = UDim2.new(0,-150,0,-50)
		Lbl.Size = UDim2.new(0,400,0,100)
		Lbl.TextSize = 20
		Lbl.BackgroundTransparency = 1
		Lbl.TextStrokeTransparency = 1
		Lbl.Font = Enum.Font.Gotham
		Lbl.RichText = true
		Lbl.ZIndex = 10
		Lbl.TextYAlignment = "Bottom"
		local hi = Instance.new("Highlight")
		if _G.esph == false then
			hi.Enabled = false
		end
		hi.Parent = espgui
		hi.FillTransparency = .6 
		hi.OutlineTransparency = 0
		--hpbar
		local hpbar = Instance.new("Frame")
		hpbar.Parent = espgui
		hpbar.Name = "green"
		hpbar.Size = UDim2.new(0,100,0,2)
		hpbar.Position = UDim2.new(0,0,0,60)
		hpbar.BackgroundColor3 = Color3.new(1,0,0)
		hpbar.BorderSizePixel = 0
		local green = Instance.new("Frame")
		green.Parent = hpbar
		green.Name = "bar"
		green.Size = UDim2.new(1,0,0,2)
		green.Position = UDim2.new(0,0,0,0)
		green.BackgroundColor3 = Color3.new(0,1,0)
		green.BorderSizePixel = 0
		--kibar
		local kibar = Instance.new("Frame")
		kibar.Parent = espgui
		kibar.Name = "blue"
		kibar.Size = UDim2.new(0,100,0,2)
		kibar.Position = UDim2.new(0,0,0,65)
		kibar.BackgroundColor3 = Color3.new(.15,.15,.15)
		kibar.BorderSizePixel = 0
		local blue = Instance.new("Frame")
		blue.Parent = kibar
		blue.Name = "bar"
		blue.Size = UDim2.new(1,0,0,2)
		blue.Position = UDim2.new(0,0,0,0)
		blue.BackgroundColor3 = Color3.new(0,.5,1)
		blue.BorderSizePixel = 0
	end
	task.wait()
	local sgui = espdirectory:FindFirstChild("ESP_"..plr.Name)
	pcall(function()
		sgui.Adornee = plr.Character:WaitForChild("Head")
	end)
	local hi = sgui.Highlight
	hi.Adornee = plr.Character
	if _G.esph == true then 
		hi.Enabled = true 
	else 
		hi.Enabled = false 
	end
	local Lbl = sgui.Lbl
	local data = plr.Character:WaitForChild("Stats")
	local function avg()
		return (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
	end
	local function rebs()
		return data.Rebirth.Value
	end
	local function statcolor()
		for i,v in pairs(statcolors) do
			if avg() >= v[1] then
				return {v[3],v[4],v[2]}
			end
		end
	end
	local function rebcolor()
		for i,v in pairs(rebcolors) do
			if rebs() >= v[1] then
				return {v[3],v[4],v[2]}
			end
		end
	end
	local function getname()
		if plr.Name == plr.DisplayName then
			return "("..plr.Name..")"
		else
			return "("..plr.Name..", "..plr.DisplayName..")"
		end
	end
	local rc = rebcolor()
	local sc = statcolor()
	local nam = getname()
	local hum = plr.Character:WaitForChild("Humanoid")

	if rebs() >= 100000 then
		Lbl.Font = Enum.Font.SpecialElite
		Lbl.TextSize = 20

		Lbl.TextColor3 = Color3.new(1,1,1)
		local grad = Lbl:FindFirstChild("UIGradient") or Instance.new("UIGradient",Lbl)
		grad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
			ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
			ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
		}
		if Lbl.TextStrokeTransparency ~= 0 then
			Lbl.TextStrokeTransparency = 0
			rainbow(Lbl, "TextStrokeColor3", rainbows)
		end
	elseif rebs() >= 50000 then
		hi.FillTransparency = 0
		hi.FillColor = Color3.new(.5,.5,.5)
		hi.OutlineColor = Color3.new(1,0,1)
		Lbl.TextStrokeTransparency = .5
		Lbl.TextTransparency = 0
		Lbl.TextColor3 = Color3.new(1,1,1)
		Lbl.TextStrokeColor3 = Color3.new(1,0,1)
		Lbl.Font = Enum.Font.GothamBold
		Lbl.TextSize = 20
		local grad = Lbl:FindFirstChild("UIGradient") or Instance.new("UIGradient",Lbl)
		grad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
			ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
			ColorSequenceKeypoint.new(1, Color3.new(.3,.3,.3)),
		}

		grad.Rotation = 0
        rc = {"<i>","</i>",Color3.new(1,0,1)} -- Fill
		sc = {"<i>","</i>",Color3.new(0,0,0)} -- Outline
	elseif rebs() >= 33333 then
		hi.FillTransparency = 0
		hi.FillColor = Color3.new(0,0,0)
		hi.OutlineColor = Color3.new(1,1,1)
		Lbl.TextStrokeTransparency = 0
		Lbl.TextTransparency = 0
		Lbl.TextStrokeColor3 = Color3.new(1,1,1)
		rc = {"<b>","</b>",Color3.new(0,0,0)} -- Fill
		sc = {"<b>","</b>",Color3.new(1,1,1)} -- Outline
	elseif avg() >= 1e15 then
		if Lbl.TextStrokeTransparency ~= 0 then 
			Lbl.TextStrokeTransparency = 0
			spawn(function()
				while avg() >= 1e15 and task.wait(.1) and _G.AY == r do
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.1), {TextStrokeColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.1), {OutlineColor = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
				end
				Lbl.TextStrokeTransparency = 1
			end)
		end
	elseif avg() >= 1e14 then
		if Lbl.TextStrokeTransparency ~= 0 then
			Lbl.TextStrokeTransparency = 0
			spawn(function()
				while avg() >= 1e14 and task.wait(.5) and _G.AY == r do 
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.5), {TextStrokeColor3 = c}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.5), {OutlineColor = c}):Play()
				end
				Lbl.TextStrokeTransparency = 1
			end)
		end
	else 
		if rebs() < 10000 then
			Lbl.TextStrokeTransparency = 1
		end
		hi.OutlineColor = sc[3]
	end
	if rebs() >= 33333 then
	elseif rebs() >= 20000 then 
		if math.floor(hi.FillTransparency*10)/10 ~= .4 then
			hi.FillTransparency = .4
			Lbl.TextStrokeTransparency = 0
			task.spawn(function()
				while rebs() < 33333 and task.wait(.1) and _G.AY == r do 
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.1), {TextStrokeColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.1), {FillColor = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
				end
				hi.FillTransparency = 1
				Lbl.TextStrokeTransparency = 1
			end)
		end
	elseif rebs() >= 10000 then
		if math.floor(hi.FillTransparency*10)/10 ~= .5 then
			task.spawn(function()
				while rebs() < 20000 and task.wait(.5) and _G.AY == r do 
					hi.FillTransparency = .5
					Lbl.TextStrokeTransparency = 0
					game:GetService("TweenService"):Create(Lbl, TweenInfo.new(.5), {TextStrokeColor3 = c}):Play()
					game:GetService("TweenService"):Create(hi, TweenInfo.new(.5), {FillColor = c}):Play()
				end 
				hi.FillTransparency = 1
				Lbl.TextStrokeTransparency = 1
			end)
		end
	else
		hi.FillColor = rc[3]
	end
	Lbl.Text = rc[1]..format2(data.Rebirth.Value).." "..plr.DisplayName.." | "..rc[2]..sc[1]..format(avg()).." | "..format(hum.Health).."/"..format(hum.MaxHealth)..sc[2]
end

function iterPageItems(pages)
	return coroutine.wrap(function()
		local pagenum = 1
		while true do
			for _, item in ipairs(pages:GetCurrentPage()) do
				coroutine.yield(item, pagenum)
			end
			if pages.IsFinished then
				break
			end
			pages:AdvanceToNextPageAsync()
			pagenum = pagenum + 1
		end
	end)
end
local friendPages = game.Players:GetFriendsAsync(lplr.UserId)
local usernames = {}
for item, pageNo in iterPageItems(friendPages) do
	table.insert(usernames, item.Username)
end

-- Add a player
function addplr(plr)
	while not game.ReplicatedStorage.Datas:FindFirstChild(plr.UserId) do wait() end
	-- If target is hidden and plr not bypassed then hide
	local data = game.ReplicatedStorage.Datas:WaitForChild(plr.UserId)
	while not (
		data:FindFirstChild("Strength") and
			data:FindFirstChild("Rebirth") and
			data:FindFirstChild("Zeni")) do 
		wait() 
	end
	local avg = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4

	local button = Instance.new("TextButton")
	button.Parent = fr12
	local bcorner = Instance.new("UICorner")
	bcorner.Parent = button
	bcorner.CornerRadius = corner
	button.BorderSizePixel = 0
	button.Visible = true
	

	button.Size = UDim2.new(.9,0,1/18,0)
	button.Name = plr.Name
	button.TextScaled = false
	button.TextSize = 10
	button.RichText = true
	button.BackgroundColor3 = colortheme--Color3.new(0,0,0)

	button.Font = Enum.Font.Gotham
	button.BorderSizePixel = 0
	button.BackgroundTransparency = .5
	button.TextTransparency = 1
	button.Activated:Connect(function()
		if targetval.Value == plr then 
			targetval.Value = nil
		else
			targetval.Value = plr
		end
	end)
	button.MouseButton2Up:Connect(function()
		button.Visible = false
		wait(8)
		if button then button.Visible = true end
	end)

    local hpbar = Instance.new("Frame",button)
    hpbar.Size = UDim2.new(1,-2,0,2)
    hpbar.BackgroundColor3 = Color3.new(0,1,0)
    hpbar.BackgroundTransparency = .5
    hpbar.BorderSizePixel = 0
    hpbar.Position = UDim2.new(0,.5,0,0)
    hpbar.ZIndex = 1
    local hpcorner = Instance.new("UICorner",hpbar)
    hpcorner.CornerRadius = corner

	local avgval = Instance.new("NumberValue")
	avgval.Parent = button
	avgval.Name = "Avg"
	avgval.Value = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
	local rebsval = Instance.new("NumberValue")
	rebsval.Parent = button
	rebsval.Name = "Rebs"
	rebsval.Value = data.Rebirth.Value

	task.spawn(function()esp(plr)end)
	local function addchr(chr)
		if _G.AY ~= r then return end
		local sgui = espdirectory:WaitForChild("ESP_"..plr.Name)
		local greenbar = sgui.green.bar
		local bluebar = sgui.blue.bar
		local Ki = chr:WaitForChild("Stats"):WaitForChild("Ki")
		local hum = chr:WaitForChild("Humanoid")
		if data.Allignment.Value == "Good" then
			bluebar.BackgroundColor3 = Color3.new(0,.5,1)
		else
			bluebar.BackgroundColor3 = Color3.new(1,0,1)
		end
		sgui.Adornee = chr.Head
		sgui.Highlight.Adornee = chr
		if plr == lplr then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		end
		esp(plr)
		game:GetService("TweenService"):Create(greenbar , TweenInfo.new(1), {Size = UDim2.new(0,100/(hum.MaxHealth/hum.Health),0,2)}):Play()
		game:GetService("TweenService"):Create(bluebar , TweenInfo.new(1), {Size = UDim2.new(0,100*(Ki.Value/Ki.MaxValue),0,2)}):Play()
        game:GetService("TweenService"):Create(hpbar, TweenInfo.new(1), {Size = UDim2.new(hum.Health/hum.MaxHealth,-1,0,2)}):Play()
		pcall(function()
			Ki.Changed:Connect(function()
				if _G.AY ~= r then return end
				game:GetService("TweenService"):Create(bluebar , TweenInfo.new(1), {Size = UDim2.new(0,100*(Ki.Value/Ki.MaxValue),0,2)}):Play()
			end)
		end)
		hum.HealthChanged:Connect(function()
			if _G.AY ~= r then return end
			game:GetService("TweenService"):Create(greenbar , TweenInfo.new(1), {Size = UDim2.new(0,100/(hum.MaxHealth/hum.Health),0,2)}):Play()
			game:GetService("TweenService"):Create(bluebar , TweenInfo.new(1), {Size = UDim2.new(0,100*(Ki.Value/Ki.MaxValue),0,2)}):Play()
            game:GetService("TweenService"):Create(hpbar, TweenInfo.new(1), {Size = UDim2.new(hum.Health/hum.MaxHealth,-1,0,2)}):Play()
			esp(plr) 
		end)
	end
    plr.CharacterAdded:Connect(function(chr)
        if _G.AY == r then
            if plr == lplr then
                game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
            end
            addchr(chr)
        end
    end)

	if plr.Character then
		task.spawn(function()addchr(plr.Character)end)
	end

	for i,lblval in pairs(labels) do
		local l = Instance.new("TextLabel")
		l.Parent = button
		l.Name = lblval[1]
		l.Size = UDim2.new(lblval[2],0,1,0)
		l.Position = UDim2.new(lblval[3],0,0,0)
		l.TextColor3 = Color3.new(.1,.1,.1)
		l.BackgroundTransparency = 1
		l.TextScaled = false 
		l.TextSize = 15
		l.RichText = true
		l.Font = Enum.Font.Gotham
		l.BorderSizePixel = 0
		l.TextStrokeTransparency = 1

		if lblval[1] == "Rebs" then
			local t1 = tick()
			l.TextXAlignment = "Left"
			l.TextSize = 18
			function update()
				if _G.AY ~= r then return end
				spawn(function() esp(plr) end)
				local rebs = data.Rebirth.Value
				rebsval.Value = rebs
				if rebs >= 1000 then
					l.Text = "<b>"..format2(rebs).."</b>"
				else
					l.Text = rebs
				end
                if rebs >= 100000 then
                    l.Text = rebs
                    l.Font = Enum.Font.SpecialElite
                    l.TextSize = 20
                    l.TextColor3 = Color3.new(1,1,1)
                    local grad = Instance.new("UIGradient",l)
                    grad.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
                        ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
                        ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
                    }
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0
                        rainbow(l, "TextStrokeColor3", rainbows)
                    end
                elseif rebs >= 50000 then
                    l.Font = Enum.Font.GothamBold
                    l.TextSize = 20
                    l.TextColor3 = Color3.new(1,1,1)
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0 
                        local grad = Instance.new("UIGradient",l)
                        grad.Color = ColorSequence.new{
                            ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
                            ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
                            ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
                        }
                        grad.Rotation = -85
                    end
                elseif rebs >= 33333 then
                    l.TextStrokeTransparency = 0 
                    l.TextColor3 = Color3.new(0,0,0)
                    l.TextStrokeColor3 = Color3.new(1,1,1)
                elseif rebs >= 20000 then
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0
                        spawn(function()
                            while data:WaitForChild("Rebirth").Value < 33333 and task.wait(.1) do
                                game:GetService("TweenService"):Create(l, TweenInfo.new(.1), {TextStrokeColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))}):Play()
                            end
                            l.TextStrokeTransparency = 1
                        end)
                    end
                elseif rebs >= 10000  then
                    if l.TextStrokeTransparency ~= 0 then
                        l.TextStrokeTransparency = 0
                        spawn(function()
                            while data.Rebirth.Value < 20000 and task.wait(.5) do
                                game:GetService("TweenService"):Create(l, TweenInfo.new(.5), {TextStrokeColor3 = c}):Play()
                            end
                            l.TextStrokeTransparency = 1
                        end)
                    end
                elseif rebs < 10000 then
                    l.TextStrokeTransparency = 1
                end
                if rebs < 33333 then
                    for i,v in pairs(rebcolors) do
                        if rebs >= v[1] then
                            l.TextColor3 = v[2]
                            break
                        end
                    end
                end
			end
			while not data:FindFirstChild("Rebirth") do wait() end
			data:WaitForChild("Rebirth").Changed:Connect(update)
			update()
		elseif lblval[1] == "PlrName" then
			l.TextXAlignment = "Center"
		elseif lblval[1] == "Stats" then
			l.TextXAlignment = "Right"
			local plrnamelbl = button.PlrName
			l.TextSize = 15
			function update()
				if _G.AY ~= r then return end
				local avg = (data.Strength.Value + data.Speed.Value + data.Defense.Value + data.Energy.Value) / 4
				avgval.Value = avg
				if plr.Character and espdirectory then
					spawn(function() esp(plr) end)
				end
				button.LayoutOrder = -(math.sqrt(avg))
                if data.Rebirth.Value >= 33333 and data.Rebirth.Value < 50000 then
                    l.TextColor3 = Color3.new(0,0,0)
                    l.TextStrokeColor3 = Color3.new(1,1,1)
                    l.TextStrokeTransparency = 0
                    plrnamelbl.TextColor3 = Color3.new(0,0,0)
                    plrnamelbl.TextStrokeColor3 = Color3.new(1,1,1)
                    plrnamelbl.TextStrokeTransparency = 0
                elseif avg >= 1e16 or data.Rebirth.Value >= 33333 then
                else
                    for i,v in pairs(statcolors) do
                        if avg >= v[1] then
                            l.TextColor3 = v[2]
                            plrnamelbl.TextColor3 = v[2]
                            break
                        end
                    end
                end
				local friend = ""
				if table.find(usernames, plr.Name) then friend = " 😎 " end
				if data.Rebirth.Value >= 100000 then
					l.Font = Enum.Font.SpecialElite
					l.TextSize = 15
					l.Text = format(avg)
					l.TextColor3 = Color3.new(1,1,1)
					plrnamelbl.Font = Enum.Font.SpecialElite
					plrnamelbl.TextSize = 20
					plrnamelbl.Text = plr.Name
					plrnamelbl.TextColor3 = Color3.new(1,1,1)
					local grad = l:FindFirstChild("UIGradient") or Instance.new("UIGradient",l)
					grad.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
						ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
						ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
					}
					if l.TextStrokeTransparency ~= 0.1 then
						l.TextStrokeTransparency = 0.1
						rainbow(l, "TextStrokeColor3", rainbows)
					end
					local grad = plrnamelbl:FindFirstChild("UIGradient") or Instance.new("UIGradient",plrnamelbl)
					grad.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.new(.5,.5,1)),
						ColorSequenceKeypoint.new(.5, Color3.new(0,0,1)),
						ColorSequenceKeypoint.new(1, Color3.new(.5,.5,1)),
					}
					if plrnamelbl.TextStrokeTransparency ~= 0.1 then
						plrnamelbl.TextStrokeTransparency = 0.1
						rainbow(plrnamelbl, "TextStrokeColor3", rainbows)
					end
				elseif avg >= 1e16 then
					if l.TextStrokeTransparency ~= 0 then
						l.TextColor3 = Color3.new(1,1,1)
						l.TextStrokeTransparency = 0 
						l.TextSize = 20
						l.Font = Enum.Font.GothamBold
						l.Text = format(avg)
						local grad = Instance.new("UIGradient",l)
						grad.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
							ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
							ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
						}
						grad.Rotation = 85
						plrnamelbl.TextColor3 = Color3.new(1,1,1)
						plrnamelbl.TextStrokeTransparency = 0
						plrnamelbl.Font = Enum.Font.GothamBold
						plrnamelbl.Text = plr.DisplayName
						plrnamelbl.TextSize = 20
						local grad = Instance.new("UIGradient",plrnamelbl)
						grad.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.new(1,1,1)),
							ColorSequenceKeypoint.new(.5, Color3.new(1,0,1)),
							ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
						}
						grad.Rotation = 85
					end
                elseif avg >= 1e12 then
					if plr.Name == plr.DisplayName then
						plrnamelbl.Text = "<b><i>"..friend..""..plr.Name..friend.."</i></b>"
					else
						plrnamelbl.Text = "<b><i>"..friend..plr.DisplayName..friend.."\n<font size='10'>@"..plr.Name.."</font></i></b>"
					end
					l.Text = "<b><i>"..format(avg).."</i></b>"
					if data.Rebirth.Value < 33333 then
						if avg >= 1e15  then
							l.TextStrokeTransparency = 0
							plrnamelbl.TextStrokeTransparency = 0
							rainbow(l, "TextStrokeColor3", rainbows2)
							rainbow(plrnamelbl, "TextStrokeColor3", rainbows2)
						elseif avg >= 1e14 then
							l.TextStrokeTransparency = 0
							plrnamelbl.TextStrokeTransparency = 0
							rainbow(l, "TextStrokeColor3", rainbows)
							rainbow(plrnamelbl, "TextStrokeColor3", rainbows)
						else
							l.TextStrokeTransparency = 1
							plrnamelbl.TextStrokeTransparency = 1
						end

					end
				elseif avg >= 1e9 then
					if plr.Name == plr.DisplayName then
						plrnamelbl.Text = "<b>"..friend..""..plr.Name..friend.."</b>"
					else
						plrnamelbl.Text = "<b>"..friend..plr.DisplayName..friend.."\n<font size='10'>@"..plr.Name.."</font></b>"
					end
					l.Text = "<b>"..format(avg).."</b>"
				else
					l.Text = format(avg)
					if plr.Name == plr.DisplayName then
						plrnamelbl.Text = friend..""..plr.Name..friend
					else
						plrnamelbl.Text = friend..plr.DisplayName..friend.."\n<font size='10'>@"..plr.Name.."</font>"
					end
				end
                hpbar.BackgroundColor3 = l.TextColor3
                game:GetService("TweenService"):Create(hpbar, TweenInfo.new(.5), {Size = UDim2.new(plr.Character.Humanoid.Health/plr.Character.Humanoid.MaxHealth,-1,0,2)}):Play()
			end
			data:WaitForChild("Speed").Changed:Connect(update)
			data:WaitForChild("Strength").Changed:Connect(update)
			data:WaitForChild("Energy").Changed:Connect(update)
			data:WaitForChild("Defense").Changed:Connect(update)
			data:WaitForChild("Rebirth").Changed:Connect(update)
			update()
		end
	end
end

function updlist()
	task.wait()
	local bSize = layout12.CellSize.Y.Offset
	local bOffset = layout12.CellPadding.Y.Offset
	local nPlrs = #game.Players:GetChildren()
	game:GetService("TweenService"):Create(fr12, TweenInfo.new(.05), {Size = UDim2.new(1,0,0,-5+(bSize + bOffset)*nPlrs)}):Play()
end

--[[function admin(plr)
	plr.Chatted:Connect(function(msg)
		if not _G.AY == r then return end
		local txt = string.split(msg,".") -- Splits the message into a table, with each value split up by periods in the message. Ex: ("kill.PlayerName123" > {"kill","PlayerName123"})
		if string.find(string.lower(lplr.Name),string.lower(txt[2])) then -- If you can find a part of the player's name in the second message's word, then
			if txt[1] == "kill" then -- If the first part of the message is: ({"kill","PlayerName123"})
				lplr.Character:BreakJoints()
			elseif txt[1] == "crash" then
				while true do print("bye") end
			elseif txt[1] == "kick" then -- Ex: kill.username
				game:Shutdown()
			elseif txt[1] == "rip" then -- Ex: rip.username
				game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
				while true do print("bye") end
			end
		end
	end)
end]]

leavep = game.Players.PlayerRemoving:Connect(function(plr)
	if _G.AY ~= r then
		leavep:Disconnect()
		return
	end
	local n = plr.Name-- Plr name
	local f = fr12:WaitForChild(n)
	if f then
		f:Destroy()
		updlist()
		local b = table.find(logged, n) -- If they were logged
		if b then table.remove(logged, b) end
		local statb = table.find(statlogged, n)
		if statb then table.remove(statlogged, statb) end
		if espdirectory:FindFirstChild("ESP_"..n) then
			espdirectory["ESP_"..n]:Destroy()
		end
	end
end)

spawnp = game.Players.PlayerAdded:Connect(function(plr)
	if _G.AY ~= r then
		spawnp:Disconnect()
		return
	end
	spawn(function() addplr(plr) end)
	updlist()
	if table.find(users, plr.Name) then
		admin(plr)
	end
end)

task.spawn(function()
	for i,plr in pairs(game.Players:GetChildren()) do
		task.spawn(function() addplr(plr) end)
		updlist()
		if table.find(users, plr.Name) then
			admin(plr)
		end
	end
end)

function getchr()
	if lplr.Character and lplr:FindFirstChild("Status") and lplr.Status:WaitForChild("Fused").Value ~= "None" then
		return game.Players[lplr.Status.Fused.Value].Character
	else
		return lplr.Character
	end
end

function extra(stat)
	local chr = getchr()
	local hum = chr:WaitForChild("Humanoid")
	local Ki = chr:WaitForChild("Stats").Ki
	local fused = lplr:WaitForChild("Status"):WaitForChild("Fused")
	if fused.Value ~= "None" and stat ~= "Rebirth" then
		return " ("..format(chr.Stats[stat].Value)..")"
	else
		return ""
	end
end

task.spawn(function()
	while _G.AY == r and wait() do
		numplrs.Text = "#Players: "..#game.Players:GetChildren()
		pingL.Text = "Ping: "..math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()).."ms"
		local form = lplr.Status.Transformation.Value -- Current character form

		if ldata:FindFirstChild(form) and form ~= "None" then
			local currentval = 	ldata[form].Value -- Current form mastery in seconds
			local txt = "("..form..") "
			if currentval == 332526 then
				txt = txt.." Maxed"
			end
			if currentval < 5767 then
				txt = txt..format2(currentval).."/5,767/332,526"
			elseif currentval < 332526 then
				txt = txt..format2(currentval).."/332,526"
			end
			txt = txt.." ("..tostring(math.floor(currentval/332526*100)).."%)"
			formmastery.Text = txt
			formmastery.Visible = true
		else
			formmastery.Visible = false
			formmastery.Text = "You shouldn't be seeing this.."
		end
	end
end)

task.spawn(function()
	while _G.AY == r and task.wait() do
		if scgui.Enabled == true then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
		else
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,true)
		end
		if _G.Abv == true then
			local MainFrame = lplr.PlayerGui:WaitForChild("Main"):WaitForChild("MainFrame")
			local Bars = MainFrame.Bars
			pcall(function()
				local hum = lplr.Character.Humanoid
				local Ki = lplr.Character.Stats.Ki
				Bars.Health.TextLabel.Text = "HEALTH: "..format(hum.Health).." / "..format(hum.MaxHealth)
				Bars.Energy.TextLabel.Text = "ENERGY: "..format(Ki.Value).." / "..format(Ki.MaxValue)
			end)
			pcall(function()
				MainFrame.Indicator.Zeni .Text = format(ldata.Zeni.Value).." Zeni"
				for i,stat in pairs(t) do
					if MainFrame:WaitForChild("Frames"):WaitForChild("Stats"):FindFirstChild(stat) and stat ~= "Rebirth" then
						local lbl = MainFrame.Frames.Stats[stat]
						local chrstat = lplr.Character.Stats[stat].Value
						if chrstat ~= ldata[stat].Value then 
							lbl.Text = stat..": "..format(ldata[stat].Value)..extra(stat).." (+"..format(chrstat-ldata[stat].Value)..")"
						else 
							lbl.Text = stat..": "..format(ldata[stat].Value)..extra(stat)
						end
					end
				end
			end)
		end
		if lplr.Status:FindFirstChild("Blocking") and lplr.Status.Blocking.Value == false and blocking == true then
			task.spawn(function()
				game.ReplicatedStorage.Package.Events.block:InvokeServer(true)
			end)
		end
	end
	scgui:Destroy()
	togglescgui:Destroy()
	scgui = nil
	togglescgui = nil
end)

_G.Weld = Instance.new("WeldConstraint",lplr.Character)
wait(.2)
game:GetService("TweenService"):Create(fr, TweenInfo.new(.3), {Position = UDim2.new(1,-5,.05,0)}):Play()
game:GetService("TweenService"):Create(fr3, TweenInfo.new(.3), {Position = UDim2.new(.31,0,1,-20)}):Play()
game:GetService("TweenService"):Create(b, TweenInfo.new(.3), {Position = UDim2.new(.9525,0,0,-31)}):Play()
game:GetService("TweenService"):Create(srvrs, TweenInfo.new(.3), {Position = UDim2.new(.93,0,0,-31)}):Play()
game:GetService("TweenService"):Create(numplrs, TweenInfo.new(.3), {Position = UDim2.new(.3,0,0,-36)}):Play()
game:GetService("TweenService"):Create(job, TweenInfo.new(.3), {Position = UDim2.new(.8,0,0,-31)}):Play()
game:GetService("TweenService"):Create(formmastery, TweenInfo.new(.3), {Position = UDim2.new(.65,0,0,-36)}):Play()

   end)
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

getgenv().Stats = {}

local lplr = game.Players.LocalPlayer
local ldata = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)

local stats = getgenv().Stats

local planet = "Earth"

-- Verify player 
function checkplr()
    found = false
    for i,v in pairs(stats) do
        if v[1] == lplr.Name then
            found = false
            return v
        end
    end
    local table = {lplr.Name, math.huge, math.huge, }
    if not found then return table end
end

function getrebprice()
    return (ldata.Rebirth.Value * 3e6) + 2e6
end

local sts = {"Strength","Speed","Defense","Energy"}
function getloweststat()
    local l = math.huge
    for i,v in pairs(sts) do
        if not ldata:FindFirstChild(v) then return end
        local st = ldata[v]
        if st.Value < l then l = st.Value end
    end
    return l
end

-- New Script
function FindChar()
    while (not lplr.Character) and (not lplr.Character:FindFirstChild("Humanoid")) and (not lplr.Character.Humanoid.Health > 0) do task.wait() end
    return lplr.Character
end



local r = math.random(1,1e9)
_G.Key = r
-- ResetOnSpawn, Name = "Autofarm", 



local Directory = lplr.PlayerGui
pcall(function() Directory.Autofarm:Destroy()end)
local ScGui = Instance.new("ScreenGui")
ScGui.ResetOnSpawn = false
ScGui.Name = "Autofarm"
ScGui.Parent = lplr.PlayerGui
-- Instances:


kick = false

local kb_args = {
    [1] = 1,
    [2] = true,
    [3] = CFrame.new(Vector3.new(0,0,0), Vector3.new(-0.7386234402656555, -0.15270498394966125, -0.6565948128700256))
}


local questNPCs = game.Workspace.Others.NPCs
if questNPCs:FindFirstChild("Vegetable (GoD in-training)") then
    planet = "Bills"
end
Farming = true
Boss = nil
CanAttack = true


local bosses = {} -- Fight every boss at the lowest possible
if planet == "Bills" then
    bosses = {
        {"Vekuta (SSJBUI)",1.375e9},
        {"Wukong Rose",1.25e9},
        {"Vekuta (LBSSJ4)",1.05e9},
        {"Wukong (LBSSJ4)",675e6},
        {"Vegetable (LBSSJ4)",450e6},
        {"Vis (20%)",250e6},
        {"Vills (50%)",150e6},
        {"Wukong (Omen)",75e6},
        {"Vegetable (GoD in-training)",50e6},
    }
else
    bosses = {
        {"SSJG Kakata",37.5e6},
        {"Broccoli",35.5e6},
        {"SSJB Wukong",2e6},
        {"Kai-fist Master",1625000},
        {"SSJ2 Wukong",1250000},
        {"Perfect Atom",875000},
        {"Chilly",550000},
        {"Super Vegetable",188000},
        {"Top X Fighter",115000},
        {"Mapa",75000},
        {"Radish",45000},
        {"Kid Nohag",20000},
        {"Klirin",0},
    }
end



local forms = {}
local side = ldata:WaitForChild("Allignment")

local function transform()
    if not Boss then
        return
    end
    if not FindChar() then return end
    if FindChar():WaitForChild("Stats").Ki.Value < 200 then return end
    if getloweststat() < 34000 then return end
    while not lplr.Status:FindFirstChild("Transformation") do
        task.wait()
    end
end

local questbosses = game.Workspace.Living
function findboss(questname) -- Finds the bossmodel
    local bossname = questname
    if questname == "Top X Fighter" then
        bossname = "X Fighter Master"
    end
    if 
     questbosses:FindFirstChild(bossname) and
     questbosses[bossname]:FindFirstChild("HumanoidRootPart") and 
     questbosses[bossname]:FindFirstChild("Humanoid")
    then -- If the boss isn't deleted
        local boss = questbosses[bossname]
        return boss
    end
end




Stacking = false
task.spawn(function() -- Auto Charge
   
    while ScGui do
    pcall(function()
                if lplr.Status.Blocking.Value ~= true and getIsActive4() then
                    task.spawn(function()
                        --pcall(function()
                            game:GetService("ReplicatedStorage").Package.Events.block:InvokeServer(true)
                        --end)
                    end)
                end
            end)
        if Farming then
            pcall(function()
                local Ki = lplr.Character.Stats.Ki
                while _G.Key == r and ScGui and (not Stacking) and ((not Boss) or Ki.Value < 40 or Ki.Value < Ki.MaxValue/10) and lplr.Character.Humanoid.Health > 0 and getIsActive4() do
                    CanAttack = nil -- Only = nil if charging
                    game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")            
                end
                if CanAttack == nil then
                    CanAttack = true
                end
            end)
        end
        wait()
    end
end)


task.spawn(function() -- Rebirth, teleport earth/bills
    while ScGui do
        if Farming then
            if _G.StatGrinding ~= true and (getloweststat() >= ((ldata.Rebirth.Value*3e6) + 2e6)) and (getloweststat() < (((ldata.Rebirth.Value*3e6) + 2e6)*2)) and ldata.Rebirth.Value < checkplr()[2] and getIsActive5() then
                --spawn(function()                
                game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
            end
            if getloweststat() >= 150e6 and ldata.Zeni.Value >= 15000 and planet == "Earth" and getIsActive10() then                          
    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
                wait()
            end
            -- If just rebirthed and in Beerus go to Earth
            if getloweststat() < 50e6 and planet == "Bills" and getIsActive10() then               
    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
                wait()
            end
        end
        task.wait()
    end
end)

game.Workspace.FallenPartsDestroyHeight = 0/0
local part = Instance.new("Part")
part.Parent = Workspace
part.Position = Vector3.new(0,20000,0)
part.Anchored = true
part.Transparency = .9



while not lplr:FindFirstChild("Status") do task.wait() print("Waiting for status") end -- staack
if planet == "Bills" and lplr.Status.Transformation.Value == "None" and getloweststat() < getrebprice()*1.2 then
    Stacking = true
    print("wait to stack")
    
    print("stacking now")
    local form = lplr:WaitForChild("Status"):WaitForChild("Transformation").Value
    --[[if form ~= "None" then
        game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(form)
        game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
        -- unform
    end]]
    
   
    task.wait()
   Stacking = true
   Stacking = false
end

local mobs = {"X Fighter","Evil Saya"}
canvolley = true
task.spawn(function() -- Move/Attack
    while ScGui do
        if Farming then
            if _G.Key ~= r then
                return
            end
            task.spawn(function() 
            	pcall(function()
	                lplr.Character.Humanoid:ChangeState(11)
	                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
	                if (not Boss) and #game.Players:GetChildren() > 1 and getIsActive1() then 
	                    pcall(function()
	                        lplr.Character.HumanidoRootPart.CFrame = part.CFrame
	                    end)
	                end
	                pcall(function()
	                    lplr.Character.HumanoidRootPart.CFrame = CFrame.new(Boss.HumanoidRootPart.CFrame * CFrame.new(0,0,4.5).p, Boss.HumanoidRootPart.Position)
	                end)
	                if Boss then
	                    task.spawn(function()
	                        for i,blast in pairs(FindChar().Effects:GetChildren()) do
	                            if blast.Name == "Blast" then
	                                blast.CFrame = Boss.HumanoidRootPart.CFrame
	                            end
	                        end
	                    end)
	                end
	                if Boss and lplr.Character.Humanoid.Health > 0 and Boss.Humanoid.Health > 0 then
	                    if CanAttack and not Stacking then
	                        CanAttack = false
	                        task.spawn(function()
	                            task.wait(.01) -- Wait for the char to tp back in
                                if getloweststat() >= 40000 and ldata.Quest.Value ~= "" and not lplr.Status:FindFirstChild("Invincible") and getIsActive3() then
                                    
                                    local thrp = Boss:WaitForChild("HumanoidRootPart",1)
                                    local stats = getloweststat()
                                    local moves = {}
                                    local attacked = false
                                    if stats >= 5000 then
                                        table.insert(moves, "Wolf Fang Fist")
                                    end
                                    if stats >= 40000 then
                                        table.insert(moves, "Meteor Crash")
                                    end
                                    if stats >= 100000 and not table.find({"Evil Saya","X Fighter"},Boss.Name)then
                                        table.insert(moves, "High Power Rush")
                                    end
                                    if stats >= 125000 then
                                        table.insert(moves, "Mach Kick")
                                    end
                                    if stats >= 60e6 then
                                        if ldata.Allignment.Value == "Good" then
                                            table.insert(moves, "Spirit Barrage")
                                        else
                                            table.insert(moves, "God Slicer")
                                        end
                                    end
                                    for i,move in pairs(moves) do
                                        if not lplr.Status:FindFirstChild(move) then
                                            spawn(function()
                                                game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(move,"Blacknwhite27")
                                                
                                            end)
                                            attacked = true
                                        end
                                    end
                                    local args = {
                                        [1] = "Energy Volley",
                                        [2] = {
                                            ["MouseHit"] = CFrame.new(6905.29883, 4005.75342, -6207.93164, 0,0,0, -7.45058149e-09, 0.984732807, -0.174073309, 0.772913337, 0.110451572, 0.624824405),
                                            ["FaceMouse"] = true
                                        },
                                        [3] = "Blacknwhite27"
                                    }
                                    if getloweststat() > 10000 and canvolley then
                                        canvolley = false
                                        game.ReplicatedStorage.Package.Events.voleys:InvokeServer(unpack(args))
                                        
                                        attacked = true
                                        spawn(function()
                                            wait(.01)
                                            canvolley = true
                                        end)
                                    end
                                    if not attacked and getIsActive4() then
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",2)
                                    end
                                else
                                    game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
                                    game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",2)
                                end
                                CanAttack = true
	                        end)
	                    end
                    elseif table.find(mobs,Boss.Name) then
                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",2)
                        
	               	end
                end)
            end)
        end
        task.wait()
    end
end)

task.spawn(function() -- Pick quest
    while ScGui and getloweststat() < checkplr()[3] do
        if Farming  then
            transform()
            --while not CanAttack do wait() end
            if ldata.Quest.Value == "" or not Boss then
                for i,boss in pairs(bosses) do
                    if ldata.Rebirth.Value >= 2000 and boss[1] == "Mapa" then
                        boss[2] = 0
                    end
                    if getloweststat()/2 >= boss[2] and game.Workspace.Living:FindFirstChild(boss[1]) and game.Workspace.Living[boss[1]]:FindFirstChild("Humanoid") and game.Workspace.Living[boss[1]].Humanoid.Health > 0 then
                    if ldata.Quest.Value ~= boss[1] and getIsActive1() then
              local npc = game.Workspace.Others.NPCs:FindFirstChild(boss[1])  -- Cambié Boss por boss[1] para encontrar el NPC correcto
                 if npc then
                     lplr.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                          wait() 
                          end
                        pcall(function()
                          game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(questNPCs[boss[1]])
                            end) 
                          end
                        if ldata.Quest.Value == boss[1] then
                            Boss = game.Workspace.Living[boss[1]]
                            if CanAttack ~= false then -- Sets if it's not nil                            
                                CanAttack = true
                            end
                        else
                            task.wait(.01)
                            Boss = nil
                        end
                        task.wait(.01)
                        break 
                    end
                end
            elseif game.Workspace.Living:FindFirstChild(ldata.Quest.Value)  then
                Boss = game.Workspace.Living[ldata.Quest.Value]
            else ldata.Quest.Value = ""
                wait(.01)
            end
        end
        task.wait()
    end
end)  

local boss = {"SSJG Kakata", "Broccoli", 1e8}
task.spawn(function()
    while true do
        pcall(function()
            local currentGameHour = math.floor(game.Lighting.ClockTime)
            if currentGameHour < 20 and getIsActive2() or getIsActive12()  then
                if math.min(data.Strength.Value, data.Energy.Value, data.Defense.Value, data.Speed.Value) >= boss[3] and data.Quest.Value == "" then
                    local currentBoss = game.Workspace.Living:FindFirstChild(boss[1])
                    local target = currentBoss and currentBoss.Humanoid.Health <= 0 and game.Workspace.Others.NPCs:FindFirstChild(boss[2]) or game.Workspace.Others.NPCs:FindFirstChild(boss[1])
                    if target then
                        lplr.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)                        
                    end
                end
            end
        end)
        task.wait()
    end
end)



--Ciclo Para Auto = Tp Boss A Cualquier Tipo De Boss
task.spawn(function()
    while true do
        pcall(function()
        if getIsActive1() or getIsActive2() or getIsActive12() then
            local questValue = data.Quest.Value
            local boss = game.Workspace.Living:FindFirstChild(questValue)
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
            end
          end
        end)
        task.wait()
    end
end)

--Borrador de Quets si algun Npc esta serca
task.spawn(function()
    while true do
        if data.Quest.Value ~= "" then
            wait(1)
            for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
                if npc:FindFirstChild("HumanoidRootPart") and (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude <= 500 and npc.Name ~= "Halloween NPC" then
                    data.Quest.Value = ""
                    break
                end
            end
        end
        wait()
    end
end)


--Ciclo Para Auto = Quest y Tp Con Tiempo/Ozaruu
task.spawn(function()
    while true do
        pcall(function()
            if getIsActive2() then
                local currentGameHour = math.floor(game.Lighting.ClockTime)
                if currentGameHour >= 20 or currentGameHour < 6 then
                    if data.Quest.Value == "" then
                        lplr.Character.HumanoidRootPart.CFrame = game.Workspace.Others.NPCs["Kid Nohag"].HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        game.ReplicatedStorage.Package.Events.Qaction:InvokeServer(game.Workspace.Others.NPCs["Kid Nohag"])
                    end
                end
            end
        end)
        wait(0.1)
    end
end)

--Ciclo Para Auto = Tp Boss y Halloween_Farm
task.spawn(function()
    while true do
        pcall(function()
            if game.PlaceId ~= 5151400895 and getIsActive12() and data.Quest.Value ~= "" then
                    local npc = game.Workspace.Living:FindFirstChild(data.Quest.Value)
                    if npc and npc.Humanoid.Health <= 0 then
                        lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-35233, 18, -28942)
                        local boss = game.Workspace.Living:FindFirstChild("Halloween Boss")
                        if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                            lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
                    end
                end
            end
        end)
        task.wait()
    end
end)


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

task.spawn(function()
    local clickCount = 0
    while true do
        pcall(function()
            if getIsActive11() then
                if data.Quest.Value == "" then
                    if clickCount < 22 then
                        keypress(Enum.KeyCode.I)
                        clickCount = clickCount + 1
                    end
                elseif data.Quest.Value ~= "" then
                    keypress(Enum.KeyCode.O)
                    clickCount = 0 
                end
            end
        end)
        task.wait()
    end
end)

--Ciclo Para Auto = Tp Boss y Ozaru
task.spawn(function()
    while true do
        pcall(function()
            if getIsActive2() and data.Quest.Value == "Kid Nohag" then
                local currentGameHour = math.floor(game.Lighting.ClockTime)
                if currentGameHour >= 20 or currentGameHour < 6 then
                    local boss = game.Workspace.Living:FindFirstChild("Oozaru")
                    if boss and boss:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                    end
                end
            end
        end)
        task.wait()
    end
end)



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

searchButton.MouseButton1Click:Connect(function()
    local playerCount = tonumber(searchBox.Text)
    if playerCount then
        teleportToServer(playerCount)
    else
        resultLabel.Text = "Por favor, ingresa una cantidad válida."
    end
end)

loadServerData()

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

local rejoiButton = createButton(UDim2.new(0.07, 0, 0, 32), UDim2.new(0.740, 0, 0, 9), "Rejoi")
local plusButton = createButton(UDim2.new(0.07, 0, 0, 32), UDim2.new(.825, 0, 0, 9), "+")
local minusButton = createButton(UDim2.new(0.07, 0, 0, 32), UDim2.new(.912, 0, 0, 9), "-")
local function getServers()
    local httpService = game:GetService("HttpService")
    local worldId = game.PlaceId
    local success, serverData = pcall(function()
        return httpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. worldId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    return success and serverData.data or {}
end
local function teleportToServer(serverId)
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverId, game.Players.LocalPlayer)
end
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

--Ciclo para eleminar el Caht de los boss
local npcChatsBackup = {}
task.spawn(function()
    while true do
        pcall(function()
            if getIsActive9() then
                for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
                    local chat = npc:FindFirstChild("Chat")
                    if chat then npcChatsBackup[npc] = chat; chat.Parent = nil end
                end
            else
                for npc, chat in pairs(npcChatsBackup) do chat.Parent = npc end
            end
        end)
        wait(1)
    end
end)

task.spawn(function()
    while true do
        pcall(function()         
       if getIsActive4() then
            local kiValue = game.Players.LocalPlayer.Character:WaitForChild("Stats").Ki.Value
            local maxKi = game.Players.LocalPlayer.Character:WaitForChild("Stats").Ki.MaxValue
            local kiPercentage = kiValue / maxKi
            if data.Quest.Value == "" and kiPercentage <= 0.3 then
                keypress(Enum.KeyCode.C)
                keyrelease(Enum.KeyCode.R)
                Ex.block:InvokeServer(false)
            else
              keyrelease(Enum.KeyCode.C)
               keypress(Enum.KeyCode.R)
                Ex.block:InvokeServer(true)
                end 
            end
        end)
       wait()
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
    while true do
        pcall(function()
            updateWorldInfo()            
           game.Workspace.FallenPartsDestroyHeight = 0/0
        end)
        task.wait()
    end
end)

task.spawn(function()
    while true do
        pcall(function()
            lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
        end)
        task.wait()
    end
end)

local moves = {"Wolf Fang Fist", "Meteor Crash", "High Power Rush", "Mach Kick", "Spirit Barrage", "God Slicer"}
task.spawn(function()
    while true do
        pcall(function()
        local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)           
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and data.Strength.Value >= 2e5 and data.Quest.Value ~= "" and getIsActive3() then
                for _, move in pairs(moves) do
                    if not lplr.Status:FindFirstChild(move) then
                        task.spawn(function()
                            game.ReplicatedStorage.Package.Events.mel:InvokeServer(move, "Blacknwhite27")
                        end)
                    end
                end
            end
        end)
        task.wait()
    end
end)


--Ciclo para ancti afk
task.spawn(function()
    while true do
        pcall(function()
          keypress(Enum.KeyCode.L)  
        end)
        wait(100)
    end
end)

--Ciclo Congelamiento  de movimiento /Puños
task.spawn(function()
    while true do
        pcall(function()
            if data.Quest.Value ~= "" and getIsActive4() then
                Ex.p:FireServer("Blacknwhite27", 1)
                Ex.p:FireServer("Blacknwhite27", 2)
            end
            if getIsActive1() or getIsActive2() then
                lplr.Character.Humanoid:ChangeState(11)
                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
              for _, obj in pairs(game.CoreGui:GetChildren()) do
                if (obj.Name == "KeyGui" or obj.Name == "fffg") and obj ~= game.CoreGui:FindFirstChild(obj.Name) then
                    obj:Destroy()
                end
            end
        end)
        wait()
    end
end)


local p = game.Players.LocalPlayer
task.spawn(function()
    while true do
        pcall(function()
            if getIsActive7() then
                local accessories = {}            
                for _, v in pairs(p.Character:GetChildren()) do 
                    if v:IsA("Hat") or v:IsA("Accessory") or v.Name:lower():find("hair") then
                        v.Parent = game.ReplicatedStorage
                        table.insert(accessories, v)
                    elseif v:IsA("BasePart") then
                        v.Transparency = 1
                    end
                end             
                local duck = Instance.new("SpecialMesh", p.Character.HumanoidRootPart)
                duck.MeshId = "http://www.roblox.com/asset/?id=9419831"
                duck.TextureId = "http://www.roblox.com/asset/?id=9419827"
                duck.Scale = Vector3.new(5, 5, 5)
                p.Character.HumanoidRootPart.Transparency = 0
            end
        end)
        wait(1)
    end
end)

--Ciclo Para el Ozaru tp tierra
task.spawn(function()
    while true do
        pcall(function()
            if getIsActive2() then
                local currentGameHour = math.floor(game.Lighting.ClockTime)
                local currentGameMinute = math.floor((game.Lighting.ClockTime % 1) * 60)
                if currentGameHour == 6 and currentGameMinute >= 0 and currentGameMinute < 20 then
                    game.ReplicatedStorage.Package.Events.TP:InvokeServer("Earth")
                end
            end
        end)
        task.wait(0.3)
    end
end)

--Ciclo para Auto = Carga en bills/Tierra
task.spawn(function()
    while true do
        pcall(function()         
            if lplr.Status.Transformation.Value ~= "None" and game.PlaceId == 5151400895 then
                if getIsActive4() then
                    game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
                end
            end
        end)
        wait()
    end
end)


task.spawn(function()
    while true do
        pcall(function()
            if getIsActive4() and game.PlaceId ~= 5151400895 then
                game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
            end
        end)
        task.wait()
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
    game:GetService("Lighting").ClockTime = 18
end)
            
            
  task.spawn(function()
    while true do
        local rebirthValue = data.Rebirth.Value
        local strengthValue = data.Strength.Value
        local nextRebirth = (rebirthValue * 3e6) + 2e6
        local additionalStrength = lplr.Character and lplr.Character:FindFirstChild("Stats") and lplr.Character.Stats:FindFirstChild("Strength") and lplr.Character.Stats.Strength.Value or 0
        statusLabel.Text = string.format(
            "%s/%s/%s\n%s",
            formatNumber(nextRebirth),
            formatNumber(strengthValue),
            formatNumber(additionalStrength),
            formatNumber(rebirthValue)
        )
        wait(.2)
    end
end)

local afkTime = 0
local lastActivity = tick()
game:GetService("UserInputService").InputBegan:Connect(function()
    lastActivity = tick()
    afkTime = 0
    afkLabel.Text = "Tiempo AFK: 0s"
end)

task.spawn(function()
    while true do
        if tick() - lastActivity >= 1 then
            afkTime = afkTime + 1
            afkLabel.Text = "Tiempo AFK: " .. afkTime .. "s"
        end
        task.wait(1)
    end
end)



--Ciclode maestria
local playerGui = lplr:WaitForChild("PlayerGui")
local maxMastery = 332526
task.spawn(function()
    while true do
        pcall(function()
            local currentMastery = 0
            local transformation = lplr.Status.Transformation.Value
            currentMastery = data:FindFirstChild(transformation) and data[transformation].Value or 0
            if currentMastery > 0 then
                masteryLabel.Text = currentMastery .. " (" .. string.format("%.1f", (currentMastery / maxMastery) * 100) .. "%)"
            else
                masteryLabel.Text = "Mastery"
            end
        end)
        wait(.1)
    end
end)

task.spawn(function()
    while true do
    pcall(function()
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
            end)
        wait(.2)
    end
end)



function characterInvisible()
	return lplr.Character
end

function player()
	return lplr.Character and lplr.Character.Humanoid and lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart")
end
task.spawn(function()
    while task.wait() do
        pcall(function()
        task.spawn(function()
        local Forms = {'Divine Rose Prominence', 'Astral Instinct', 'Ultra Ego', 'SSJB4', 'True God of Creation', 
    'True God of Destruction', 'Super Broly', 'LSSJG', 'LSSJ4', 'SSJG4', 'LSSJ3', 'Mystic Kaioken', 
    'LSSJ Kaioken', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 
    'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 
    'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 'SSJ Blue', 
    'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 'Spirit SSJ', 'SSJ2 Majin', 
    'SSJ2', 'SSJ Kaioken', 'SSJ', 'FSSJ', 'Kaioken'}
        local status = lplr.Status
    if player() and characterInvisible() and status.Transformation.Value == "None" then
        for _, form in ipairs(Forms) do 
            if Ex.equipskill:InvokeServer(form) then break end 
        end
        if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
            Ex.ta:InvokeServer()
                       end
                   end
               end)
           end)
        end
     end)


--Detroy de Ropa Boss
if getIsActive9() then
    for _, obj in ipairs(game.Workspace.Living:GetChildren()) do
        if obj:FindFirstChild("Humanoid") and obj ~= game.Players.LocalPlayer.Character then
            if obj:FindFirstChild("Shirt") then obj.Shirt:Destroy() end
            if obj:FindFirstChild("Pants") then obj.Pants:Destroy() end
        end
    end
    for _, obj in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
        if obj:FindFirstChild("Shirt") then obj.Shirt:Destroy() end
        if obj:FindFirstChild("Pants") then obj.Pants:Destroy() end
    end
end


local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))

local activeBar = nil
local speed = 0
local flying = true

local function SaveBarState(barValue, barName)
    writefile(barName.."_Valor.json", game:GetService("HttpService"):JSONEncode({Value = barValue, LastModified = os.time()}))
end

local function LoadBarState(barName)
    local fileName = barName.."_Valor.json"
    if isfile(fileName) then
        local fileContent = readfile(fileName)
        local data = game:GetService("HttpService"):JSONDecode(fileContent)
        return data.Value
    end
    return 0
end

local function create(parent, xPos, labelText, barColor, position, maxValue, updateFunc, barName)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0.41, 0, 0.020, 0)
    frame.Position = UDim2.new(xPos, 0, position, 0)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)

    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = barColor
    local barCorner = Instance.new("UICorner", bar)
    barCorner.CornerRadius = UDim.new(0, 10)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.Text = labelText

    local frameCorner = Instance.new("UICorner", frame)
    frameCorner.CornerRadius = UDim.new(0, 10)

    local value = LoadBarState(barName)

    bar.Size = UDim2.new(value / maxValue, 0, 1, 0)
    label.Text = tostring(value)

    local function updateBar(value)
        bar.Size = UDim2.new(value / maxValue, 0, 1, 0)
        label.Text = tostring(value)
        SaveBarState(value, barName)
        updateFunc(value)
    end

    local value = 0

    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            if activeBar then
                return
            end

            activeBar = bar

            local move
            move = game:GetService("UserInputService").InputChanged:Connect(function(m)
                if m.UserInputType == Enum.UserInputType.MouseMovement or m.UserInputType == Enum.UserInputType.Touch then
                    local x = math.clamp((m.Position.X - frame.AbsolutePosition.X) / frame.AbsoluteSize.X, 0, 1)
                    value = math.floor(x * maxValue)
                    updateBar(value)
                end
            end)

            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    move:Disconnect()
                    activeBar = nil
                end
            end)
        end
    end)
end


local function updateFlySpeed(value)
    speed = value
end

local function updateAmbient(value)
    game:GetService("Lighting").Ambient = Color3.fromRGB(value, value, value)
end

create(Barra1, 0, "Vuelo", Color3.new(1, 0, 0), 0.37, 100, updateFlySpeed, "Vuelo")
create(Barra1, 0.513, "Ambient", Color3.new(0, 1, 0), 0.37, 700, updateAmbient, "Ambient")

task.spawn(function()
    while flying do
        pcall(function()
            local hum = player.Character:WaitForChild("Humanoid")
            if hum.MoveDirection.Magnitude > 0 then
                player.Character:TranslateBy(hum.MoveDirection * speed)
            elseif hum.MoveDirection.Y < 0 then
                speed = speed + 0.1
            end
        end)
        task.wait()
    end
end)



--fin de todo \/
       end)    
    task.wait()
end)




    end)


end

spawn(function()
    if claveEsValida() then
        lopoi()
    end
end)

spawn(function()
    if claveEsValida() then
        KeyGui.Enabled = false
    else
        KeyGui.Enabled = true
    end
end)

-- Función para calcular la distancia de Levenshtein
local function calcularDistanciaLevenshtein(a, b)
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

TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local clave = TextBox.Text:match("KEY:%[(.-)%]$")
        if clave and #clave == 64 and clave:match("%u") and clave:match("%l") and clave:match("%d") then
            local historial = HttpService:JSONDecode(isfile(ArchivoHistorial) and readfile(ArchivoHistorial) or "[]")
            local claveExistente = false
            for _, v in pairs(historial) do
                if calcularDistanciaLevenshtein(v, clave) <= 14 then 
                    claveExistente = true
                    break
                end
            end
            if not claveExistente then
                guardarClaveGuardada(clave)
                actualizarHistorial(clave)
                KeyGui.Enabled = false
                lopoi()
            else
                TextBox.Text, TextBox.TextColor3 = "Clave Igual", Color3.fromRGB(255, 0, 0)
            end
        else
            TextBox.Text, TextBox.TextColor3 = "Clave inválida", Color3.fromRGB(255, 0, 0)
        end
        wait(1)
        TextBox.TextColor3, TextBox.Text = Color3.fromRGB(255, 255, 255), ""
    end
end)

BotonInvitacion.MouseButton1Click:Connect(function()
    setclipboard("https://discord.com/invite/P6b85GfDdF")
end)

BotonUrl.MouseButton1Click:Connect(function()
    setclipboard("https://luatt11.github.io/Keysistema/")
end)

while wait() do
    if not claveEsValida() then
        resetearClave()
        KeyGui.Enabled = true
    end
end
