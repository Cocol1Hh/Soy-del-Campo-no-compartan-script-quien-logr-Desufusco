local service, host, useNonce = 1951, "https://api.platoboost.com", true
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ArchivoClaveGuardada = "jses_syn"

local fSetClipboard, fRequest, fGetHwid = 
    setclipboard or toclipboard, 
    request or http_request or syn.request, 
    gethwid or function() return Players.LocalPlayer.UserId end

local function log(...) print("[KeySystem]", ...) end

local function generateNonce()
    return string.gsub(HttpService:GenerateGUID(false), "-", ""):sub(1, 16)
end

local function makeRequest(url, method, body)
    return fRequest({
        Url = url,
        Method = method,
        Headers = {["Content-Type"] = "application/json"},
        Body = body and HttpService:JSONEncode(body) or nil
    })
end

local function generateLink()
    for _, currentHost in ipairs({host, "https://api.platoboost.net"}) do
        local response = makeRequest(currentHost .. "/public/start", "POST", {
            service = service, 
            identifier = fGetHwid(),
            timestamp = os.time(),
            random = math.random()
        })
        
        if response and response.StatusCode == 200 then
            local decoded = HttpService:JSONDecode(response.Body)
            if decoded.success and decoded.data and decoded.data.url then
                return decoded.data.url
            end
        end
    end
    return nil
end

local function verificarClave(clave)
    local identifier = fGetHwid()
    local nonce = useNonce and generateNonce() or nil
    
    for _, currentHost in ipairs({host, "https://api.platoboost.net"}) do
        local whitelistUrl = string.format("%s/public/whitelist/%d?identifier=%s&key=%s%s",
            currentHost, service, HttpService:UrlEncode(identifier), 
            HttpService:UrlEncode(clave), nonce and "&nonce="..nonce or "")
        
        local whitelistResponse = makeRequest(whitelistUrl, "GET")
        
        if whitelistResponse and whitelistResponse.StatusCode == 200 then
            local decoded = HttpService:JSONDecode(whitelistResponse.Body)
            if decoded.success and decoded.data and decoded.data.valid then
                writefile(ArchivoClaveGuardada, HttpService:JSONEncode({clave = clave, fecha = os.time()}))
                return true
            end
        end
        
        local redeemResponse = makeRequest(currentHost .. "/public/redeem/" .. service, "POST", {
            identifier = identifier,
            key = clave,
            nonce = nonce
        })
        
        if redeemResponse and redeemResponse.StatusCode == 200 then
            local decoded = HttpService:JSONDecode(redeemResponse.Body)
            if decoded.success then
                writefile(ArchivoClaveGuardada, HttpService:JSONEncode({clave = clave, fecha = os.time()}))
                return true
            end
        end
    end
    return false
end

local jugadoresPremio = {
    "Fernanflop093o", "armijosfernando2178", 
    "Rutao_Gameplays", "fernanfloP091o", "Zerincee"
}

local function claveEsValida()
    if table.find(jugadoresPremio, Players.LocalPlayer.Name) then
        return true
    end

    if isfile(ArchivoClaveGuardada) then
        local datos = HttpService:JSONDecode(readfile(ArchivoClaveGuardada))
        if datos and datos.clave and verificarClave(datos.clave) then
            return true
        end
        delfile(ArchivoClaveGuardada)
    end
    return false
end

local function script()
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


local Selct = Instance.new("ScrollingFrame", Barra2)
Selct.Size = UDim2.new(0, 320, 0, 170)
Selct.Position = UDim2.new(0.990, 0, 0.165, 0)
Selct.AnchorPoint = Vector2.new(0.5, 0.5)
Selct.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Selct.BorderSizePixel = 0
Selct.ScrollBarThickness = 6
Selct.CanvasSize = UDim2.new(0, 0, 0, 400)
Selct.ScrollingDirection = Enum.ScrollingDirection.Y


