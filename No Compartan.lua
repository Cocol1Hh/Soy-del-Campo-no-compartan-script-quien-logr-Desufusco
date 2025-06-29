local lplr = game.Players.LocalPlayer
local testerList = {
    "vgfgc",
    "gggff"
}

local playerList = {   
    "hhhhhh",
    "gff"
}

local function isInList(name, list)
    name = string.lower(name)
    for _, v in ipairs(list) do
        if name == string.lower(v) then
            return true
        end
    end
    return false
end

task.spawn(function()
    pcall(function()
        local playerName = lplr.Name
        if not isInList(playerName, testerList) and not isInList(playerName, playerList) then
local service, useNonce = 1951, true
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local ArchivoClaveGuardada = "jses_syn_debug"

local DEBUG = {
    enabled = true,
    logs = {},
    maxLogs = 50,
    startTime = tick(),
    workingHosts = {},
    failedHosts = {},
    successfulOperations = {}
}

local function getTimestamp()
    return string.format("[%.2f] %s", tick() - DEBUG.startTime, os.date("%H:%M:%S"))
end

local function debugLog(level, category, message, data)
    local logEntry = {
        timestamp = getTimestamp(),
        level = level,
        category = category,
        message = message,
        data = data
    }
    
    table.insert(DEBUG.logs, logEntry)
    if #DEBUG.logs > DEBUG.maxLogs then
        table.remove(DEBUG.logs, 1)
    end
    
    local logString = string.format("%s [%s] [%s] %s", 
        logEntry.timestamp, level, category, message)
    
    if level == "ERROR" or level == "SUCCESS" or level == "INFO" then
        if level == "ERROR" then
            warn(logString)
        else
            print(logString)
        end
    end
    
    if data and (level == "SUCCESS" or level == "ERROR") then
        print("Data:", HttpService:JSONEncode(data))
    end
    
    if level == "ERROR" and category ~= "REQUEST" then
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Error - " .. category,
                Text = message,
                Duration = 3
            })
        end)
    elseif level == "SUCCESS" and (category == "KEY" or category == "LINK") then
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Éxito - " .. category,
                Text = message,
                Duration = 3
            })
        end)
    end
end

local function logError(cat, msg, data) debugLog("ERROR", cat, msg, data) end
local function logWarn(cat, msg, data) debugLog("WARN", cat, msg, data) end
local function logInfo(cat, msg, data) debugLog("INFO", cat, msg, data) end
local function logSuccess(cat, msg, data) debugLog("SUCCESS", cat, msg, data) end
local function logDebug(cat, msg, data) debugLog("DEBUG", cat, msg, data) end

local function getSystemInfo()
    local info = {
        player_name = Players.LocalPlayer.Name,
        player_id = Players.LocalPlayer.UserId,
        game_loaded = game:IsLoaded(),
        executor = "Unknown",
        functions = {},
        time = os.time(),
        tick = tick()
    }
    
    if syn then info.executor = "Synapse X"
    elseif KRNL_LOADED then info.executor = "KRNL"
    elseif getgenv and getgenv().OXYGEN_LOADED then info.executor = "Oxygen U"
    elseif request then info.executor = "Generic (request available)"
    end
    
    local funcs = {"setclipboard", "toclipboard", "request", "http_request", "syn.request", "gethwid", "isfile", "readfile", "writefile", "delfile"}
    for _, func in ipairs(funcs) do
        info.functions[func] = _G[func] ~= nil
    end
    
    return info
end

logInfo("SYSTEM", "Sistema de verificación rápida inicializado")

local fSetClipboard = setclipboard or toclipboard or function(text)
    logWarn("CLIPBOARD", "Usando clipboard de respaldo", {text = text:sub(1, 50) .. "..."})
    print("CLIPBOARD:", text)
end

