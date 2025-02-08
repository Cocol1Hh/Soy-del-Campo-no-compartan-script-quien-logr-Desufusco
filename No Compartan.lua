local HttpService = game:GetService("HttpService")

local http_request = (syn and syn.request) or (http and http.request) or http_request
if not http_request then
    http_request = function(requestData)
        local response = {}
        local success, result = pcall(function()
            return HttpService:RequestAsync(requestData)
        end)
        if success and result then
            response.StatusCode = result.StatusCode
            response.StatusMessage = result.StatusMessage
            response.Body = result.Body
        else
            response.StatusCode = -1
            response.StatusMessage = "Error interno en HttpService"
            response.Body = tostring(result)
        end
        return response
    end
end

local function scriptPrincipal()
    local success, errorMessage = pcall(function()
        -- Aquí va el código principal que deseas ejecutar después de la validación de la clave
        print("¡Clave válida! Ejecutando script principal...")
    end)

    if not success then
        warn("Error en el script principal: " .. tostring(errorMessage))
    end
end

local function guardarClaveGuardada(clave)
    pcall(function()
        writefile("jses_syn", HttpService:JSONEncode({clave = clave, fecha = os.time()}))
    end)
end

local function cargarClaveGuardada()
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile("jses_syn"))
    end)
    if success and data and data.clave then
        return data.clave
    else
        return nil
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

    if response and response.StatusCode == 200 then
        local responseBody = HttpService:JSONDecode(response.Body)
        if responseBody and responseBody.success and responseBody.data and responseBody.data.valid then
            guardarClaveGuardada(clave)
            return true, "Clave válida"
        else
            return false, "Clave inválida"
        end
    elseif response then
        return false, response.StatusMessage or "Clave inválida"
    else
        return false, "Error al verificar la clave"
    end
end

local function generarLink()
    local identifier = "roblox-client-" .. game.Players.LocalPlayer.UserId
    local datos = {
        service = 1951,
        identifier = identifier
    }

    local success, result = pcall(function()
        local response = http_request({
            Url = "https://api.platoboost.com/public/start",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Accept"] = "application/json"
            },
            Body = HttpService:JSONEncode(datos)
        })

        if response then
            print("Código de estado:", response.StatusCode)
            print("Mensaje de estado:", response.StatusMessage)
            print("Cuerpo de la respuesta:", response.Body)

            if response.StatusCode == 200 then
                local responseBody = HttpService:JSONDecode(response.Body)
                if responseBody and responseBody.success and responseBody.data and responseBody.data.url then
                    return responseBody.data.url
                else
                    return "Error: No se encontró un enlace válido en la respuesta."
                end
            else
                return "Error HTTP: Código " .. tostring(response.StatusCode) .. " - " .. (response.StatusMessage or "")
            end
        else
            return "Error: No se recibió respuesta del servidor."
        end
    end)

    if success then
        return result
    else
        print("Error detallado:", result)
        return "Error al procesar la solicitud para generar el link. Detalles en la consola."
    end
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0.318, 0, 0.4, 0)
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

local BotonVerificar = Instance.new("TextButton")
BotonVerificar.Size = UDim2.new(0.7, 0, 0.15, 0)
BotonVerificar.Position = UDim2.new(0.15, 0, 0.5, 0)
BotonVerificar.Text = "Verificar Clave"
BotonVerificar.Font = Enum.Font.GothamBold
BotonVerificar.TextScaled = true
BotonVerificar.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonVerificar.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
BotonVerificar.BorderSizePixel = 0
BotonVerificar.Parent = Frame

BotonVerificar.MouseButton1Click:Connect(function()
    local clave = TextBox.Text
    if clave ~= "" then
        local esValida, mensaje = verificarClave(clave)
        if esValida then
            TextBox.Text = "¡Clave válida!"
            TextBox.TextColor3 = Color3.fromRGB(100, 255, 100)
            KeyGui:Destroy()
            scriptPrincipal()
        else
            TextBox.Text = ""
        end
    end
end)

local BotonUrl = Instance.new("TextButton")
BotonUrl.Size = UDim2.new(0.7, 0, 0.15, 0)
BotonUrl.Position = UDim2.new(0.15, 0, 0.7, 0)
BotonUrl.Text = "Generar URL de Clave"
BotonUrl.Font = Enum.Font.GothamBold
BotonUrl.TextScaled = true
BotonUrl.TextColor3 = Color3.fromRGB(255, 255, 255)
BotonUrl.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
BotonUrl.BorderSizePixel = 0
BotonUrl.Parent = Frame

BotonUrl.MouseButton1Click:Connect(function()
    TextBox.Text = "Generando link..."
    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    local linkGenerado = generarLink()
    
    if string.sub(linkGenerado, 1, 4) == "http" then
        setclipboard(linkGenerado)
        TextBox.Text = "¡Link generado y copiado!"
        TextBox.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        TextBox.Text = "Error al generar link. Verifica la consola."
        TextBox.TextColor3 = Color3.fromRGB(255, 100, 100)
        print("Error detallado:", linkGenerado)
        
        -- Intenta mostrar más detalles en la GUI
        local ErrorDetails = Instance.new("TextLabel")
        ErrorDetails.Size = UDim2.new(0.9, 0, 0.2, 0)
        ErrorDetails.Position = UDim2.new(0.05, 0, 0.9, 0)
        ErrorDetails.BackgroundTransparency = 1
        ErrorDetails.TextColor3 = Color3.fromRGB(255, 100, 100)
        ErrorDetails.TextScaled = true
        ErrorDetails.Font = Enum.Font.Gotham
        ErrorDetails.Text = linkGenerado
        ErrorDetails.Parent = Frame
        
        game:GetService("Debris"):AddItem(ErrorDetails, 10) -- Elimina el mensaje de error después de 10 segundos
    end
end)

-- Cargar clave guardada y verificar automáticamente
local claveGuardada = cargarClaveGuardada()
if claveGuardada then
    local esValida, _ = verificarClave(claveGuardada)
    if esValida then
        KeyGui:Destroy()
        scriptPrincipal()
    end
end