local forms = {"True SSJG", "Ego Instinct", "LBLSSJ4", "CSSJB", "Divine Blue", "Divine Rose Prominence", "Astral Instinct", "Ultra Ego", "SSJBUI", "Beast", "LSSJ4"}
local frame = Instance.new("Frame", Selct)
frame.Size = UDim2.new(0, 100, 0, #forms * 30 + 10)
frame.Position = UDim2.new(0.8, -220, 0.270, -frame.Size.Y.Offset / 3)
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
    {text = "Farm", position = UDim2.new(-0.155 + 0, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "...", position = UDim2.new(0.350 + 0, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Reb|Stats", position = UDim2.new(-0.160 + 0.170, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255), parent = Barra1, size = UDim2.new(0, 75, 0, 36)},
    {text = "Ozaru", position = UDim2.new(0.360 + 0, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Black", position = UDim2.new(-0.160 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "...", position = UDim2.new(0.350 + 0, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Fly", position = UDim2.new(-0.04 + 0, 0, 0.320, 0), color = Color3.fromRGB(200, 200, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Brillo", position = UDim2.new(0.473 + 0, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Duck", position = UDim2.new(-0.160 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 200), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
    {text = "Dupli", position = UDim2.new(0.350 + 0, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70), parent = Barra1, size = UDim2.new(0, 200, 0, 36)},
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
        Mix.Text = "×"
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

--Radar
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Kill = Instance.new("ScrollingFrame", Barra3)
Kill.Size = UDim2.new(0, 400, 0, 200)
Kill.Position = UDim2.new(0.490, 0, 0.131, 0)
Kill.AnchorPoint = Vector2.new(0.5, 0.5)
Kill.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
Kill.BorderSizePixel = 0
Kill.ScrollBarThickness = 9
Kill.CanvasSize = UDim2.new(0, 0, 0, 400)
Kill.ScrollingDirection = Enum.ScrollingDirection.Y


local selectedPlayerValue = Instance.new("ObjectValue", ReplicatedStorage)
selectedPlayerValue.Name = "SelectedPlayer"
local selectedRow = nil

local function createTextLabel(parent, pos, text)
    local label = Instance.new("TextLabel", parent)
    label.Size = UDim2.new(0.32, 0, 1, 0)
    label.Position = pos
    label.BackgroundColor3 = Color3.fromRGB(30, 30, 120)
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.BorderSizePixel = 0
    local corner = Instance.new("UICorner", label)
    corner.CornerRadius = UDim.new(0, 10)
    return label
end

local function getStat(player, statName)
    local character = game.Workspace.Living:FindFirstChild(player.Name)
    return character and character.Stats and character.Stats[statName] and character.Stats[statName].Value or 0
end

local function getDisplayName(player)
    return player.DisplayName ~= player.Name and player.Name .. "\n[" .. player.DisplayName .. "]" or player.Name
end

local function updateList()
    local currentSelectedPlayer = selectedPlayerValue.Value
    Kill:ClearAllChildren()
    local playerList = {}
    for _, player in ipairs(Players:GetPlayers()) do
        local strength = getStat(player, "Strength")
        local rebirth = getStat(player, "Rebirth")
        if strength and rebirth then
            table.insert(playerList, {player = player, strengthLabel = nil, rebirthLabel = nil})
        end
    end
    table.sort(playerList, function(a, b) return getStat(a.player, "Rebirth") > getStat(b.player, "Rebirth") end)
    for i, info in ipairs(playerList) do
        local player = info.player
        local rowButton = Instance.new("TextButton", Kill)
        rowButton.Size = UDim2.new(1, 0, 0, 40)
        rowButton.Position = UDim2.new(0, 0, 0, (i - 1) * 45)
        rowButton.BackgroundColor3 = (player == currentSelectedPlayer) and Color3.fromRGB(50, 50, 150) or Color3.fromRGB(20, 20, 100)
        rowButton.Text = ""
        rowButton.BorderSizePixel = 0
        rowButton.AutoButtonColor = false
        local corner = Instance.new("UICorner", rowButton)
        corner.CornerRadius = UDim.new(0, 10)
        createTextLabel(rowButton, UDim2.new(0.02, 0, 0, 0), getDisplayName(player))
        info.rebirthLabel = createTextLabel(rowButton, UDim2.new(0.35, 0, 0, 0), formatNumber(getStat(player, "Rebirth")))
        info.strengthLabel = createTextLabel(rowButton, UDim2.new(0.68, 0, 0, 0), formatNumber(getStat(player, "Strength")))
        rowButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if selectedRow == rowButton then
                    rowButton.BackgroundColor3 = Color3.fromRGB(20, 20, 100)
                    selectedRow = nil
                    selectedPlayerValue.Value = nil
                else
                    if selectedRow then selectedRow.BackgroundColor3 = Color3.fromRGB(20, 20, 100) end
                    rowButton.BackgroundColor3 = Color3.fromRGB(50, 50, 150)
                    selectedRow = rowButton
                    selectedPlayerValue.Value = player
                end
            end
        end)
        if player == currentSelectedPlayer then selectedRow = rowButton end
    end
    Kill.CanvasSize = UDim2.new(0, 0, 0, #playerList * 45)
    task.spawn(function()
        pcall(function()
            while wait(0.5) do
                for _, info in ipairs(playerList) do
                    if info.rebirthLabel and info.strengthLabel then
                        info.rebirthLabel.Text = formatNumber(getStat(info.player, "Rebirth"))
                        info.strengthLabel.Text = formatNumber(getStat(info.player, "Strength"))
                    end
                end
            end
        end)
    end)
end

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)
Kill:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateList)
task.spawn(function() pcall(updateList) end)


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")


local function createTag(head)
    local tag = Instance.new("BillboardGui")
    tag.Name = "StatsTag"
    tag.Adornee = head
    tag.Size = UDim2.new(0, 140, 0, 60)
    tag.StudsOffset = Vector3.new(0, 3, 0)
    tag.AlwaysOnTop = true
    tag.Parent = head

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0.3, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Parent = tag

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "StatsLabel"
    textLabel.Size = UDim2.new(1, 0, 0.3, 0)
    textLabel.Position = UDim2.new(0, 0, 0.3, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextStrokeTransparency = 0
    textLabel.Parent = tag

    local healthBarFrame = Instance.new("Frame")
    healthBarFrame.Name = "HealthBarFrame"
    healthBarFrame.Size = UDim2.new(1, 0, 0.15, 0)
    healthBarFrame.Position = UDim2.new(0, 0, 0.65, 0)
    healthBarFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    healthBarFrame.BorderSizePixel = 0
    healthBarFrame.Parent = tag

    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = healthBarFrame

    local kiBarFrame = Instance.new("Frame")
    kiBarFrame.Name = "KiBarFrame"
    kiBarFrame.Size = UDim2.new(1, 0, 0.15, 0)
    kiBarFrame.Position = UDim2.new(0, 0, 0.85, 0)
    kiBarFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    kiBarFrame.BorderSizePixel = 0
    kiBarFrame.Parent = tag

    local kiBar = Instance.new("Frame")
    kiBar.Name = "KiBar"
    kiBar.Size = UDim2.new(1, 0, 1, 0)
    kiBar.BackgroundColor3 = Color3.new(0, 0.7, 1)
    kiBar.BorderSizePixel = 0
    kiBar.Parent = kiBarFrame
    
    local UICorner_Health = Instance.new("UICorner")
    UICorner_Health.CornerRadius = UDim.new(0, 10)
    UICorner_Health.Parent = healthBar
    local UICorner_Ki = Instance.new("UICorner")
    UICorner_Ki.CornerRadius = UDim.new(0, 10)
    UICorner_Ki.Parent = kiBar

    return tag, nameLabel, textLabel, healthBar, kiBar
end

local function updateTag(player)
    if player == game:GetService("Players").LocalPlayer then return end  

    local character = game.Workspace.Living:FindFirstChild(player.Name)
    if not character then return end

    local head = character:FindFirstChild("Head")
    local stats = character:FindFirstChild("Stats")
    if not head or not stats then return end

    local data = game:GetService("ReplicatedStorage"):FindFirstChild("Datas") and game:GetService("ReplicatedStorage").Datas:FindFirstChild(player.UserId)
    local kiStat = stats:FindFirstChild("Ki")
    local maxKiStat = stats:FindFirstChild("MaxKi")  -- Ahora obtiene MaxKi de Living
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not data or not kiStat or not maxKiStat or not humanoid then return end

    local strength = data:FindFirstChild("Strength") and data.Strength.Value or 0
    local rebirth = data:FindFirstChild("Rebirth") and data.Rebirth.Value or 0
    local health = humanoid.Health
    local maxHealth = humanoid.MaxHealth
    local kiValue = kiStat.Value
    local maxKi = maxKiStat.Value  -- Se asegura de obtener el valor desde Living

    local playerName = player.Name
    local playerDisplayName = player.DisplayName
    local fullName = playerDisplayName ~= playerName and string.format("%s [%s]", playerName, playerDisplayName) or playerName

    local tag = head:FindFirstChild("StatsTag")
    local nameLabel, textLabel, healthBar, kiBar
    if not tag then
        tag, nameLabel, textLabel, healthBar, kiBar = createTag(head)
    else
        nameLabel = tag:FindFirstChild("NameLabel")
        textLabel = tag:FindFirstChild("StatsLabel")
        healthBar = tag:FindFirstChild("HealthBarFrame") and tag.HealthBarFrame:FindFirstChild("HealthBar")
        kiBar = tag:FindFirstChild("KiBarFrame") and tag.KiBarFrame:FindFirstChild("KiBar")
    end

    if nameLabel and textLabel and healthBar and kiBar then
        nameLabel.Text = fullName  
        textLabel.Text = string.format("F: %s | R: %s", formatNumber(strength), formatNumber(rebirth))  
        healthBar.Size = UDim2.new(math.clamp(health / maxHealth, 0, 1), 0, 1, 0)
        kiBar.Size = UDim2.new(math.clamp(kiValue / maxKi, 0, 1), 0, 1, 0) 
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        updateTag(player)
    end)
    RunService.Heartbeat:Connect(function()
        updateTag(player)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

--Tp Players
local getIsActive15 = createSwitch(Barra3, UDim2.new(0.2, 0, 0.275, 0), "Switch15", LoadSwitchState("Switch15"))--Tp
local getIsActive17 = createSwitch(Barra3, UDim2.new(0.2, 0, 0.345, 0), "Switch17", LoadSwitchState("Switch17"))--Tp
local getIsActive18 = createSwitch(Barra3, UDim2.new(0.740, 0, 0.345, 0), "Switch18", LoadSwitchState("Switch178"))--Tp
--[Xd]


--Radar

local function updateAllTags()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            updateTag(player)
        end
    end
end

RunService.Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Players.LocalPlayer then
            local character = player.Character
            if character then
                local head = character:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("StatsTag")
                    if tag then
                        local distance = (workspace.CurrentCamera.CFrame.Position - head.Position).Magnitude
                        local scale = math.clamp(distance / 30, 1.5, 2)
                        tag.Size = UDim2.new(0, 100 * scale, 0, 25 * scale)
                    end
                end
            end
        end
    end
end)

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function()
        updateTag(player)
    end)
end

for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)


local getIsActive1 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.120, 0), "Switch1", LoadSwitchState("Switch1"))--Farm
local getIsActive2 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.115, 0), "Switch2", LoadSwitchState("Switch2"))--Form
local getIsActive3 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.2, 0), "Switch3", LoadSwitchState("Switch3"))--Rebirth
local getIsActive4 = createSwitch(Barra1, UDim2.new(0.735, 0, 0.195, 0), "Switch4", LoadSwitchState("Switch4"))--Ozaru
local getIsActive5 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.275, 0), "Switch5", LoadSwitchState("Switch5"))--Black
local getIsActive6 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.275, 0), "Switch6", LoadSwitchState("Switch6"))--Hallowen🎃
local getIsActive7 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.420, 0), "Switch7", LoadSwitchState("Switch7"))--Duck
local getIsActive8 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.420, 0), "Switch8", LoadSwitchState("Switch8"))--Duplicate server
local getIsActive9 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.495, 0), "Switch9", LoadSwitchState("Switch9"))--Graf
local getIsActive10 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.495, 0), "Switch10", LoadSwitchState("Switch10"))--Planet
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2, 0, 0.570, 0), "Switch11", LoadSwitchState("Switch11"))--Mapa
local getIsActive12 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.570, 0), "Switch12", LoadSwitchState("Switch12"))--Klirin

