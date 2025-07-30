local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local serviceId = 1951
local useNonce = true
local playerName = LocalPlayer.Name
local keyFile = playerName .. "_key.json"
local hosts = {
    "https://api.platoboost.com",
    "https://api.platoboost.net"
}

local juegosPermitidos = {
    ["FrivUpd"] = {3311165597, 5151400895, 109983668079237, 11063612131},
    ["Azeldex"] = {3311165597, 5151400895}
}

local setClipboard = setclipboard or toclipboard or function(text) print("Link:", text) end
local requestFunc = request or http_request or (syn and syn.request) or function(options)
    if options.Method == "GET" then
        return {StatusCode = 200, Body = HttpService:GetAsync(options.Url)}
    else
        return {StatusCode = 200, Body = HttpService:PostAsync(options.Url, options.Body or "", Enum.HttpContentType.ApplicationJson)}
    end
end

local function getHwid()
    return tostring(LocalPlayer.UserId)
end

local function generateNonce()
    return HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 16)
end

local function makeRequest(url, method, body)
    local ok, res = pcall(function()
        return requestFunc({
            Url = url,
            Method = method or "GET",
            Headers = {
                ["Content-Type"] = "application/json",
                ["User-Agent"] = "Roblox/KeySystem"
            },
            Body = body and HttpService:JSONEncode(body) or nil
        })
    end)
    return ok and res or nil
end

local function testHost()
    for _, host in ipairs(hosts) do
        local res = makeRequest(host .. "/public/connectivity", "GET")
        if res and (res.StatusCode == 200 or res.StatusCode == 404) then
            return host
        end
    end
    return nil
end

local function estaEnJuegoPermitido()
    local lista = juegosPermitidos[playerName]
    if not lista then
        return true
    end
    for _, placeId in ipairs(lista) do
        if game.PlaceId == placeId then
            return true
        end
    end
    return false
end


 
local function ejecutarScriptPremium()
    local id = game.PlaceId
    local player = game.Players.LocalPlayer
    local name = player.Name

    local DBU_IDS = {3311165597, 5151400895}
    local MLGD_IDS = {3623096087}
    local Speed_IDS = {3101667897, 3276265788}
    local Brainrot_IDS = {109983668079237}
    local Jump_IDS = {11063612131}

    local StarterGui = game:GetService("StarterGui")

    local function notificar(juego)
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "🎮 " .. juego,
                Text = "👤 " .. name .. " está listo. ¡Disfruta el script!",
                Duration = 6
            })
        end)
    end

    task.spawn(function()
        if table.find(DBU_IDS, id) then
            notificar("Dragon Ball Ultimate")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/DRG.lua"))()
            end)
        end
    end)

    task.spawn(function()
        if table.find(MLGD_IDS, id) then
            notificar("Muscle Legends")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/Legends.lua"))()
            end)
        end
    end)

    task.spawn(function()
        if table.find(Speed_IDS, id) then
            notificar("Speed of Legends")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/Eped.lua"))()
            end)
        end
    end)

    task.spawn(function()
        if table.find(Brainrot_IDS, id) then
            notificar("Steal a Brainrot")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/Pet.lua"))()
            end)
        end
    end)
    
    task.spawn(function()
        if table.find(Jump_IDS, id) then
            notificar("Every Second You Get +1 Jump")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/Jump.lua"))()
            end)
        end
    end)
end--Fin de function ejecutarScriptPremium()

    

local function generateKeyLink()
    local host = testHost()
    if not host then return nil, "❌ No hay conexión con los servidores" end

    local body = {
        service = serviceId,
        identifier = getHwid(),
        timestamp = os.time(),
        random = math.random(1000, 9999),
        debug = true,
        nonce = useNonce and generateNonce() or nil
    }

    local res = makeRequest(host .. "/public/start", "POST", body)
    if res and res.StatusCode == 200 then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(res.Body)
        end)
        if ok and data and data.success and data.data and data.data.url then
            setClipboard(data.data.url)
            return data.data.url, "🔗 Link generado y copiado"
        end
    end
    return nil, "❌ Error al generar el link"
end

local function verificarClave(clave)
    local hwid = getHwid()
    local nonce = useNonce and generateNonce() or nil

    for _, host in ipairs(hosts) do
        local url = string.format("%s/public/whitelist/%d?identifier=%s&key=%s%s",
            host, serviceId, HttpService:UrlEncode(hwid), HttpService:UrlEncode(clave),
            nonce and "&nonce=" .. nonce or "")

        local res = makeRequest(url, "GET")
        if res and res.StatusCode == 200 then
            local ok, data = pcall(function()
                return HttpService:JSONDecode(res.Body)
            end)
            if ok and data and data.success and data.data and data.data.valid then
                writefile(keyFile, HttpService:JSONEncode({
                    key = clave,
                    time = os.time(),
                    host = host
                }))
                return true, "✅ Clave válida"
            end
        end
    end
    return false, "❌ Clave inválida"