local fRequest = request or http_request or (syn and syn.request) or function(options)
    logDebug("REQUEST", "Usando HttpService de respaldo", {url = options.Url, method = options.Method})
    
    local success, result = pcall(function()
        if options.Method == "GET" then
            return {StatusCode = 200, Body = HttpService:GetAsync(options.Url)}
        else
            return {StatusCode = 200, Body = HttpService:PostAsync(options.Url, options.Body or "", Enum.HttpContentType.ApplicationJson)}
        end
    end)
    
    if success then
        logDebug("REQUEST", "HttpService de respaldo exitoso")
        return result
    else
        logError("REQUEST", "HttpService de respaldo falló", {error = result})
        return {StatusCode = 500, Body = '{"success": false}'}
    end
end

local fGetHwid = gethwid or function() 
    local hwid = tostring(Players.LocalPlayer.UserId)
    logDebug("HWID", "Usando HWID de respaldo", {hwid = hwid})
    return hwid
end

local fIsFile = isfile or function() logDebug("FILE", "isfile no disponible"); return false end
local fReadFile = readfile or function() logDebug("FILE", "readfile no disponible"); return "" end
local fWriteFile = writefile or function(path, content) logDebug("FILE", "writefile no disponible", {path = path}) end
local fDelFile = delfile or function(path) logDebug("FILE", "delfile no disponible", {path = path}) end

