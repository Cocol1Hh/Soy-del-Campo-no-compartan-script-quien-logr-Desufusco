local lplr = game.Players.LocalPlayer
local testerList = {
    
    "ghg",
    "fg"
}

local playerList = {
   
    "ggvcx",
    "gg"
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
local ArchivoClaveGuardada = "jses_syn_debug"

local DEBUG = {
    enabled = true,
    logs = {},
    maxLogs = 50,
    startTime = tick()
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
    
    if level == "ERROR" then
        warn(logString)
    else
        print(logString)
    end
    
    if data then
        print("Data:", HttpService:JSONEncode(data))
    end
    
    if level == "ERROR" then
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Debug Error - " .. category,
                Text = message,
                Duration = 5
            })
        end)
    end
end

local function logError(cat, msg, data) debugLog("ERROR", cat, msg, data) end
local function logWarn(cat, msg, data) debugLog("WARN", cat, msg, data) end
local function logInfo(cat, msg, data) debugLog("INFO", cat, msg, data) end
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

logInfo("SYSTEM", "Debug system initialized")
logInfo("SYSTEM", "System info", getSystemInfo())

local fSetClipboard = setclipboard or toclipboard or function(text)
    logWarn("CLIPBOARD", "Using fallback clipboard", {text = text:sub(1, 50) .. "..."})
    print("CLIPBOARD:", text)
end

local fRequest = request or http_request or (syn and syn.request) or function(options)
    logWarn("REQUEST", "Using HttpService fallback", {url = options.Url, method = options.Method})
    
    local success, result = pcall(function()
        if options.Method == "GET" then
            return {StatusCode = 200, Body = HttpService:GetAsync(options.Url)}
        else
            return {StatusCode = 200, Body = HttpService:PostAsync(options.Url, options.Body or "", Enum.HttpContentType.ApplicationJson)}
        end
    end)
    
    if success then
        logInfo("REQUEST", "HttpService fallback successful")
        return result
    else
        logError("REQUEST", "HttpService fallback failed", {error = result})
        return {StatusCode = 500, Body = '{"success": false}'}
    end
end

local fGetHwid = gethwid or function() 
    local hwid = tostring(Players.LocalPlayer.UserId)
    logInfo("HWID", "Using fallback HWID", {hwid = hwid})
    return hwid
end

local fIsFile = isfile or function() logWarn("FILE", "isfile not available"); return false end
local fReadFile = readfile or function() logWarn("FILE", "readfile not available"); return "" end
local fWriteFile = writefile or function(path, content) logWarn("FILE", "writefile not available", {path = path}) end
local fDelFile = delfile or function(path) logWarn("FILE", "delfile not available", {path = path}) end

local function log(...) 
    logInfo("MAIN", table.concat({...}, " "))
end