local getIsActive16 = createSwitch(Barra3, UDim2.new(0.740, 0, 0.275, 0), "Switch16", LoadSwitchState("Switch16"))--Atakes

--Barras
createBar(0, "Flight", Color3.fromRGB(255, 0, 0), 0.37, 100, function(v) speed = v end, "flight")
createBar(0.513, "Ambient", Color3.fromRGB(0, 255, 0), 0.37, 700, function(v) Lighting.Ambient = Color3.fromRGB(v, v, v) end, "ambient")


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
local sts = {"Strength","Speed","Defense","Energy"}
function yo()
    local l = math.huge
    for i,v in pairs(sts) do
        if not data:FindFirstChild(v) then return end
        local st = data[v]
        if st.Value < l then l = st.Value end
    end
    return l
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


task.spawn(function()
    while task.wait() do
        pcall(function()
        if player() then
      if getIsActive11() then                       
            local Forms = {
                ["Ego Instinct"] = 500000000, 
                ["Divine Blue"] = 200000000, 
                ["Divine Rose Prominence"] = 200000000, 
                ["Astral Instinct"] = 138000000, 
                ["SSJBUI"] = 120000000, 
                ["Ultra Ego"] = 120000000,  
                ["LBSSJ4"] = 100000000,  
                ["SSJR3"] = 50000000, 
                ["SSJB3"] = 50000000, 
                ["God Of Destruction"] = 30000000, 
                ["God Of Creation"] = 30000000, 
                ["Jiren Ultra Instinct"] = 14000000, 
                ["Mastered Ultra Instinct"] = 14000000, 
                ["Godly SSJ2"] = 8000000, 
                ["Ultra Instinct Omen"] = 5000000, 
                ["Evil SSJ"] = 4000000, 
                ["Blue Evolution"] = 3500000, 
                ["Dark Rose"] = 3500000, 
                ["Kefla SSJ2"] = 3000000, 
                ["SSJ Berserker"] = 3000000, 
                ["True Rose"] = 2400000, 
                ["SSJB Kaioken"] = 2200000, 
                ["SSJ Rose"] = 1400000, 
                ["SSJ Blue"] = 1200000, 
                ["Corrupt SSJ"] = 700000, 
                ["SSJ Rage"] = 700000, 
                ["SSJG"] = 450000, 
                ["SSJ4"] = 300000, 
                ["Mystic"] = 200000, 
                ["LSSJ"] = 140000, 
                ["SSJ3"] = 95000, 
                ["Spirit SSJ"] = 65000, 
                ["SSJ2 Majin"] = 65000, 
                ["SSJ2"] = 34000, 
                ["SSJ"] = 6000, 
                ["FSSJ"] = 2500, 
                ["Kaioken"] = 1000
            }
            local status = lplr.Status
            local Requisito = data.Defense.Value 
            local selectedForm = nil
            for form, requirement in pairs(Forms) do
                if requirement <= Requisito then
                    if Ex.equipskill:InvokeServer(form) then
                        selectedForm = form
                        break
                    end
                end
            end
            local maxForm = nil
            local maxRequirement = -1
            for form, requirement in pairs(Forms) do
                if requirement <= Requisito and requirement > maxRequirement then
                    if Ex.equipskill:InvokeServer(form) then
                        maxForm = form
                        maxRequirement = requirement
                    end
                end
            end
            if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
                Ex.ta:InvokeServer()
            end
                    end
                       if not getIsActive2() and selectedForm and not transforming and lplr.Status.Transformation.Value ~= selectedForm  then
                  transforming = true
                    pcall(function()
                if Ex.equipskill:InvokeServer(selectedForm) then
                    Ex.ta:InvokeServer()
                    end
                  end)
                transforming = false
              end
              end
           end)
        end
     end)
     
  task.spawn(function()
    while wait() do
        pcall(function()
        if player() then
      if getIsActive12() then
        local Forms = {
    'True SSJG',     
    'LBLSSJ4', 
    'CSSJB', 
    'Blanco', 
    'SSJB4', 
    'True God of Creation', 
    'True God of Destruction', 
    'Super Broly', 
    'LSSJG', 
    'LSSJ4', 
    'SSJG4', 
    'LSSJ3', 
    'SSJ5', 
    'Mystic Kaioken', 
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
              end
           end)
        end
     end)   
     
     task.spawn(function()
    while true do
        pcall(function()
        if getIsActive2() then
            if data.Strength.value <= 80e6 then
                local args = {[1] = "dbuexploiterssucklol", [2] = 1}
                game:GetService("ReplicatedStorage").Package.Events.p:FireServer(unpack(args))
               end
                if data.Energy.value <= 80e6 then
                local args = {[1] = 1, [2] = true, [3] = CFrame.new(12, 12, 12)}
                game:GetService("ReplicatedStorage").Package.Events.kb:FireServer(unpack(args))
                      end
                 if data.Defense.value <= 80e6 then
                local args = {[1] = "dbuexploiterssucklol"}
                game:GetService("ReplicatedStorage").Package.Events.def:InvokeServer(unpack(args))
                 end
                  if data.Speed.value <= 80e6 then
                local args = {[1] = "dbuexploiterssucklol"}
                game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("ch"):InvokeServer(unpack(args))
            end
            end
        end)
        task.wait() 
    end
end)
     
     task.spawn(function()
    local chaEnabled = false
    while task.wait() do
        if player() then
            pcall(function()
                local char = game.Workspace.Living:FindFirstChild(lplr.Name)
                if char then
                    local stats = char:FindFirstChild("Stats")
                    if stats then
                        local ki = stats:FindFirstChild("Ki")
                        local maxKi = stats:FindFirstChild("MaxKi")
                        if ki and maxKi and ki:IsA("NumberValue") and maxKi:IsA("NumberValue") then
                            local min = 0.25
                            local max = 0.40
                            if ki.Value <= (maxKi.Value * min) and not chaEnabled and getIsActive1() then
                                game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer(true, "dbuexploiterssucklol")
                                chaEnabled = true
                            end
                            if ki.Value >= (maxKi.Value * max) and chaEnabled then
                                game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer(false, "dbuexploiterssucklol")
                                chaEnabled = false
                            end
                        end
                    end
                end
            end)
        end
    end
end)
     

task.spawn(function()
while task.wait() do
pcall(function()
        local lplr = Players.LocalPlayer
        if getIsActive15() then
        if  lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") and selectedPlayerValue.Value and selectedPlayerValue.Value.Character and selectedPlayerValue.Value.Character:FindFirstChild("HumanoidRootPart") then
            local Jefe = selectedPlayerValue.Value.Character
            lplr.Character.HumanoidRootPart.CFrame = CFrame.new(Jefe.HumanoidRootPart.CFrame * CFrame.new(0,0,4.2).p, Jefe.HumanoidRootPart.Position)
        end
        end
        end)
    end
end)

local Mel = { 
    "Super Dragon Fist", "God Slicer", "Spirit Barrage", "Mach Kick", "Wolf Fang Fist", 
    "High Power Rush", "Meteor Strike", "Meteor Charge", "Spirit Breaking Cannon", 
    "Vital Strike", "Flash Kick", "Vanish Strike", "Uppercut", "Sledgehammer", "Rock Impact"
}
task.spawn(function()
    while wait() do
        pcall(function()
            local dat = (game.PlaceId == 5151400895) and game.Workspace.Living:FindFirstChild(lplr.Name) or lplr
            if getIsActive16() and selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") and selectedPlayer.Character.Humanoid.Health > 0 then
                if dat:FindFirstChild("Status") then
                    for _, Mel in ipairs(Mel) do
                        if not dat.Status:FindFirstChild(Mel) then
                            task.spawn(function()
                                Ex.mel:InvokeServer(Mel, "dbuexploiterssucklol")
                            end)
                        end
                    end
                end
            end
        end)
    end
end)


local function getStat(player, statName)
    local char = game.Workspace.Living:FindFirstChild(player.Name)
    return char and char:FindFirstChild("Stats") and char.Stats:FindFirstChild(statName) and char.Stats[statName].Value or 0
end

local wasActive17 = false

task.spawn(function()
    while task.wait(1) do
        local isActive17 = getIsActive17()
        if isActive17 and not wasActive17 and selectedPlayerValue.Value then
            local p = selectedPlayerValue.Value
            local data = game.ReplicatedStorage:FindFirstChild("Datas"):FindFirstChild(p.UserId)
            local nombre, apodo = p.Name, p.DisplayName
            local fuerza, rebirth = formatNumber(getStat(p, "Strength")), getStat(p, "Rebirth")
            local zeni = data and data:FindFirstChild("Zeni") and formatNumber(data.Zeni.Value) or "0"
            local vida = p.Character and p.Character:FindFirstChild("Humanoid") and formatNumber(p.Character.Humanoid.Health) or "No disponible"

            local maestrias = {}
            for _, t in ipairs({"Divine Blue", "Divine Rose Prominence", "Astral Instinct", "Ultra Ego", "SSJBUI", "Beast", "LSSJ4"}) do
                local m = data and data:FindFirstChild(t) and data[t].Value or 0
                table.insert(maestrias, string.format("%s: %d", t, m))
            end

            if setclipboard then
                setclipboard(string.format("Nombre: %s\nApodo: %s\nFuerza: %s\nVida: %s\nZenis: %s\nRebirth: %s\n\nMaestrías:\n%s",
                    nombre, apodo, fuerza, vida, zeni, rebirth, table.concat(maestrias, "\n")))
            end
        end
        wasActive17 = isActive17
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            local lplr = Players.LocalPlayer
            if getIsActive18() then
                if selectedPlayerValue.Value and selectedPlayerValue.Value.Character then
                    local Jefe = selectedPlayerValue.Value.Character:FindFirstChild("Humanoid")
                    if Jefe then
                        workspace.CurrentCamera.CameraSubject = Jefe
                    end
                else
                    if lplr.Character then
                        local humanoid = lplr.Character:FindFirstChild("Humanoid")
                        if humanoid then
                            workspace.CurrentCamera.CameraSubject = humanoid
                        end
                    end
                end
            end
        if getIsActive15() then
        if  lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") and selectedPlayerValue.Value and selectedPlayerValue.Value.Character and selectedPlayerValue.Value.Character:FindFirstChild("HumanoidRootPart") then
            local Jefe = selectedPlayerValue.Value.Character
            lplr.Character.HumanoidRootPart.CFrame = CFrame.new(Jefe.HumanoidRootPart.CFrame * CFrame.new(0,0,4.2).p, Jefe.HumanoidRootPart.Position)
        end
        end
        end)
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            if getIsActive5() and player() then
                local gokuBlack = game.Workspace.Living:FindFirstChild("Wukong Black")
                if gokuBlack and gokuBlack:FindFirstChild("Humanoid") and gokuBlack:FindFirstChild("HumanoidRootPart") then
                    local distance = (gokuBlack.HumanoidRootPart.Position - Vector3.new(718.1, 207.5, 505.4)).Magnitude
                    if distance <= 900 then
                        local rootPart = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if rootPart then
                            rootPart.CFrame = gokuBlack.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                        end
                    end
                end
            end
        end)
    end