end


if estaEnJuegoPermitido() then
    warn("🎉 Jugador premiado y en juego permitido. Ejecutando sin pedir clave.")
    ejecutarScriptPremium()
    return
end

if isfile(keyFile) then
    local success, content = pcall(readfile, keyFile)
    if success then
        local data = HttpService:JSONDecode(content)
        local ok, msg = verificarClave(data.key)
        if ok and estaEnJuegoPermitido() then
            warn("✅ Acceso autorizado con clave guardada.")
            ejecutarScriptPremium()
            return
        elseif ok then
            warn("❌ Clave válida pero no estás en un juego permitido")
        else
            delfile(keyFile)
        end
    end
end


local juegosConClave = {
    -- Dragon Ball Ultimate
    [3311165597] = true,
    -- Muscle Legends
    [5151400895] = true,
    -- Speed of Legends
    [3101667897] = true,
    [3276265788] = true,
    -- Steal a Brainrot
    [109983668079237] = true,
    -- Every Second You Get +1 Jump
    [11063612131] = true,
}


if not juegosConClave[game.PlaceId] then
    warn("🔒 Juego no requiere clave. Menú no cargado.")
    return
end

if game.CoreGui:FindFirstChild("KeyLinkGui") then
    game.CoreGui.KeyLinkGui:Destroy()
end

local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "KeyLinkGui"
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 400, 0, 200)
Frame.Position = UDim2.new(0.5, -200, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🔐 Sistema de Clave"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(0.9, 0, 0, 30)
TextBox.Position = UDim2.new(0.05, 0, 0, 40)
TextBox.PlaceholderText = "Introduce tu clave aquí"
TextBox.Text = ""
TextBox.Font = Enum.Font.Gotham
TextBox.TextColor3 = Color3.new(1, 1, 1)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
TextBox.BorderSizePixel = 0
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 4)

local BtnVerificar = Instance.new("TextButton", Frame)
BtnVerificar.Size = UDim2.new(0.4, 0, 0, 30)
BtnVerificar.Position = UDim2.new(0.05, 0, 0, 80)
BtnVerificar.Text = "Verificar Clave"
BtnVerificar.Font = Enum.Font.GothamBold
BtnVerificar.TextColor3 = Color3.new(1, 1, 1)
BtnVerificar.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
Instance.new("UICorner", BtnVerificar).CornerRadius = UDim.new(0, 4)

local BtnGenerar = Instance.new("TextButton", Frame)
BtnGenerar.Size = UDim2.new(0.4, 0, 0, 30)
BtnGenerar.Position = UDim2.new(0.55, 0, 0, 80)
BtnGenerar.Text = "Generar Link"
BtnGenerar.Font = Enum.Font.GothamBold
BtnGenerar.TextColor3 = Color3.new(1, 1, 1)
BtnGenerar.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Instance.new("UICorner", BtnGenerar).CornerRadius = UDim.new(0, 4)

local Estado = Instance.new("TextLabel", Frame)
Estado.Size = UDim2.new(1, -20, 0, 50)
Estado.Position = UDim2.new(0, 10, 0, 130)
Estado.Text = "🔄 Esperando acción..."
Estado.TextColor3 = Color3.new(1, 1, 1)
Estado.Font = Enum.Font.Gotham
Estado.TextSize = 14
Estado.BackgroundTransparency = 1
Estado.TextWrapped = true

BtnGenerar.MouseButton1Click:Connect(function()
    Estado.Text = "🔄 Generando link..."
    local link, msg = generateKeyLink()
    Estado.Text = msg
end)

BtnVerificar.MouseButton1Click:Connect(function()
    local clave = TextBox.Text:gsub("%s+", "")
    if clave == "" then
        Estado.Text = "⚠️ Introduce una clave válida"
        return
    end

    Estado.Text = "🔍 Verificando clave..."
    local ok, msg = verificarClave(clave)
    if ok and estaEnJuegoPermitido() then
        Estado.Text = "✅ Clave válida"
        task.wait(1)
        Gui:Destroy()
        ejecutarScriptPremium()
    elseif ok then
        Estado.Text = "❌ Clave válida pero no estás en un juego permitido"
    else
        Estado.Text = msg
    end
end)