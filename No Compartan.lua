
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
    local historial = {}
    if isfile(ArchivoHistorial) then
        historial = HttpService:JSONDecode(readfile(ArchivoHistorial))
    end
    table.insert(historial, clave)
    if #historial > 5 then
        table.remove(historial, 1)
    end
    writefile(ArchivoHistorial, HttpService:JSONEncode(historial))
end

local function claveEsValida()
    if isfile(ArchivoClaveGuardada) then
        local datos = HttpService:JSONDecode(readfile(ArchivoClaveGuardada))
        if os.time() - datos.fecha < (24 * 60 * 60) then
            return true
        end
    end
    return false
end

local function resetearClave()
    if isfile(ArchivoClaveGuardada) then
        delfile(ArchivoClaveGuardada)
    end
end

local function lopoi()
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
VS.Text = "V [0.6]"
VS.Size = UDim2.new(0, 100, 0, 10)
VS.Position = UDim2.new(0.783, 0, 0.009, 0)
VS.TextColor3 = Color3.fromRGB(255, 255, 255)
VS.BackgroundTransparency = 1
VS.TextSize = 7
VS.TextStrokeTransparency = 0.8

local TiempoValidez = 24 * 60 * 60
local ArchivoClave = "ClaveGuardada.json"
local HttpService = game:GetService("HttpService")

local TiempoGui = Instance.new("ScreenGui")
local TiempoLabel = Instance.new("TextLabel", Barra1)
TiempoLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
TiempoLabel.Position = UDim2.new(0.4, 0, -0.009, 0)
TiempoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TiempoLabel.TextScaled = true
TiempoLabel.BackgroundTransparency = 1
TiempoLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TiempoLabel.BorderSizePixel = 0
TiempoLabel.Text = "Cargando..."


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
    {text = "HA🎃", position = UDim2.new(0.350, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0)},
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
local getIsActive2 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.115, 0), "Switch2", LoadSwitchState("Switch2"))--Hall🎃
local getIsActive3 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.2, 0), "Switch3", LoadSwitchState("Switch3"))--Atack
local getIsActive4 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.195, 0), "Switch4", LoadSwitchState("Switch4"))--Puch
local getIsActive5 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.275, 0), "Switch5", LoadSwitchState("Switch5"))--Rebirth
local getIsActive6 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.275, 0), "Switch6", LoadSwitchState("Switch6"))--Main
local getIsActive7 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.420, 0), "Switch7", LoadSwitchState("Switch7"))--Duck
local getIsActive8 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.420, 0), "Switch8", LoadSwitchState("Switch8"))--Bºrª
local getIsActive9 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.495, 0), "Switch9", LoadSwitchState("Switch9"))--Graf
local getIsActive10 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.495, 0), "Switch10", LoadSwitchState("Switch10"))--Planet
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.570, 0), "Switch11", LoadSwitchState("Switch11"))--Zom


--Casi fin del interrutor /\


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


local npcList = {
    {"Vekuta (SSJBUI)", 4.375e9},
    {"Wukong Rose", 3.25e9},
    {"Vekuta (LBSSJ4)", 2.25e9},
    {"Wukong (LBSSJ4)", 1.775e9},
    {"Vegetable (LBSSJ4)", 950e6},
    {"Vis (20%)", 650e6},
    {"Vills (50%)", 375e6},
    {"Wukong (Omen)", 250e6},
    {"Vegetable (GoD in-training)", 150e6},
    {"SSJG Kakata", 100e6},
    {"Broccoli", 45.5e6},
    {"SSJB Wukong", 8e6},
    {"Kai-fist Master", 3625000},
    {"SSJ2 Wukong", 2250000},
    {"Perfect Atom", 1275000},
    {"Chilly", 950000},
    {"Super Vegetable", 358000},
    {"Mapa", 105000},
    {"Radish", 55000},
    {"Kid Nohag", 40000},
    {"Klirin", 0}
}