end)




 local Black = false
task.spawn(function()
    while true do
        pcall(function()
            if getIsActive5() and player() then
                local gokuBlack = game.Workspace.Living:FindFirstChild("Wukong Black")
                if gokuBlack and gokuBlack:FindFirstChild("Humanoid") and gokuBlack.Humanoid.Health > 0 then
                    local bossPosition = Vector3.new(718.1,207.5,505.4)
                    if (gokuBlack.HumanoidRootPart.Position - bossPosition).Magnitude <= 900 then
                        Black = true
                        return
                    end
                end
            end
            Black = false
        end)
        task.wait()
    end
end)



  task.spawn(function()
    while task.wait() do
        pcall(function()
        if player() then
          if getIsActive1()  and data.Quest.Value ~= ""  then
           if game.PlaceId == 3311165597 or lplr.Status.Transformation.Value ~= "None" then           
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol",1)
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol",2)
                     end
                     end
                     if getIsActive4()  and data.Quest.Value ~= ""  then
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol",1)
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol",2)
                     end								
                     if getIsActive4() then
                local questOrder = {
                    {npc = "Wukong", boss = "Oozaru"},
                    {npc = "SSJG Kakata", boss = "SSJG Kakata"}
                }
                
                if data.Quest.Value == "" and getIsActive4()  then
                    for _, quest in ipairs(questOrder) do
                        local boss = game.Workspace.Living:FindFirstChild(quest.boss)
                        local npc = game.Workspace.Others.NPCs:FindFirstChild(quest.npc)
                        
                        if boss and boss:FindFirstChild("HumanoidRootPart") and 
                           boss.Humanoid.Health > 0 and npc then
                            lplr.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            game.ReplicatedStorage.Package.Events.Qaction:InvokeServer(npc)
                            break
                        end
                    end
                elseif data.Quest.Value == "Wukong" and getIsActive4()  then
                    local oozaru = game.Workspace.Living:FindFirstChild("Oozaru")
                    if oozaru and oozaru:FindFirstChild("HumanoidRootPart") and 
                       oozaru.Humanoid.Health > 0 then
                        lplr.Character.HumanoidRootPart.CFrame = oozaru.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    end
                else
                    local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
                    if boss and boss:FindFirstChild("HumanoidRootPart") and 
                       boss.Humanoid.Health > 0 then
                        lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    end
                end
            end
            end --player() 
         end)         
      end
  end)
  
  
  task.spawn(function()
    while task.wait() do
        pcall(function()
            if getIsActive1() and player() then
                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        end)
    end
end)