local function generateNonce()
    logDebug("NONCE", "Generating nonce")
    local nonce = string.gsub(HttpService:GenerateGUID(false), "-", ""):sub(1, 16)
    logDebug("NONCE", "Nonce generated", {nonce = nonce, length = #nonce})
    return nonce
end

local hosts = {
    "https://api.platoboost.com",
    "https://api.platoboost.net",
}

local function makeRequest(url, method, body, timeout)
    timeout = timeout or 15
    method = method or "GET"
    
    logInfo("REQUEST", "Making request", {
        url = url,
        method = method,
        has_body = body ~= nil,
        timeout = timeout
    })
    
    local requestData = {
        Url = url,
        Method = method,
        Headers = {
            ["Content-Type"] = "application/json",
            ["User-Agent"] = "Roblox/Debug-KeySystem"
        },
        Body = body and HttpService:JSONEncode(body) or nil
    }
    
    local startTime = tick()
    local success, response = pcall(function()
        return fRequest(requestData)
    end)
    local duration = tick() - startTime
    
    if success and response then
        logInfo("REQUEST", "Request completed", {
            status_code = response.StatusCode,
            duration = string.format("%.2fs", duration),
            body_length = response.Body and #response.Body or 0
        })
        
        if response.Body and response.Body:find("cloudflare") and response.Body:find("blocked") then
            logError("REQUEST", "Cloudflare block detected!", {
                url = url,
                status_code = response.StatusCode
            })
        end
        
        if response.Body and response.StatusCode == 200 then
            local parseSuccess, parsed = pcall(function()
                return HttpService:JSONDecode(response.Body)
            end)
            
            if parseSuccess then
                logDebug("REQUEST", "Response parsed successfully", parsed)
            else
                logWarn("REQUEST", "Failed to parse JSON", {
                    error = parsed,
                    body_preview = response.Body:sub(1, 200)
                })
            end
        end
        
        return response
    else
        logError("REQUEST", "Request failed", {
            error = tostring(response),
            url = url,
            duration = string.format("%.2fs", duration)
        })
        return nil
    end
end

local function testConnectivity()
    logInfo("CONNECTIVITY", "Testing all hosts for connectivity")
    
    for i, host in ipairs(hosts) do
        logInfo("CONNECTIVITY", string.format("Testing host %d/%d", i, #hosts), {host = host})
        
        local response = makeRequest(host .. "/public/connectivity", "GET", nil, 5)
        
        if response then
            if response.StatusCode == 200 or response.StatusCode == 404 then
                logInfo("CONNECTIVITY", "Host is working", {host = host, status = response.StatusCode})
                return host
            elseif response.StatusCode == 403 and response.Body and response.Body:find("cloudflare") then
                logWarn("CONNECTIVITY", "Host blocked by Cloudflare", {host = host})
            else
                logWarn("CONNECTIVITY", "Host returned error", {host = host, status = response.StatusCode})
            end
        else
            logError("CONNECTIVITY", "Host completely unreachable", {host = host})
        end
        
        task.wait(1)
    end
    
    logError("CONNECTIVITY", "All hosts failed, using primary as fallback")
    return hosts[1]
end

local function generateLink()
    logInfo("LINK", "Starting link generation process")
    
    local workingHost = testConnectivity()
    if not workingHost then
        logError("LINK", "No working host found")
        return nil
    end
    
    local requestData = {
        service = service,
        identifier = fGetHwid(),
        timestamp = os.time(),
        random = math.random(1000, 9999),
        debug = true
    }
    
    logInfo("LINK", "Sending link generation request", {
        host = workingHost,
        data = requestData
    })
    
    local response = makeRequest(workingHost .. "/public/start", "POST", requestData, 20)
    
    if response and response.StatusCode == 200 then
        local success, decoded = pcall(function()
            return HttpService:JSONDecode(response.Body)
        end)
        
        if success and decoded then
            logInfo("LINK", "Response decoded", decoded)
            
            if decoded.success and decoded.data and decoded.data.url then
                logInfo("LINK", "Link generated successfully", {url = decoded.data.url})
                return decoded.data.url
            else
                logError("LINK", "Invalid response structure", decoded)
            end
        else
            logError("LINK", "Failed to decode response", {
                error = decoded,
                body = response.Body:sub(1, 500)
            })
        end
    else
        logError("LINK", "Link generation failed", {
            status_code = response and response.StatusCode,
            host = workingHost
        })
    end
    
    return nil
end

local function verificarClave(clave)
    logInfo("KEY", "Starting key verification", {key_length = #clave, key_preview = clave:sub(1, 8) .. "..."})
    
    local identifier = fGetHwid()
    local nonce = useNonce and generateNonce() or nil
    
    logInfo("KEY", "Verification parameters", {
        identifier = identifier,
        nonce = nonce,
        use_nonce = useNonce
    })
    
    for i, currentHost in ipairs(hosts) do
        logInfo("KEY", string.format("Trying host %d/%d", i, #hosts), {host = currentHost})
        
        local whitelistUrl = string.format("%s/public/whitelist/%d?identifier=%s&key=%s%s",
            currentHost, service, HttpService:UrlEncode(identifier), 
            HttpService:UrlEncode(clave), nonce and "&nonce="..nonce or "")
        
        logDebug("KEY", "Checking whitelist", {url = whitelistUrl})
        
        local whitelistResponse = makeRequest(whitelistUrl, "GET", nil, 10)
        
        if whitelistResponse and whitelistResponse.StatusCode == 200 then
            local success, decoded = pcall(function()
                return HttpService:JSONDecode(whitelistResponse.Body)
            end)
            
            if success and decoded then
                logInfo("KEY", "Whitelist response", decoded)
                
                if decoded.success and decoded.data and decoded.data.valid then
                    logInfo("KEY", "Key is valid, saving to file")
                    
                    pcall(function()
                        fWriteFile(ArchivoClaveGuardada, HttpService:JSONEncode({
                            clave = clave, 
                            fecha = os.time(),
                            host = currentHost,
                            method = "whitelist"
                        }))
                    end)
                    
                    return true
                end
            else
                logWarn("KEY", "Failed to decode whitelist response", {error = decoded})
            end
        else
            logWarn("KEY", "Whitelist check failed", {
                status = whitelistResponse and whitelistResponse.StatusCode,
                host = currentHost
            })
        end
        
        logInfo("KEY", "Attempting key redemption", {host = currentHost})
        
        local redeemResponse = makeRequest(currentHost .. "/public/redeem/" .. service, "POST", {
            identifier = identifier,
            key = clave,
            nonce = nonce
        }, 10)
        
        if redeemResponse and redeemResponse.StatusCode == 200 then
            local success, decoded = pcall(function()
                return HttpService:JSONDecode(redeemResponse.Body)
            end)
            
            if success and decoded then
                logInfo("KEY", "Redeem response", decoded)
                
                if decoded.success then
                    logInfo("KEY", "Key redeemed successfully, saving to file")
                    
                    pcall(function()
                        fWriteFile(ArchivoClaveGuardada, HttpService:JSONEncode({
                            clave = clave, 
                            fecha = os.time(),
                            host = currentHost,
                            method = "redeem"
                        }))
                    end)
                    
                    return true
                else
                    logWarn("KEY", "Redeem failed", {message = decoded.message})
                end
            else
                logWarn("KEY", "Failed to decode redeem response", {error = decoded})
            end
        else
            logWarn("KEY", "Redeem request failed", {
                status = redeemResponse and redeemResponse.StatusCode,
                host = currentHost
            })
        end
        
        task.wait(0.5)
    end
    
    logError("KEY", "Key verification failed on all hosts")
    return false
end

local jugadoresPremio = {
    "Dayana093o", "armijosfernando2178", 
    "Rutao_Gameplays", "Dayanap091o", "FrivUpd",
    "emilialta_17", "Azeldex"
}

local function claveEsValida()
    local playerName = Players.LocalPlayer.Name
    logInfo("VALIDATION", "Checking if player has valid access", {player = playerName})
    
    if table.find(jugadoresPremio, playerName) then
        logInfo("VALIDATION", "Premium player detected", {player = playerName})
        return true
    end
    
    if fIsFile(ArchivoClaveGuardada) then
        logInfo("VALIDATION", "Saved key file found, reading...")
        
        local success, datos = pcall(function()
            return HttpService:JSONDecode(fReadFile(ArchivoClaveGuardada))
        end)
        
        if success and datos and datos.clave then
            logInfo("VALIDATION", "Saved key data loaded", {
                date = datos.fecha,
                host = datos.host,
                method = datos.method
            })
            
            if verificarClave(datos.clave) then
                logInfo("VALIDATION", "Saved key is still valid")
                return true
            else
                logWarn("VALIDATION", "Saved key expired, deleting file")
                pcall(function() fDelFile(ArchivoClaveGuardada) end)
            end
        else
            logError("VALIDATION", "Failed to parse saved key file", {error = datos})
        end
    else
        logInfo("VALIDATION", "No saved key file found")
    end
    
    return false
end

local function script()
    logInfo("MAIN", "EXECUTING MAIN SCRIPT")
    
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Script Loaded",
            Text = "Main script is now running!",
            Duration = 5
        })
    end)
    
    print("=== MAIN SCRIPT EXECUTED ===")
    print("Player:", Players.LocalPlayer.Name)
    print("Time:", os.date("%X"))
    print("Debug logs:", #DEBUG.logs)
    print("============================")
    
    
   local id = game.PlaceId
    local DBU_IDS = {
        3311165597,
        5151400895,
    }
    local MLGD_IDS = {
        3623096087,
    }
    local Speed_IDS = {
        3101667897,
        3276265788,
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
    
    task.spawn(function()
        if table.find(Speed_IDS, id) then
            logInfo("MAIN", "🎮 Cargando script de Speed of Lengeds ...")
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/Eped.lua"))()
            end)
        end
    end)
  
    
    logInfo("MAIN", "Main script execution completed")
end

local function crearGUI()
    logInfo("GUI", "Creating debug GUI interface")
    
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
    Frame.Size = UDim2.new(0, 450, 0, 350)
    Frame.Position = UDim2.new(0.5, -225, 0.5, -175)
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
    Title.Text = "Debug Key System - " .. getSystemInfo().executor
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    
    local SystemInfo = Instance.new("TextLabel")
    SystemInfo.Parent = Frame
    SystemInfo.Size = UDim2.new(1, 0, 0, 15)
    SystemInfo.Position = UDim2.new(0, 0, 0, 30)
    SystemInfo.BackgroundTransparency = 1
    SystemInfo.Text = string.format("Player: %s | HWID: %s | Logs: %d", 
        Players.LocalPlayer.Name, fGetHwid():sub(1, 8) .. "...", #DEBUG.logs)
    SystemInfo.TextColor3 = Color3.fromRGB(180, 180, 180)
    SystemInfo.TextSize = 10
    SystemInfo.Font = Enum.Font.Gotham
    
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = Frame
    TextBox.Size = UDim2.new(0.9, 0, 0, 30)
    TextBox.Position = UDim2.new(0.05, 0, 0, 55)
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
        boton.Position = UDim2.new(posX, 0, 0, 95)
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

    local BotonVerificar = crearBoton("Verificar Clave", 0.05, Color3.fromRGB(0, 180, 120))
    local BotonCopiar = crearBoton("Generar Link", 0.55, Color3.fromRGB(0, 120, 200))
    
    local Status = Instance.new("TextLabel")
    Status.Parent = Frame
    Status.Size = UDim2.new(0.9, 0, 0, 20)
    Status.Position = UDim2.new(0.05, 0, 0, 135)
    Status.BackgroundTransparency = 1
    Status.Text = "Ready - Check console for detailed logs"
    Status.TextColor3 = Color3.fromRGB(180, 180, 180)
    Status.TextSize = 10
    Status.Font = Enum.Font.Gotham
    
    local LogFrame = Instance.new("ScrollingFrame")
    LogFrame.Parent = Frame
    LogFrame.Size = UDim2.new(0.9, 0, 0, 180)
    LogFrame.Position = UDim2.new(0.05, 0, 0, 160)
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
            task.wait(2)
        end
    end)

    BotonVerificar.MouseButton1Click:Connect(function()
        local clave = TextBox.Text:gsub("%s+", "")
        
        if clave == "" then
            Status.Text = "Por favor, introduce una clave"
            Status.TextColor3 = Color3.fromRGB(255, 120, 120)
            return
        end

        Status.Text = "Verificando clave... (revisa logs)"
        Status.TextColor3 = Color3.fromRGB(255, 255, 120)
        
        task.spawn(function()
            if verificarClave(clave) then
                Status.Text = "Clave aceptada!"
                Status.TextColor3 = Color3.fromRGB(120, 255, 120)
                task.wait(0.2)
                KeyGui:Destroy()
                script()
            else
                Status.Text = "Clave invalida (revisa logs para detalles)"
                Status.TextColor3 = Color3.fromRGB(255, 120, 120)
                TextBox.Text = ""
            end
        end)
    end)

    BotonCopiar.MouseButton1Click:Connect(function()
        Status.Text = "Generando link... (revisa logs)"
        Status.TextColor3 = Color3.fromRGB(255, 255, 120)
        
        task.spawn(function()
            local link = generateLink()
            if link then
                Status.Text = "Link generado y copiado"
                Status.TextColor3 = Color3.fromRGB(120, 255, 120)
                if fSetClipboard then fSetClipboard(link) end
            else
                Status.Text = "No se pudo generar el link (revisa logs)"
                Status.TextColor3 = Color3.fromRGB(255, 120, 120)
            end
        end)
    end)
    
    logInfo("GUI", "Debug GUI created successfully")
end

logInfo("INIT", "Starting debug key system")

local connectivityTest = makeRequest(hosts[1] .. "/public/connectivity", "GET", nil, 5)
if connectivityTest then
    logInfo("INIT", "Initial connectivity test", {status = connectivityTest.StatusCode})
else
    logWarn("INIT", "Initial connectivity test failed - may be blocked")
end

if claveEsValida() then
    logInfo("INIT", "Valid access detected, executing main script")
    script()
else
    logInfo("INIT", "No valid access, showing GUI")
    crearGUI()
end

_G.ShowAllLogs = function()
    print("=== DEBUG LOGS ===")
    for i, log in ipairs(DEBUG.logs) do
        print(string.format("%d. %s [%s] [%s] %s", 
            i, log.timestamp, log.level, log.category, log.message))
        if log.data then
            print("Data:", HttpService:JSONEncode(log.data))
        end
    end
    print("=== END LOGS ===")
end

logInfo("INIT", "Debug system ready. Use _G.ShowAllLogs() to see all logs")

        else
            local msg = Instance.new("Message", workspace)
            msg.Text = "☠️☠️Usuario No Permitido Por Bot☠️☠️"
            task.delay(15, function()
                msg:Destroy()
            end)
        end
    end)
end)