spawn(function()
    while task.wait() do
        pcall(function()
            if data.Quest.Value == "" and getIsActive1() then
                for _, npc in ipairs(npcList) do
                    local npcName, FZ = npc[1], npc[2]
                    local npcInstance = game.Workspace.Others.NPCs:FindFirstChild(npcName)
                    if npcInstance and npcInstance:FindFirstChild("HumanoidRootPart") and yo() >= FZ then
                        lplr.Character.HumanoidRootPart.CFrame = npcInstance.HumanoidRootPart.CFrame
                        game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(npcInstance)
                        break
                    end
                end
            end
        end)
    end
end)


--Ciclo Para Auto = Tp Boss A Cualquier Tipo De Boss
task.spawn(function()
    while task.wait() do
        pcall(function()
        task.spawn(function()
        if getIsActive1() and data.Quest.Value ~= "" then
            local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
                    end
                end
            end)
        end)        
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



--Ciclo Para Auto = Tp Boss y Halloween_Farm
task.spawn(function()
    while true do
        pcall(function()
            if game.PlaceId ~= 5151400895 and data.Quest.Value ~= "" and getIsActive2() then
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


--Ciclo Para Auto = Tierra/Bills
task.spawn(function()
    while true do
        pcall(function()         
            if getIsActive10() and game.PlaceId == 5151400895 and yo() <= 150e6 then
                Ex.TP:InvokeServer("Earth")
                wait()
            elseif getIsActive10() and game.PlaceId ~= 5151400895 and yo() >= 150e6 then
               Ex.TP:InvokeServer("Vills Planet")
                wait()                
            end
        end)
       wait()
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


local moves = {"Meteor Crash", "High Power Rush", "Mach Kick", "Spirit Barrage", "God Slicer"}
task.spawn(function()
    while true do
        pcall(function()
            local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            local Ki = lplr.Character.Stats.Ki
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and 
                data.Strength.Value >= 6e5 and data.Quest.Value ~= "" and 
                getIsActive3() and lplr.Character.Humanoid.Health > 0 and 
                Ki.Value > Ki.MaxValue * 0.15 then
                for _, move in pairs(moves) do
                    if not lplr.Status:FindFirstChild(move) then
                        task.spawn(function()
                            game.ReplicatedStorage.Package.Events.mel:InvokeServer(move, "Blacknwhite27")
                            game.ReplicatedStorage.Package.Events.voleys:InvokeServer("Energy Volley", { FaceMouse = false, MouseHit = CFrame.new() }, "Blacknwhite27")
                        end)
                    end
                end
            end
        end)
        task.wait()
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
        task.spawn(function()
           game.Workspace.FallenPartsDestroyHeight = 0/0
           lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
           end)
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

--Ciclo para ancti afk /V2
task.spawn(function()
    while true do
        pcall(function()
            game:GetService('Players').LocalPlayer.Idled:Connect(function()
                local bb = game:GetService('VirtualUser')
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
            end)
        end)
        wait(1)
    end
end)

--Ciclo Congelamiento  de movimiento /Puños
task.spawn(function()
    while true do
        pcall(function()
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

task.spawn(function()
    while task.wait() do
        pcall(function()
        task.spawn(function()
            if getIsActive5() then
                game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
            end
                     if data.Quest.Value ~= "" and getIsActive4() then
                Ex.p:FireServer("Blacknwhite27", 1)
                Ex.p:FireServer("Blacknwhite27", 2)
                end
            end)
        end)        
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

task.spawn(function()
    while true do
        pcall(function()
            for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj.Name == "Effects" or obj:IsA("ParticleEmitter") then
              obj:Destroy()
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

local function claveEsValida()
    if isfile(ArchivoClave) then
        local datosClave = HttpService:JSONDecode(readfile(ArchivoClave))
        local tiempoRestante = TiempoValidez - (os.time() - datosClave.fecha)
        return tiempoRestante > 0, tiempoRestante
    end
    return false, 0
end

local function mostrarTiempoRestante(tiempoRestante)
    TiempoGui.Enabled = true

    spawn(function()
        while tiempoRestante > 0 do
            tiempoRestante = tiempoRestante - 1
            TiempoLabel.Text = string.format("%02d:%02d:%02d", 
                math.floor(tiempoRestante / 3600), 
                math.floor((tiempoRestante % 3600) / 60), 
                tiempoRestante % 60)
            wait(1)
        end

        TiempoGui.Enabled = false
        print("El tiempo ha expirado. Debes ingresar una nueva clave.")
    end)
end

local esValida, tiempoRestante = claveEsValida()
if esValida then
    mostrarTiempoRestante(tiempoRestante)
else
    print("La clave ha expirado o no existe. Debes ingresar una nueva clave.")
end


task.spawn(function()
    while true do
        pcall(function()
        task.spawn(function()
            if getIsActive4() and game.PlaceId ~= 5151400895 then
                game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
                end
            end)
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


local Forms = { 'Divine Rose Prominence', 'Astral Instinct', 'Ultra Ego', 'SSJB4', 'True God of Creation', 
    'True God of Destruction', 'Super Broly', 'LSSJG', 'LSSJ4', 'SSJG4', 'LSSJ3', 'Mystic Kaioken', 
    'LSSJ Kaioken', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 
    'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 
    'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 'SSJ Blue', 
    'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 'Spirit SSJ', 'SSJ2 Majin', 
    'SSJ2', 'SSJ Kaioken', 'SSJ', 'FSSJ', 'Kaioken' }

task.spawn(function()
    while task.wait() do
        pcall(function()
            if lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character.Humanoid.Health > 0 then
                for _, form in ipairs(Forms) do if Ex.equipskill:InvokeServer(form) then break end end
                local status = lplr.Status
                if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
                    Ex.ta:InvokeServer()
                end
            end
        end)
    end
end)

--Ciclo Para Auto = Main y Start
local gui = lplr.PlayerGui.Main.bruh
if workspace.Others:FindFirstChild("Title") then
    Ex.Start:InvokeServer()
    gui.Disabled = true
    gui.Disabled = false
end


local gui = Instance.new("ScreenGui", lplr:WaitForChild("PlayerGui"))

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
            local hum = lplr.Character:WaitForChild("Humanoid")
            if hum.MoveDirection.Magnitude > 0 then
                lplr.Character:TranslateBy(hum.MoveDirection * speed)
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
    local m = #a
    local n = #b
    local dp = {}
    for i = 0, m do
        dp[i] = {}
        dp[i][0] = i
    end
    for j = 0, n do
        dp[0][j] = j
    end
    for i = 1, m do
        for j = 1, n do
            local cost = (a:sub(i, i) == b:sub(j, j)) and 0 or 1
            dp[i][j] = math.min(dp[i - 1][j] + 1, dp[i][j - 1] + 1, dp[i - 1][j - 1] + cost)
        end
    end

    return dp[m][n]
end

TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local texto = TextBox.Text
        local clave = texto:match("KEY:%[(.-)%]$")
        
        if clave and #clave == 64 then
            local tieneMayuscula = clave:match("%u") ~= nil
            local tieneMinuscula = clave:match("%l") ~= nil
            local tieneNumero = clave:match("%d") ~= nil

            if tieneMayuscula and tieneMinuscula and tieneNumero then
                local historial = HttpService:JSONDecode(isfile(ArchivoHistorial) and readfile(ArchivoHistorial) or "[]")
                local claveExistente = false

                for _, v in pairs(historial) do
                    local distancia = calcularDistanciaLevenshtein(v, clave)
                    if distancia <= 14 then 
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
                    TextBox.Text = "Clave Igual"
                    TextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
                    wait(1)
                    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextBox.Text = ""
                end
            else
                TextBox.Text = "Clave Incorrecto"
                TextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
                wait(1)
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.Text = ""
            end
        else
            TextBox.Text = "Clave inválida"
            TextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait(1)
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.Text = ""
        end
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