local function getRebirthRequirement()
    local player = game.Players.LocalPlayer
    local rebirthFrame = player.PlayerGui:FindFirstChild("Main") and player.PlayerGui.Main.MainFrame.Frames:FindFirstChild("Rebirth")
    if not rebirthFrame then return 0 end
    for _, child in ipairs(rebirthFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") then
            local num = tonumber(child.Text:gsub(",", ""):match("%d+"))
            if num then return num end
        end
    end
    return 0
end

task.spawn(function()
    while true do
        pcall(function()
            local fuerzaActual = yo()
            local rebirthReq = getRebirthRequirement()
               if getIsActive3() and player() then
            if fuerzaActual >= rebirthReq and fuerzaActual < rebirthReq * 4 then
                Ex.reb:InvokeServer()
                end
            end
        end)
        task.wait(.3)
    end
end)



task.spawn(function()
    while task.wait() do
        pcall(function()       
            if player() then
                if game.Players.LocalPlayer.Status.Blocking.Value == false and getIsActive1() then
                    game.Players.LocalPlayer.Status.Blocking.Value = true               
                end                                                    
            pcall(function()
            task.spawn(function()
            if player() and game.PlaceId == 3311165597  then
            if getIsActive1() and yo() <= 10000  and data.Rebirth.Value >= 5000 then
        for _, boss in ipairs(game.Workspace.Living:GetChildren()) do
            if boss.Name == "Evil Saya" and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
                               game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol",1)
                                        game:GetService("ReplicatedStorage").Package.Events.p:FireServer("dbuexploiterssucklol",2)
                break
                 end
                  end
                  end--  if getIsActive6()  then
                   if getIsActive1() and  yo() <= 10000  and data.Rebirth.Value <= 5000 then
        for _, boss in ipairs(game.Workspace.Living:GetChildren()) do
            if boss.Name == "X Fighter" and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
                          local args = {[1] = "dbuexploiterssucklol",[2] = 1}
        game:GetService("ReplicatedStorage").Package.Events.p:FireServer(unpack(args))
                break
                  end
                  end                           
                  end--  if getIsActive6()  then
                end--if fin if game.PlaceId == 3311165597 then                
             end)
          end)
          end
        end)
    end
 end)
 

local HttpService = game:GetService("HttpService")
local folderName = "Missiones🤑🤑"
local fileName = folderName .. "/bosses.txt"

local function saveBossList(bossList)
    local jsonData = HttpService:JSONEncode(bossList)
    local formattedData = jsonData:gsub("},", "},\n\n") 
    if not isfolder(folderName) then
        makefolder(folderName)
    end
    writefile(fileName, formattedData)
end

local function loadBossList()
    if isfile(fileName) then
        local success, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(fileName))
        end)
        if success and decoded then
            local correctedList = {}
            for _, boss in ipairs(decoded) do
                if type(boss) == "table" and #boss >= 2 then
                    local name = tostring(boss[1]) -- Forzar nombre como string
                    local req = tonumber(boss[2]) -- Forzar requisito como número
                    if name and req then
                        table.insert(correctedList, {name, req, true}) -- Solo nombre y requisito editables, isActive siempre true
                    end
                end
            end
            if #correctedList > 0 then
                saveBossList(correctedList) -- Guardar la lista corregida
                return correctedList
            end
        end
    end
    -- Lista predeterminada si el archivo no existe o está corrupto
    local defaultBossList = {
        {"Vekuta (SSJBUI)", 3.175e9, true},
        {"Wukong Rose", 2.75e9, true},
        {"Vekuta (LBSSJ4)", 2.05e9, true},
        {"Wukong (LBSSJ4)", 1.90e9, true},
        {"Vegetable (LBSSJ4)", 950e6, true},
        {"Vis (20%)", 650e6, true},
        {"Winter Roshi", 500e6, true},
        {"Vills (50%)", 300e6, true},
        {"Wukong (Omen)", 200e6, true},
        {"Vegetable (GoD in-training)", 50e6, true},
        {"SSJG Kakata", 150e6, true},
        {"Broccoli", 61.5e6, true},
        {"SSJB Wukong", 8025000, true},
        {"Kai-fist Master", 6025000, true},
        {"SSJ2 Wukong", 4050000, true},
        {"Perfect Atom", 2375000, true},
        {"Chilly", 950000, true},
        {"Super Vegetable", 798000, true},
        {"Mapa", 75000, true},
        {"Radish", 60000, true},
        {"Kid Nohag", 40000, true},
        {"Klirin", 20000, true}
    }
    saveBossList(defaultBossList)
    return defaultBossList