local function generateNonce()
    logDebug("NONCE", "Generando nonce")
    local nonce = string.gsub(HttpService:GenerateGUID(false), "-", ""):sub(1, 16)
    logDebug("NONCE", "Nonce generado", {nonce = nonce, length = #nonce})
    return nonce
end

local hosts = {
    "https://api.platoboost.com",
    "https://api.platoboost.net",
    "https://platoboost-api.herokuapp.com",
    "https://boost-api.vercel.app",
    "https://api.keyauth.win",
    "https://keyauth.win",
    "https://api.luarmor.net",
    "https://gateway.platoboost.com",
    "https://cdn.platoboost.com",
    "https://backup.platoboost.net",
    "http://api.platoboost.com",
    "http://platoboost.com",
    "https://www.platoboost.com",
    "https://raw.githubusercontent.com/platoboost/api/main",
    "https://pastebin.com/raw/platoboost",
    "https://api.github.com/repos/platoboost"
}

local userAgents = {
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36",
    "Roblox/WinInet",
    "RobloxStudio/WinInet",
    "Roblox/Debug-KeySystem",
    "curl/7.68.0",
    "PostmanRuntime/7.28.0"
}

local function getRandomUserAgent()
    return userAgents[math.random(1, #userAgents)]
end

local function makeRequest(url, method, body, timeout, retries)
    timeout = timeout or 10
    method = method or "GET"
    retries = retries or 1
    
    for attempt = 1, retries do
        local requestData = {
            Url = url,
            Method = method,
            Headers = {
                ["Content-Type"] = "application/json",
                ["User-Agent"] = getRandomUserAgent(),
                ["Accept"] = "*/*",
                ["Accept-Encoding"] = "gzip, deflate",
                ["Connection"] = "keep-alive",
                ["Cache-Control"] = "no-cache",
                ["Pragma"] = "no-cache"
            },
            Body = body and HttpService:JSONEncode(body) or nil
        }
        
        local startTime = tick()
        local success, response = pcall(function()
            return fRequest(requestData)
        end)
        local duration = tick() - startTime
        
        if success and response then
            if response.StatusCode == 200 or response.StatusCode == 201 then
                if response.Body and response.Body:find("cloudflare") and response.Body:find("blocked") then
                    logDebug("REQUEST", "Cloudflare detectado", {url = url})
                else
                    return response
                end
            elseif response.StatusCode == 403 or response.StatusCode == 429 then
                logDebug("REQUEST", "Rate limited", {status = response.StatusCode})
                if attempt < retries then task.wait(1) end
            else
                return response
            end
        end
        
        if attempt < retries then
            task.wait(0.5)
        end
    end
    
    return nil
end


local function verificarClaveRapida(clave, hostGuardado, metodoGuardado)
    logInfo("FAST_KEY", string.format("⚡ Verificación rápida con host guardado: %s", hostGuardado:gsub("https://", ""):gsub("http://", "")))
    
    local identifier = fGetHwid()
    local nonce = useNonce and generateNonce() or nil
    
    
    if metodoGuardado == "whitelist" then
        local whitelistEndpoints = {
            string.format("/public/whitelist/%d?identifier=%s&key=%s%s",
                service, HttpService:UrlEncode(identifier), 
                HttpService:UrlEncode(clave), nonce and "&nonce="..nonce or ""),
            string.format("/api/check/%d/%s/%s", service, identifier, clave),
            string.format("/verify?service=%d&id=%s&key=%s", service, identifier, clave)
        }
        
        for _, endpoint in ipairs(whitelistEndpoints) do
            local whitelistUrl = hostGuardado .. endpoint
            local response = makeRequest(whitelistUrl, "GET", nil, 8, 1)
            
            if response and response.StatusCode == 200 then
                local success, decoded = pcall(function()
                    return HttpService:JSONDecode(response.Body)
                end)
                
                if success and decoded then
                    if (decoded.success and decoded.data and decoded.data.valid) or 
                       decoded.valid or decoded.authorized then
                        logSuccess("FAST_KEY", "⚡ Verificación rápida exitosa (whitelist)")
                        return true
                    end
                end
            end
        end
    else
        local redeemEndpoints = {"/public/redeem/" .. service, "/api/redeem", "/redeem"}
        
        for _, endpoint in ipairs(redeemEndpoints) do
            local response = makeRequest(hostGuardado .. endpoint, "POST", {
                identifier = identifier,
                key = clave,
                nonce = nonce,
                service = service
            }, 8, 1)
            
            if response and response.StatusCode == 200 then
                local success, decoded = pcall(function()
                    return HttpService:JSONDecode(response.Body)
                end)
                
                if success and decoded then
                    if decoded.success or decoded.redeemed or decoded.valid then
                        logSuccess("FAST_KEY", "⚡ Verificación rápida exitosa (redeem)")
                        return true
                    end
                end
            end
        end
    end
    
    logWarn("FAST_KEY", "⚠️ Host guardado falló, iniciando verificación completa")
    return false
end

-- FUNCIÓN PARALELA PARA PROBAR CONECTIVIDAD (OPTIMIZADA)
local function testConnectivity()
    logInfo("CONNECTIVITY", "🔍 Probando conectividad...")
    
    local workingHosts = {}
    local completedTests = 0
    local totalTests = math.min(#hosts, 8) 
    
    DEBUG.workingHosts = {}
    DEBUG.failedHosts = {}
    
    for i = 1, totalTests do
        local host = hosts[i]
        
        task.spawn(function()
            local endpoints = {"/public/connectivity", "/api/status", "/health", ""}
            local hostWorking = false
            
            for _, endpoint in ipairs(endpoints) do
                if hostWorking then break end
                
                local testUrl = host .. endpoint
                local response = makeRequest(testUrl, "GET", nil, 5, 1)
                
                if response then
                    if response.StatusCode == 200 or response.StatusCode == 404 or response.StatusCode == 405 then
                        table.insert(workingHosts, host)
                        hostWorking = true
                        break
                    end
                end
            end
            
            completedTests = completedTests + 1
        end)
    end
    
    local startTime = tick()
    local maxWaitTime = 8
    
    while completedTests < totalTests and (tick() - startTime) < maxWaitTime do
        task.wait(0.1)
        
        if #workingHosts >= 3 then
            logInfo("CONNECTIVITY", "✅ Suficientes hosts encontrados")
            break
        end
    end
    
    local workingCount = #workingHosts
    
    if workingCount > 0 then
        logSuccess("CONNECTIVITY", string.format("✅ %d hosts funcionando", workingCount))
        return workingHosts
    else
        logError("CONNECTIVITY", "❌ Ningún host funciona")
        return hosts
    end
end

-- FUNCIÓN PARALELA PARA GENERAR LINKS (OPTIMIZADA)
local function generateLink()
    logInfo("LINK", "🔗 Generando link...")
    
    local workingHosts = testConnectivity()
    if not workingHosts or #workingHosts == 0 then
        logError("LINK", "❌ No hay hosts disponibles")
        return nil
    end
    
    local requestData = {
        service = service,
        identifier = fGetHwid(),
        timestamp = os.time(),
        random = math.random(1000, 9999),
        debug = true,
        version = "v2.0"
    }
    
    local generatedLink = nil
    local completedRequests = 0
    local totalRequests = math.min(#workingHosts, 5)
    local successfulHost = nil
    
    logInfo("LINK", string.format("🚀 Probando %d hosts...", totalRequests))
    
    for i = 1, totalRequests do
        local host = workingHosts[i]
        
        task.spawn(function()
            local endpoints = {"/public/start", "/api/generate", "/generate"}
            
            for _, endpoint in ipairs(endpoints) do
                if generatedLink then break end
                
                local response = makeRequest(host .. endpoint, "POST", requestData, 15, 1)
                
                if response and response.StatusCode == 200 then
                    local success, decoded = pcall(function()
                        return HttpService:JSONDecode(response.Body)
                    end)
                    
                    if success and decoded then
                        if decoded.success and decoded.data and decoded.data.url then
                            generatedLink = decoded.data.url
                            successfulHost = host
                            break
                        elseif decoded.url then
                            generatedLink = decoded.url
                            successfulHost = host
                            break
                        elseif decoded.link then
                            generatedLink = decoded.link
                            successfulHost = host
                            break
                        end
                    end
                end
            end
            
            completedRequests = completedRequests + 1
        end)
    end
    
    local startTime = tick()
    local maxWaitTime = 15 
    
    while not generatedLink and completedRequests < totalRequests and (tick() - startTime) < maxWaitTime do
        task.wait(0.1)
    end
    
    if generatedLink then
        logSuccess("LINK", string.format("✅ Link generado desde: %s", successfulHost:gsub("https://", ""):gsub("http://", "")))
        return generatedLink
    else
        logWarn("LINK", "⚠️ Generando link de respaldo...")
        local fallbackLink = string.format("https://platoboost.com/a/%d?id=%s&t=%d", 
            service, fGetHwid(), os.time())
        logInfo("LINK", "🔗 Link de respaldo generado")
        return fallbackLink
    end
end

-- FUNCIÓN PARALELA PARA VERIFICAR CLAVES (OPTIMIZADA)
local function verificarClave(clave)
    logInfo("KEY", "🔑 Verificando clave...")
    
    local identifier = fGetHwid()
    local nonce = useNonce and generateNonce() or nil
    
    local workingHosts = testConnectivity()
    local keyValid = false
    local completedVerifications = 0
    local totalVerifications = math.min(#workingHosts, 6) 
    local successfulHost = nil
    local verificationMethod = nil
    
    logInfo("KEY", string.format("🚀 Verificando en %d hosts...", totalVerifications))
    
    for i = 1, totalVerifications do
        local currentHost = workingHosts[i]
        
        task.spawn(function()
            local whitelistEndpoints = {
                string.format("/public/whitelist/%d?identifier=%s&key=%s%s",
                    service, HttpService:UrlEncode(identifier), 
                    HttpService:UrlEncode(clave), nonce and "&nonce="..nonce or ""),
                string.format("/api/check/%d/%s/%s", service, identifier, clave)
            }
            
            for _, endpoint in ipairs(whitelistEndpoints) do
                if keyValid then break end
                
                local whitelistUrl = currentHost .. endpoint
                local whitelistResponse = makeRequest(whitelistUrl, "GET", nil, 8, 1)
                
                if whitelistResponse and whitelistResponse.StatusCode == 200 then
                    local success, decoded = pcall(function()
                        return HttpService:JSONDecode(whitelistResponse.Body)
                    end)
                    
                    if success and decoded then
                        if (decoded.success and decoded.data and decoded.data.valid) or 
                           decoded.valid or decoded.authorized then
                            keyValid = true
                            successfulHost = currentHost
                            verificationMethod = "whitelist"
                            
                            pcall(function()
                                fWriteFile(ArchivoClaveGuardada, HttpService:JSONEncode({
                                    clave = clave, 
                                    fecha = os.time(),
                                    host = currentHost,
                                    method = "whitelist",
                                    endpoint = endpoint,
                                    identifier = identifier
                                }))
                            end)
                            break
                        end
                    end
                end
            end
            
            if not keyValid then
                local redeemEndpoints = {"/public/redeem/" .. service, "/api/redeem"}
                
                for _, endpoint in ipairs(redeemEndpoints) do
                    if keyValid then break end
                    
                    local redeemResponse = makeRequest(currentHost .. endpoint, "POST", {
                        identifier = identifier,
                        key = clave,
                        nonce = nonce,
                        service = service
                    }, 8, 1)
                    
                    if redeemResponse and redeemResponse.StatusCode == 200 then
                        local success, decoded = pcall(function()
                            return HttpService:JSONDecode(redeemResponse.Body)
                        end)
                        
                        if success and decoded then
                            if decoded.success or decoded.redeemed or decoded.valid then
                                keyValid = true
                                successfulHost = currentHost
                                verificationMethod = "redeem"
                                
                                pcall(function()
                                    fWriteFile(ArchivoClaveGuardada, HttpService:JSONEncode({
                                        clave = clave, 
                                        fecha = os.time(),
                                        host = currentHost,
                                        method = "redeem",
                                        endpoint = endpoint,
                                        identifier = identifier
                                    }))
                                end)
                                break
                            end
                        end
                    end
                end
            end
            
            completedVerifications = completedVerifications + 1
        end)
    end
    
    local startTime = tick()
    local maxWaitTime = 12 
    
    while not keyValid and completedVerifications < totalVerifications and (tick() - startTime) < maxWaitTime do
        task.wait(0.1)
    end
    
    if keyValid then
        logSuccess("KEY", string.format("✅ Clave válida (%s) desde: %s", 
            verificationMethod, successfulHost:gsub("https://", ""):gsub("http://", "")))
        return true
    else
        logError("KEY", "❌ Clave inválida")
        return false
    end
end

-- JUGADORES PREMIUM (ACCESO DIRECTO)
local jugadoresPremio = {
    "Fernanflop093o", "armijosfernando2178", 
    "Secudaria2007", "fernanfloP091o", "FrivUpd"
}

local function claveEsValida()
    local playerName = Players.LocalPlayer.Name
    logInfo("VALIDATION", string.format("🔍 Verificando acceso para: %s", playerName))
    
    if table.find(jugadoresPremio, playerName) then
        logSuccess("VALIDATION", "👑 JUGADOR PREMIUM - ACCESO DIRECTO")
        return true
    end
    
    if fIsFile(ArchivoClaveGuardada) then
        logInfo("VALIDATION", "📁 Archivo de clave encontrado")
        
        local success, datos = pcall(function()
            return HttpService:JSONDecode(fReadFile(ArchivoClaveGuardada))
        end)
        
        if success and datos and datos.clave and datos.host and datos.method then
            logInfo("VALIDATION", string.format("⚡ Usando verificación rápida con: %s", datos.host:gsub("https://", ""):gsub("http://", "")))
            
            if verificarClaveRapida(datos.clave, datos.host, datos.method) then
                logSuccess("VALIDATION", "⚡ Clave guardada válida (verificación rápida)")
                return true
            else
                logWarn("VALIDATION", "⚠️ Host guardado falló, probando verificación completa...")
                
                if verificarClave(datos.clave) then
                    logSuccess("VALIDATION", "✅ Clave guardada válida (verificación completa)")
                    return true
                else
                    logWarn("VALIDATION", "⚠️ Clave guardada expiró, eliminando archivo")
                    pcall(function() fDelFile(ArchivoClaveGuardada) end)
                end
            end
        else
            logError("VALIDATION", "❌ Error al leer archivo de clave")
            pcall(function() fDelFile(ArchivoClaveGuardada) end)
        end
    else
        logInfo("VALIDATION", "📁 No se encontró archivo de clave guardada")
    end
    
    return false
end

local function script()
    logSuccess("MAIN", "🚀 EJECUTANDO SCRIPT PRINCIPAL")
    
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Script Cargado",
            Text = "El script principal se está ejecutando!",
            Duration = 5
        })
    end)
    
    print("=== SCRIPT PRINCIPAL EJECUTADO ===")
    print("Jugador:", Players.LocalPlayer.Name)
    print("Hora:", os.date("%X"))
    print("============================")
    
    local id = game.PlaceId
    local DBU_IDS = {
        3311165597,
        5151400895,
    }
    local MLGD_IDS = {
        3623096087,
    }

    task.spawn(function()
        if table.find(DBU_IDS, id) then
            logInfo("MAIN", "🎮 Cargando script de Dragon Ball Ultimate...")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/DRG.lua"))()
            end)
        end
    end)

    task.spawn(function()
        if table.find(MLGD_IDS, id) then
            logInfo("MAIN", "🎮 Cargando script de Muscle Legends...")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/Legends.lua"))()
            end)
        end
    end)
    
    logSuccess("MAIN", "✅ Script principal completado")
end

local function crearGUI()
    logInfo("GUI", "🎨 Creando interfaz rápida")
    
    pcall(function()
        if game.CoreGui:FindFirstChild("DebugKeySystemGUI") then
            game.CoreGui.DebugKeySystemGUI:Destroy()
        end
    end)
    
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "DebugKeySystemGUI"
    KeyGui.Parent = game.CoreGui
    KeyGui.ResetOnSpawn = false
    
    local Frame = Instance.new("Frame")
    Frame.Parent = KeyGui
    Frame.Size = UDim2.new(0, 450, 0, 380)
    Frame.Position = UDim2.new(0.5, -225, 0.5, -190)
    Frame.AnchorPoint = Vector2.new(0, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Frame.BorderSizePixel = 0
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame
    
    local Title = Instance.new("TextLabel")
    Title.Parent = Frame
    Title.Size = UDim2.new(1, 0, 0, 25)
    Title.Position = UDim2.new(0, 0, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Text = "⚡ Sistema Rápido - " .. getSystemInfo().executor
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    
    local SystemInfo = Instance.new("TextLabel")
    SystemInfo.Parent = Frame
    SystemInfo.Size = UDim2.new(1, 0, 0, 15)
    SystemInfo.Position = UDim2.new(0, 0, 0, 30)
    SystemInfo.BackgroundTransparency = 1
    SystemInfo.Text = string.format("👤 %s | 🆔 %s | ⚡ Verificación Rápida", 
        Players.LocalPlayer.Name, fGetHwid():sub(1, 8) .. "...")
    SystemInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    SystemInfo.TextSize = 10
    SystemInfo.Font = Enum.Font.Gotham
    
    local HostStatus = Instance.new("TextLabel")
    HostStatus.Parent = Frame
    HostStatus.Size = UDim2.new(1, 0, 0, 12)
    HostStatus.Position = UDim2.new(0, 0, 0, 45)
    HostStatus.BackgroundTransparency = 1
    HostStatus.Text = "⚡ Modo: Verificación ultra rápida activada"
    HostStatus.TextColor3 = Color3.fromRGB(120, 255, 120)
    HostStatus.TextSize = 9
    HostStatus.Font = Enum.Font.Gotham
    
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = Frame
    TextBox.Size = UDim2.new(0.9, 0, 0, 30)
    TextBox.Position = UDim2.new(0.05, 0, 0, 65)
    TextBox.PlaceholderText = "Introduce tu clave aqui"
    TextBox.Font = Enum.Font.Gotham
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    TextBox.BorderSizePixel = 0
    TextBox.TextSize = 12
    
    local TextBoxCorner = Instance.new("UICorner")
    TextBoxCorner.CornerRadius = UDim.new(0, 4)
    TextBoxCorner.Parent = TextBox

    local function crearBoton(texto, posX, color)
        local boton = Instance.new("TextButton")
        boton.Parent = Frame
        boton.Size = UDim2.new(0.4, 0, 0, 30)
        boton.Position = UDim2.new(posX, 0, 0, 105)
        boton.Text = texto
        boton.Font = Enum.Font.GothamBold
        boton.TextColor3 = Color3.new(1, 1, 1)
        boton.BackgroundColor3 = color
        boton.BorderSizePixel = 0
        boton.TextSize = 11
        
        local BotonCorner = Instance.new("UICorner")
        BotonCorner.CornerRadius = UDim.new(0, 4)
        BotonCorner.Parent = boton
        
        return boton
    end

    local BotonVerificar = crearBoton("⚡ Verificar", 0.05, Color3.fromRGB(0, 180, 120))
    local BotonCopiar = crearBoton("🔗 Generar Link", 0.55, Color3.fromRGB(0, 120, 200))
    
    local Status = Instance.new("TextLabel")
    Status.Parent = Frame
    Status.Size = UDim2.new(0.9, 0, 0, 20)
    Status.Position = UDim2.new(0.05, 0, 0, 145)
    Status.BackgroundTransparency = 1
    Status.Text = "⚡ Sistema ultra rápido listo"
    Status.TextColor3 = Color3.fromRGB(120, 255, 120)
    Status.TextSize = 10
    Status.Font = Enum.Font.Gotham
    
    local LogFrame = Instance.new("ScrollingFrame")
    LogFrame.Parent = Frame
    LogFrame.Size = UDim2.new(0.9, 0, 0, 200)
    LogFrame.Position = UDim2.new(0.05, 0, 0, 170)
    LogFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    LogFrame.BorderSizePixel = 0
    LogFrame.ScrollBarThickness = 6
    
    local LogFrameCorner = Instance.new("UICorner")
    LogFrameCorner.CornerRadius = UDim.new(0, 4)
    LogFrameCorner.Parent = LogFrame
    
    local LogList = Instance.new("UIListLayout")
    LogList.Parent = LogFrame
    LogList.SortOrder = Enum.SortOrder.LayoutOrder
    LogList.Padding = UDim.new(0, 2)
    
    local function updateLogDisplay()
        for _, child in ipairs(LogFrame:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        local recentLogs = {}
        for i = math.max(1, #DEBUG.logs - 15), #DEBUG.logs do
            if DEBUG.logs[i] then
                table.insert(recentLogs, DEBUG.logs[i])
            end
        end
        
        for i, logEntry in ipairs(recentLogs) do
            local LogLabel = Instance.new("TextLabel")
            LogLabel.Parent = LogFrame
            LogLabel.Size = UDim2.new(1, -10, 0, 18)
            LogLabel.BackgroundTransparency = 1
            LogLabel.Text = string.format("%s [%s] %s", 
                logEntry.timestamp:sub(1, 15), logEntry.level, logEntry.message)
            LogLabel.TextColor3 = logEntry.level == "ERROR" and Color3.fromRGB(255, 120, 120) or
                                 logEntry.level == "WARN" and Color3.fromRGB(255, 200, 120) or
                                 logEntry.level == "SUCCESS" and Color3.fromRGB(120, 255, 120) or
                                 logEntry.level == "INFO" and Color3.fromRGB(120, 200, 255) or
                                 Color3.fromRGB(180, 180, 180)
            LogLabel.TextSize = 9
            LogLabel.Font = Enum.Font.Code
            LogLabel.TextXAlignment = Enum.TextXAlignment.Left
            LogLabel.LayoutOrder = i
        end
        
        LogFrame.CanvasSize = UDim2.new(0, 0, 0, #recentLogs * 20)
        LogFrame.CanvasPosition = Vector2.new(0, LogFrame.CanvasSize.Y.Offset)
    end
    
    task.spawn(function()
        while KeyGui.Parent do
            updateLogDisplay()
            task.wait(5)
        end
    end)

    BotonVerificar.MouseButton1Click:Connect(function()
        local clave = TextBox.Text:gsub("%s+", "")
        
        if clave == "" then
            Status.Text = "❌ Por favor, introduce una clave"
            Status.TextColor3 = Color3.fromRGB(255, 120, 120)
            return
        end
        
        Status.Text = "⚡ Verificando súper rápido..."
        Status.TextColor3 = Color3.fromRGB(255, 255, 120)
        BotonVerificar.Text = "⚡ Verificando..."
        BotonVerificar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        
        task.spawn(function()
            if verificarClave(clave) then
                Status.Text = "✅ Clave aceptada!"
                Status.TextColor3 = Color3.fromRGB(120, 255, 120)
                task.wait(0.2)
                KeyGui:Destroy()
                script()
            else
                Status.Text = "❌ Clave inválida"
                Status.TextColor3 = Color3.fromRGB(255, 120, 120)
                TextBox.Text = ""
                BotonVerificar.Text = "⚡ Verificar"
                BotonVerificar.BackgroundColor3 = Color3.fromRGB(0, 180, 120)
            end
        end)
    end)

    BotonCopiar.MouseButton1Click:Connect(function()
        Status.Text = "🔗 Generando link rápido..."
        Status.TextColor3 = Color3.fromRGB(255, 255, 120)
        BotonCopiar.Text = "🔗 Generando..."
        BotonCopiar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        
        task.spawn(function()
            local link = generateLink()
            if link then
                Status.Text = "✅ Link generado y copiado"
                Status.TextColor3 = Color3.fromRGB(120, 255, 120)
                fSetClipboard(link)
                BotonCopiar.Text = "✅ Copiado!"
                BotonCopiar.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                task.wait(3)
                BotonCopiar.Text = "🔗 Generar Link"
                BotonCopiar.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
            else
                Status.Text = "❌ Error generando link"
                Status.TextColor3 = Color3.fromRGB(255, 120, 120)
                BotonCopiar.Text = "🔗 Generar Link"
                BotonCopiar.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
            end
        end)
    end)
    
    logSuccess("GUI", "✅ Interfaz rápida creada")
end

logInfo("INIT", "⚡ Iniciando sistema ultra rápido")

if claveEsValida() then
    logSuccess("INIT", "✅ Acceso válido - Ejecutando script")
    script()
else
    logInfo("INIT", "🎨 Mostrando interfaz")
    crearGUI()
end

_G.ShowAllLogs = function()
    print("=== LOGS COMPLETOS ===")
    for i, log in ipairs(DEBUG.logs) do
        print(string.format("%d. %s [%s] [%s] %s", 
            i, log.timestamp, log.level, log.category, log.message))
    end
    print("=== FIN ===")
end

logSuccess("INIT", "⚡ Sistema ultra rápido listo")

else
            local msg = Instance.new("Message", workspace)
            msg.Text = "☠️☠️Usuario No Permitido Por Bot☠️☠️"
            task.delay(15, function()
                msg:Destroy()
            end)
        end
    end)
end)  