end

local npcList = loadBossList()

task.spawn(function()
    while true do
        pcall(function()
            if player() and getIsActive1() then
                if game.PlaceId == 3311165597 or lplr.Status.Transformation.Value ~= "None" then  
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
        end)
        task.wait()
    end
end)


canvolley = true        
task.spawn(function() 
    while true do
        pcall(function()
        if player() then
            local Jefe = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            if game.PlaceId == 3311165597 or lplr.Status.Transformation.Value ~= "None" then           
                if (yo() >= 40000 and data.Quest.Value ~= "" and not lplr.Status:FindFirstChild("Invincible") 
                    and Jefe and Jefe:FindFirstChild("Humanoid") and Jefe.Humanoid.Health > 0 and getIsActive1()) 
                    or Black == true then                                    
                    
                    local stats = yo()
                    local moves = {}
                    local attacked = false

                    if stats < 900e9 then
                        if stats >= 5000 then table.insert(moves, "Wolf Fang Fist") end
                        if stats >= 40000 then table.insert(moves, "Meteor Crash") end
                        if stats >= 100000 then table.insert(moves, "High Power Rush") end
                        if stats >= 125000 then table.insert(moves, "Mach Kick") end
                        if stats < 4e9 and game.PlaceId == 5151400895 then
                            table.insert(moves, "Super Dragon Fist")
                        end
                        if stats < 40e9 and stats >= 60e6 then
                            if data.Allignment.Value == "Good" then
                                table.insert(moves, "Spirit Barrage")
                            else
                                table.insert(moves, "God Slicer")
                            end
                        end
                    end

                    for i, move in pairs(moves) do
                        if not lplr.Status:FindFirstChild(move) then
                            spawn(function()
                                game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(move, "dbuexploiterssucklol")                                        
                            end)
                            attacked = true
                        end
                    end

                    if stats < 10e9 and stats > 10000 and canvolley then
                        canvolley = false
                        local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
                        if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                            game:GetService("ReplicatedStorage").Package.Events.voleys:InvokeServer(
                                "Energy Volley", 
                                {["MouseHit"] = boss.HumanoidRootPart.CFrame, ["FaceMouse"] = true}, 
                                "dbuexploiterssucklol"
                            )
                        end
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
            updateAllTags()
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
    local yaEnElServidor = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        yaEnElServidor[player] = true
    end
    game.Players.PlayerAdded:Connect(function(player)
        if not yaEnElServidor[player] and getIsActive8() then
            pcall(function()
                local destino = (game.PlaceId == 5151400895) and "Vills Planet" or "Earth"
                game.ReplicatedStorage.Package.Events.TP:InvokeServer(destino)
            end)
        end
    end)
end)
 
 
 task.spawn(function()
    while task.wait() do       
pcall(function() 
            if getIsActive10() then
            if yo() >= 150e6  and game.PlaceId == 3311165597  then
                game.ReplicatedStorage.Package.Events.TP:InvokeServer("Vills Planet")
                wait(5)
            end
            if yo() < 150e6 and game.PlaceId == 5151400895  then
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
loadServerData()  
end)
   end
end)
 
 
task.spawn(function()
    while task.wait(1) do
       pcall(function()
   updateAllTags()
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
    updateWorldInfo()    
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
    {"Mapa", 55000}, {"Radish", 40000}, {"Kid Nohag", 20000}, {"Klirin", 10000},
    {"Super Vegetable", 298000}, {"Chilly", 650000}, {"Winter Gohan", 860000},
    {"Perfect Atom", 1375000}, {"SSJ2 Wukong", 2050000}, {"Kai-fist Master", 3025000},
    {"SSJB Wukong", 4025000}, {"Broccoli", 21.5e6}, {"SSJG Kakata", 100e6},
    {"Winter Wukong", 120e6}, {"Vegetable (GoD in-training)", 50e6},
    {"Wukong (Omen)", 200e6}, {"Vills (50%)", 300e6},
    {"Vis (20%)", 650e6}, {"Vegetable (LBSSJ4)", 950e6}, {"Wukong (LBSSJ4)", 1.90e9},
    {"Vekuta (LBSSJ4)", 2.05e9}, {"Wukong Rose", 2.75e9}, {"Vekuta (SSJBUI)", 3.175e9}
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

--fin de todo \/
       end)    
    task.wait()
  end)



end

local function crearGUI()
    local KeyGui = Instance.new("ScreenGui", game.CoreGui)
    local Frame = Instance.new("Frame", KeyGui)
    Frame.Size, Frame.Position = UDim2.new(0.318, 0, 0.318, 0), UDim2.new(0.5, 0, 0.5, 0)
    Frame.AnchorPoint, Frame.BackgroundColor3 = Vector2.new(0.5, 0.5), Color3.fromRGB(30, 30, 35)

    local TextBox = Instance.new("TextBox", Frame)
    TextBox.Size, TextBox.Position = UDim2.new(0.9, 0, 0.13, 0), UDim2.new(0.05, 0, 0.28, 0)
    TextBox.PlaceholderText, TextBox.Font = "Introduce tu clave aquí", Enum.Font.Gotham
    TextBox.TextColor3, TextBox.BackgroundColor3 = Color3.new(1, 1, 1), Color3.fromRGB(40, 40, 45)

    local function crearBoton(texto, posX, color)
        local boton = Instance.new("TextButton", Frame)
        boton.Size, boton.Position = UDim2.new(0.4, 0, 0.15, 0), UDim2.new(posX, 0, 0.65, 0)
        boton.Text, boton.Font, boton.TextColor3 = texto, Enum.Font.GothamBold, Color3.new(1, 1, 1)
        boton.BackgroundColor3 = color
        return boton
    end

    local BotonVerificar = crearBoton("Verificar Clave", 0.05, Color3.fromRGB(0, 204, 122))
    local BotonCopiar = crearBoton("Generar Link", 0.55, Color3.fromRGB(0, 122, 204))

    BotonVerificar.MouseButton1Click:Connect(function()
        local clave = TextBox.Text
        if clave == "" then
            TextBox.Text, TextBox.TextColor3 = "Por favor, introduce una clave", Color3.fromRGB(255, 100, 100)
            return
        end

        TextBox.Text, TextBox.TextColor3 = "Verificando...", Color3.new(1, 1, 1)
        
        if verificarClave(clave) then
            TextBox.Text, TextBox.TextColor3 = "¡Clave aceptada!", Color3.fromRGB(100, 255, 100)
            wait(1)
            KeyGui:Destroy()
            script()
        else
            TextBox.Text, TextBox.TextColor3 = "Clave inválida", Color3.fromRGB(255, 100, 100)
        end
    end)

    BotonCopiar.MouseButton1Click:Connect(function()
        TextBox.Text, TextBox.TextColor3 = "Generando link...", Color3.new(1, 1, 1)
        
        local link = generateLink()
        if link then
            TextBox.Text, TextBox.TextColor3 = "Link generado y copiado", Color3.fromRGB(100, 255, 100)
            if fSetClipboard then fSetClipboard(link) end
        else
            TextBox.Text, TextBox.TextColor3 = "No se pudo generar el link", Color3.fromRGB(255, 100, 100)
        end
    end)
end

if claveEsValida() then
    log("Clave válida detectada. Ejecutando script principal.")
    script()
else
    if makeRequest(host .. "/public/connectivity", "GET").StatusCode == 200 then
        crearGUI()
    else
        log("Servicio no disponible. No se puede mostrar la GUI.")
    end
end

