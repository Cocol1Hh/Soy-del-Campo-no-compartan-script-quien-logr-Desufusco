-- Every Second You Get +1 Jump
local function generateUniqueComplexId()
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local id = ""
    local timestamp = tostring(os.time()):reverse()
    for i = 1, 64 do
        local randomIndex = math.random(1, #chars)
        id = id .. chars:sub(randomIndex, randomIndex)
    end
    local finalId = id .. timestamp
    return finalId
end

local scriptIdentifier = "FernandoHubV2_UniqueID"
if _G[scriptIdentifier] then
    return
end
_G[scriptIdentifier] = true

local scriptId = generateUniqueComplexId()

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
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local lplr = game:GetService("Players").LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local Stats = game:GetService("Stats")

local runningTasks = {}
local errorHistory = {}
local switchErrors = {}
local uniqueErrors = {}
local reportWebhookUrl = "https://discord.com/api/webhooks/1402407342573617173/GWDxXux2I5UBHcatVnCDrwGFjUt2lquPGFJR4OC1yEkU2D5pSyz-n0JxmRgJGUQnc9Nd"

local function getCurrentLineNumber()
    local info = debug.getinfo(3, "l")
    return info and info.currentline or "Unknown"
end

local function addError(errorMsg, lineNum, codeSection, functionName, switchName)
    local errorKey = errorMsg .. "|" .. (switchName or "General")
    
    if uniqueErrors[errorKey] then
        return
    end
    
    uniqueErrors[errorKey] = true
    
    local actualLine = lineNum
    if type(errorMsg) == "string" and errorMsg:find(":(%d+):") then
        actualLine = errorMsg:match(":(%d+):")
    end
    
    local errorInfo = {
        timestamp = os.date("%H:%M:%S"),
        date = os.date("%d/%m/%Y"),
        message = errorMsg,
        line = actualLine or "Unknown",
        section = codeSection or "Unknown",
        function_name = functionName or "Unknown",
        switch_name = switchName or "General",
        id = #errorHistory + 1,
        severity = errorMsg:find("critical") and "CRITICAL" or errorMsg:find("warning") and "WARNING" or "ERROR"
    }
    
    table.insert(errorHistory, 1, errorInfo)
    
    if switchName then
        if not switchErrors[switchName] then
            switchErrors[switchName] = {}
        end
        table.insert(switchErrors[switchName], 1, errorInfo)
    end
    
    if #errorHistory > 20 then
        table.remove(errorHistory, #errorHistory)
    end
    
    updateErrorDisplay()
end

local function addTask(taskThread)
    table.insert(runningTasks, taskThread)
end

local function stopAllTasks()
    for _, task in pairs(runningTasks) do
        if task and typeof(task) == "thread" then
            pcall(function()
                task:Cancel()
            end)
        end
    end
    runningTasks = {}
end


local function getAvatarUrl(userId)
    local url = "https://thumbnails.roblox.com/v1/users/avatar?userIds=" .. userId .. "&size=420x420&format=Png"
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        local data = HttpService:JSONDecode(response)
        if data.data and #data.data > 0 then
            return data.data[1].imageUrl
        end
    end
    return nil
end

local fullName = MarketplaceService:GetProductInfo(game.PlaceId).Name
local filteredName = fullName:gsub("%b[]", function(match)
    local inner = match:sub(2, -2)
    if inner:find("[%z\1-\127\194-\244][\128-\191]*") and not inner:find("[%w]") then
        return inner
    else
        return ""
    end
end)
filteredName = filteredName:gsub("%s%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""):upper()
if filteredName:sub(-1) == "." then
    filteredName = filteredName:sub(1, -2)
end

Fernando.Name = scriptId
Fernando.ResetOnSpawn = false 
Fernando.DisplayOrder = 999 
Fernando.Parent = lplr:WaitForChild("PlayerGui")

local function formatNumber(value)
	local suffixes = {'', 'K', 'M', 'B', 'T', 'qd', 'Qn'}
	local multipliers = {K = 1e3, M = 1e6, B = 1e9, T = 1e12, qd = 1e15, Qn = 1e18}
	local isNegative = false
	if type(value) == "string" then
		local num, suffix = string.match(value, "([%-]?[%d%.]+)([KMBTqdQn]?)")
		num = tonumber(num)
		if num and suffix ~= "" then
			value = num * (multipliers[suffix] or 1)
		else
			value = tonumber(value) or 0
		end
	end
	if value < 0 then isNegative = true value = math.abs(value) end
	for i = 1, #suffixes do
		if value < 10^(i * 3) then
			local divisor = 10^((i - 1) * 3)
			local formatted = math.floor((value / divisor) * 100) / 100
			return (isNegative and "-" or "") .. formatted .. suffixes[i]
		end
	end
	return (isNegative and "-" or "") .. tostring(value):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
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
TextLabel.Text = " "
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
TextLabel.TextSize = 14
TextLabel.TextStrokeTransparency = 0
TextLabel.TextScaled = true

local textLabel = Instance.new("TextLabel")
textLabel.Parent = Frame
textLabel.Size = UDim2.new(0.75, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = filteredName
textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
textLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
textLabel.TextStrokeTransparency = 0
textLabel.TextScaled = true
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.TextYAlignment = Enum.TextYAlignment.Top

Cuadro1.Parent = TextLabel
Cuadro1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro1.Position = UDim2.new(0, 0, 1, 0)
Cuadro1.Size = UDim2.new(0, 410, 0, 400)
Cuadro1.Visible = false

Cuadro2.Parent = TextLabel
Cuadro2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro2.Position = UDim2.new(0, 0, 1, 0)
Cuadro2.Size = UDim2.new(0, 410, 0, 400)
Cuadro2.Visible = false

Cuadro3.Parent = TextLabel
Cuadro3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cuadro3.Position = UDim2.new(0, 0, 1, 0)
Cuadro3.Size = UDim2.new(0, 410, 0, 400)
Cuadro3.Visible = false

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
Siguiente.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Siguiente.Position = UDim2.new(0.9, 17, 0, 0)
Siguiente.Size = UDim2.new(0, 30, 0, 30)
Siguiente.Text = ">"
Siguiente.TextColor3 = Color3.fromRGB(255, 255, 255)
Siguiente.TextSize = 20

local siguienteCorner = Instance.new("UICorner")
siguienteCorner.CornerRadius = UDim.new(0, 5)
siguienteCorner.Parent = Siguiente

Mix.Parent = Frame
Mix.BackgroundTransparency = 1
Mix.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Mix.Position = UDim2.new(0.880, 0, 0, 0)
Mix.Size = UDim2.new(0, 30, 0, 30)
Mix.Text = "+"
Mix.TextColor3 = Color3.fromRGB(255, 255, 255)
Mix.TextSize = 20

local mixCorner = Instance.new("UICorner")
mixCorner.CornerRadius = UDim.new(0, 5)
mixCorner.Parent = Mix

local errorTitle = Instance.new("TextLabel")
errorTitle.Parent = Barra2
errorTitle.Size = UDim2.new(1, 0, 0, 30)
errorTitle.Position = UDim2.new(0, 0, 0, 0)
errorTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
errorTitle.BorderColor3 = Color3.fromRGB(255, 0, 0)
errorTitle.BorderSizePixel = 2
errorTitle.Text = "🔍 ERROR MONITOR & CODE REVIEW"
errorTitle.TextColor3 = Color3.fromRGB(255, 255, 0)
errorTitle.TextScaled = true
errorTitle.Font = Enum.Font.SourceSansBold

local clearErrorsBtn = Instance.new("TextButton")
clearErrorsBtn.Parent = Barra2
clearErrorsBtn.Size = UDim2.new(0.2, 0, 0, 20)
clearErrorsBtn.Position = UDim2.new(0.78, 0, 0, 35)
clearErrorsBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
clearErrorsBtn.Text = "CLEAR"
clearErrorsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearErrorsBtn.TextScaled = true
clearErrorsBtn.Font = Enum.Font.SourceSansBold

local errorStatsFrame = Instance.new("Frame")
errorStatsFrame.Parent = Barra2
errorStatsFrame.Size = UDim2.new(1, 0, 0, 25)
errorStatsFrame.Position = UDim2.new(0, 0, 0, 60)
errorStatsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local errorStatsLabel = Instance.new("TextLabel")
errorStatsLabel.Parent = errorStatsFrame
errorStatsLabel.Size = UDim2.new(1, 0, 1, 0)
errorStatsLabel.BackgroundTransparency = 1
errorStatsLabel.Text = "Total Errors: 0 | Critical: 0 | Warnings: 0"
errorStatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
errorStatsLabel.TextScaled = true
errorStatsLabel.Font = Enum.Font.Code

local detailedErrorsFrame = Instance.new("ScrollingFrame")
detailedErrorsFrame.Parent = Barra2
detailedErrorsFrame.Size = UDim2.new(1, 0, 0.8, 0)
detailedErrorsFrame.Position = UDim2.new(0, 0, 0, 90)
detailedErrorsFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
detailedErrorsFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
detailedErrorsFrame.BorderSizePixel = 1
detailedErrorsFrame.ScrollBarThickness = 8
detailedErrorsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local detailedErrorsTitle = Instance.new("TextLabel")
detailedErrorsTitle.Parent = detailedErrorsFrame
detailedErrorsTitle.Size = UDim2.new(1, 0, 0, 20)
detailedErrorsTitle.Position = UDim2.new(0, 0, 0, 0)
detailedErrorsTitle.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
detailedErrorsTitle.Text = "📋 DETAILED ERROR LOG (Most Recent First)"
detailedErrorsTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
detailedErrorsTitle.TextScaled = true
detailedErrorsTitle.Font = Enum.Font.SourceSansBold

function sendErrorReport(errorInfo, additionalDesc)
    local success, errorMsg = pcall(function()
        local avatarUrl = getAvatarUrl(lplr.UserId)
        
        local embed = {
            ["embeds"] = {
                {
                    ["title"] = "🚨 REPORTE DE ERROR",
                    ["description"] = "**Un usuario ha reportado un error en el script**",
                    ["color"] = 0xff0000,
                    ["fields"] = {
                        {["name"] = "👤 Usuario", ["value"] = "`" .. lplr.Name .. "`", ["inline"] = true},
                        {["name"] = "🏷️ Apodo", ["value"] = "`" .. lplr.DisplayName .. "`", ["inline"] = true},
                        {["name"] = "🎮 Juego", ["value"] = "`" .. filteredName .. "`", ["inline"] = true},
                        {["name"] = "⚠️ Severidad", ["value"] = "`" .. errorInfo.severity .. "`", ["inline"] = true},
                        {["name"] = "🔧 Código", ["value"] = "`" .. errorInfo.switch_name .. "`", ["inline"] = true},
                        {["name"] = "📍 Línea", ["value"] = "`Línea " .. errorInfo.line .. "`", ["inline"] = true},
                        {["name"] = "🆔 Script ID", ["value"] = "`" .. scriptId:sub(1, 20) .. "...`", ["inline"] = true},
                        {["name"] = "⏰ Timestamp", ["value"] = "`" .. errorInfo.timestamp .. "`", ["inline"] = true},
                        {["name"] = "🏗️ Función", ["value"] = "`" .. errorInfo.function_name .. "`", ["inline"] = true},
                        {["name"] = "💬 Error", ["value"] = "\`\`\`lua\n" .. errorInfo.message .. "\`\`\`", ["inline"] = false},
                        {["name"] = "📝 Descripción Adicional", ["value"] = "\`\`\`" .. additionalDesc .. "\`\`\`", ["inline"] = false}
                    },
                    ["thumbnail"] = {
                        ["url"] = avatarUrl or "https://www.roblox.com/headshot-thumbnail/image?userId=" .. lplr.UserId .. "&width=420&height=420&format=png"
                    },
                    ["footer"] = {
                        ["text"] = "Sistema de Reportes • ID: " .. scriptId:sub(1, 16) .. "..."
                    },
                    ["timestamp"] = DateTime.now():ToIsoDate()
                }
            }
        }
        
        http_request({
            Url = reportWebhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(embed)
        })
        
        local confirmGui = Instance.new("ScreenGui")        
        confirmGui.ResetOnSpawn = false 
		confirmGui.DisplayOrder = 999 
		confirmGui.Parent =  lplr:WaitForChild("PlayerGui")
        
        local confirmFrame = Instance.new("Frame")
        confirmFrame.Parent = confirmGui
        confirmFrame.Size = UDim2.new(0, 300, 0, 100)
        confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
        confirmFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        
        local confirmText = Instance.new("TextLabel")
        confirmText.Parent = confirmFrame
        confirmText.Size = UDim2.new(1, 0, 1, 0)
        confirmText.BackgroundTransparency = 1
        confirmText.Text = "✅ REPORTE ENVIADO EXITOSAMENTE"
        confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
        confirmText.TextScaled = true
        confirmText.Font = Enum.Font.SourceSansBold
        
        task.wait(3)
        confirmGui:Destroy()
    end)
    
    if not success then
        local errorGui = Instance.new("ScreenGui")
		errorGui.ResetOnSpawn = false 
		errorGui.DisplayOrder = 999 
		errorGui.Parent =  lplr:WaitForChild("PlayerGui")
        
        local errorFrame = Instance.new("Frame")
        errorFrame.Parent = errorGui
        errorFrame.Size = UDim2.new(0, 300, 0, 100)
        errorFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
        errorFrame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        
        local errorText = Instance.new("TextLabel")
        errorText.Parent = errorFrame
        errorText.Size = UDim2.new(1, 0, 1, 0)
        errorText.BackgroundTransparency = 1
        errorText.Text = "❌ ERROR AL ENVIAR REPORTE"
        errorText.TextColor3 = Color3.fromRGB(255, 255, 255)
        errorText.TextScaled = true
        errorText.Font = Enum.Font.SourceSansBold
        
        task.wait(3)
        errorGui:Destroy()
    end
end

function createReportDialog(errorInfo)
    local reportGui = Instance.new("ScreenGui")
	reportGui.Name = "ErrorReportDialog"
	reportGui.ResetOnSpawn = false 
	reportGui.DisplayOrder = 999 
	reportGui.Parent =  lplr:WaitForChild("PlayerGui")
    
    local dialogFrame = Instance.new("Frame")
    dialogFrame.Parent = reportGui
    dialogFrame.Size = UDim2.new(0, 450, 0, 350)
    dialogFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    dialogFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    dialogFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    dialogFrame.BorderSizePixel = 2
    
    local dialogCorner = Instance.new("UICorner")
    dialogCorner.CornerRadius = UDim.new(0, 10)
    dialogCorner.Parent = dialogFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = dialogFrame
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    titleLabel.Text = "📤 REPORTAR ERROR - Línea " .. errorInfo.line
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    
    local errorInfoLabel = Instance.new("TextLabel")
    errorInfoLabel.Parent = dialogFrame
    errorInfoLabel.Size = UDim2.new(1, -20, 0, 80)
    errorInfoLabel.Position = UDim2.new(0, 10, 0, 40)
    errorInfoLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    errorInfoLabel.BorderColor3 = Color3.fromRGB(100, 100, 100)
    errorInfoLabel.BorderSizePixel = 1
    errorInfoLabel.Text = string.format("🚨 Error: %s\n🔧 Código: %s\n⚠️ Severidad: %s\n📍 Línea: %s\n🏗️ Función: %s", 
        errorInfo.message, errorInfo.switch_name, errorInfo.severity, errorInfo.line, errorInfo.function_name)
    errorInfoLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
    errorInfoLabel.TextScaled = true
    errorInfoLabel.TextWrapped = true
    errorInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    errorInfoLabel.TextYAlignment = Enum.TextYAlignment.Top
    errorInfoLabel.Font = Enum.Font.Code
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = dialogFrame
    descLabel.Size = UDim2.new(1, -20, 0, 20)
    descLabel.Position = UDim2.new(0, 10, 0, 130)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = "Descripción adicional:"
    descLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    descLabel.TextScaled = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local descTextBox = Instance.new("TextBox")
    descTextBox.Parent = dialogFrame
    descTextBox.Size = UDim2.new(1, -20, 0, 100)
    descTextBox.Position = UDim2.new(0, 10, 0, 155)
    descTextBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    descTextBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
    descTextBox.BorderSizePixel = 1
    descTextBox.Text = "Describe qué estabas haciendo cuando ocurrió el error en la línea " .. errorInfo.line .. "..."
    descTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    descTextBox.TextScaled = true
    descTextBox.TextWrapped = true
    descTextBox.MultiLine = true
    descTextBox.ClearTextOnFocus = true
    
    local sendButton = Instance.new("TextButton")
    sendButton.Parent = dialogFrame
    sendButton.Size = UDim2.new(0.4, 0, 0, 35)
    sendButton.Position = UDim2.new(0.1, 0, 0, 270)
    sendButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    sendButton.Text = "📤 ENVIAR REPORTE"
    sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    sendButton.TextScaled = true
    sendButton.Font = Enum.Font.SourceSansBold
    
    local cancelButton = Instance.new("TextButton")
    cancelButton.Parent = dialogFrame
    cancelButton.Size = UDim2.new(0.4, 0, 0, 35)
    cancelButton.Position = UDim2.new(0.5, 0, 0, 270)
    cancelButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    cancelButton.Text = "❌ CANCELAR"
    cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelButton.TextScaled = true
    cancelButton.Font = Enum.Font.SourceSansBold
    
    for _, button in pairs({sendButton, cancelButton}) do
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 5)
        corner.Parent = button
    end
    
    sendButton.MouseButton1Click:Connect(function()
        sendErrorReport(errorInfo, descTextBox.Text)
        reportGui:Destroy()
    end)
    
    cancelButton.MouseButton1Click:Connect(function()
        reportGui:Destroy()
    end)
end

function updateErrorDisplay()
    for _, child in pairs(detailedErrorsFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "Title" then
            child:Destroy()
        end
    end
    
    local totalErrors = #errorHistory
    local criticalCount = 0
    local warningCount = 0
    
    for _, error in pairs(errorHistory) do
        if error.severity == "CRITICAL" then
            criticalCount = criticalCount + 1
        elseif error.severity == "WARNING" then
            warningCount = warningCount + 1
        end
    end
    
    errorStatsLabel.Text = string.format("Total Errors: %d | Critical: %d | Warnings: %d | Active: %s", 
        totalErrors, criticalCount, warningCount, os.date("%H:%M:%S"))
    
    local detailedYOffset = 25
    for i = 1, math.min(#errorHistory, 10) do
        local error = errorHistory[i]
        if error then
            local errorFrame = Instance.new("Frame")
            errorFrame.Parent = detailedErrorsFrame
            errorFrame.Size = UDim2.new(1, -10, 0, 70)
            errorFrame.Position = UDim2.new(0, 5, 0, detailedYOffset)
            
            local severityColor = error.severity == "CRITICAL" and Color3.fromRGB(60, 0, 0) or
                                  error.severity == "WARNING" and Color3.fromRGB(60, 60, 0) or
                                  Color3.fromRGB(40, 20, 20)
            errorFrame.BackgroundColor3 = severityColor
            errorFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
            errorFrame.BorderSizePixel = 1
            
            local errorText = Instance.new("TextLabel")
            errorText.Parent = errorFrame
            errorText.Size = UDim2.new(0.8, 0, 1, 0)
            errorText.Position = UDim2.new(0, 0, 0, 0)
            errorText.BackgroundTransparency = 1
            
            local errorCodeName = error.switch_name or "Unknown"
            local cleanErrorMessage = error.message:gsub("^.*:", ""):gsub("^%s+", "")
            
            errorText.Text = string.format("🚨 [%s] %s - Línea %s\n💬 %s\n🏗️ %s", 
                error.severity, errorCodeName, error.line, cleanErrorMessage, error.function_name)
            errorText.TextColor3 = Color3.fromRGB(255, 200, 200)
            errorText.TextScaled = true
            errorText.TextWrapped = true
            errorText.Font = Enum.Font.Code
            errorText.TextXAlignment = Enum.TextXAlignment.Left
            errorText.TextYAlignment = Enum.TextYAlignment.Top
            
            local reportButton = Instance.new("TextButton")
            reportButton.Parent = errorFrame
            reportButton.Size = UDim2.new(0.18, 0, 0.8, 0)
            reportButton.Position = UDim2.new(0.8, 5, 0.1, 0)
            reportButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            reportButton.Text = "📤\nREPORT"
            reportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            reportButton.TextScaled = true
            reportButton.Font = Enum.Font.SourceSansBold
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 5)
            buttonCorner.Parent = reportButton
            
            reportButton.MouseButton1Click:Connect(function()
                createReportDialog(error)
            end)
            
            detailedYOffset = detailedYOffset + 75
        end
    end
    
    detailedErrorsFrame.CanvasSize = UDim2.new(0, 0, 0, detailedYOffset)
end

clearErrorsBtn.MouseButton1Click:Connect(function()
    errorHistory = {}
    switchErrors = {}
    uniqueErrors = {}
    updateErrorDisplay()
end)

local userId = lplr.UserId
local thumbnailUrl = game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)

local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 58, 0, 58)
imageLabel.Position = UDim2.new(0.07, 0, 0.04, 0)
imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = thumbnailUrl
imageLabel.Parent = Barra1

local pingLabel = Instance.new("TextLabel")
pingLabel.Size = UDim2.new(0, 40, 0, 10)
pingLabel.Position = UDim2.new(0.380, 0, 0.009, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLabel.TextSize = 7
pingLabel.Parent = Barra1

local Exp = Instance.new("TextLabel")
Exp.Size = UDim2.new(0, 100, 0, 10)
Exp.Position = UDim2.new(0.490, 0, 0.009, 0)
Exp.BackgroundTransparency = 1
Exp.TextColor3 = Color3.fromRGB(255, 255, 255)
Exp.TextSize = 7
Exp.Parent = Barra1

local serverPingLabel = Instance.new("TextLabel")
serverPingLabel.Size = UDim2.new(0, 60, 0, 10)
serverPingLabel.Position = UDim2.new(0.380, 0, 0.041, 0)
serverPingLabel.BackgroundTransparency = 1
serverPingLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
serverPingLabel.TextSize = 7
serverPingLabel.Parent = Barra1

local cpuLabel = Instance.new("TextLabel")
cpuLabel.Size = UDim2.new(0, 60, 0, 10)
cpuLabel.Position = UDim2.new(0.580, 0, 0.041, 0)
cpuLabel.BackgroundTransparency = 1
cpuLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
cpuLabel.TextSize = 7
cpuLabel.Parent = Barra1

local Rebiths = Instance.new("TextLabel")
Rebiths.Size = UDim2.new(0, 100, 0, 10)
Rebiths.Position = UDim2.new(0.120, 0, 0.009, 0)
Rebiths.BackgroundTransparency = 1
Rebiths.TextColor3 = Color3.fromRGB(255, 255, 255)
Rebiths.TextScaled = true
Rebiths.Text = "Rebirth"
Rebiths.Parent = Barra1

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 100, 0, 23)
statusLabel.Position = UDim2.new(0.134, 0, 0.03, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.Text = "Stats..."
statusLabel.Parent = Barra1

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

local Contenedor = Instance.new("ScrollingFrame", Barra1)
Contenedor.Size = UDim2.new(0, 400, 0, 200)
Contenedor.Position = UDim2.new(0.490, 0, 0.731, 0)
Contenedor.AnchorPoint = Vector2.new(0.5, 0.5)
Contenedor.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Contenedor.BorderSizePixel = 0
Contenedor.ScrollBarThickness = 6
Contenedor.CanvasSize = UDim2.new(0, 0, 0, 400)
Contenedor.ScrollingDirection = Enum.ScrollingDirection.Y

Borde1.Parent = Cuadro1
Borde1.Thickness = 2
Borde1.Color = Color3.fromRGB(255, 0, 0)

Borde2.Parent = Cuadro2
Borde2.Thickness = 2
Borde2.Color = Color3.fromRGB(255, 0, 0)

Borde3.Parent = Cuadro3
Borde3.Thickness = 2
Borde3.Color = Color3.fromRGB(255, 0, 0)

local borderTask = task.spawn(function()
    local colors = {
        Color3.fromRGB(255, 0, 0),
        Color3.fromRGB(0, 255, 0),
        Color3.fromRGB(0, 0, 255),
        Color3.fromRGB(255, 255, 0)
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
addTask(borderTask)

local textProperties = {
    {text = "Farm", position = UDim2.new(0.010, 0, 0.115, 0), color = Color3.fromRGB(255, 0, 0)},
    {text = "Spin", position = UDim2.new(0.520, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0)},
    {text = "Reb|Stats", position = UDim2.new(0.010, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255)},
    {text = "Gift", position = UDim2.new(0.520, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255)},
    {text = "Pets", position = UDim2.new(0.010, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0)},
    {text = "EquipPets", position = UDim2.new(0.520, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255)},
    {text = "Jump", position = UDim2.new(0.1, 0, 0.320, 0), color = Color3.fromRGB(200, 200, 200)},
    {text = "Speed", position = UDim2.new(0.653, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100)},
    {text = "Duck", position = UDim2.new(0.010, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 200)},
    {text = "PestTP", position = UDim2.new(0.520, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70)},
    {text = "NoTouch", position = UDim2.new(0.010, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},
    {text = "Inmortal", position = UDim2.new(0.520, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},
    {text = "Nill", position = UDim2.new(0.010, 0, 0.570, 0), color = Color3.fromRGB(200, 200, 90)},
    {text = "F|Vip", position = UDim2.new(0.520, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100)},
}

local uniformSize = UDim2.new(0, 75, 0, 36)
for _, props in pairs(textProperties) do
    local Frame = Instance.new("Frame")
    Frame.Parent = Barra1
    Frame.BackgroundTransparency = 1
    Frame.Size = uniformSize
    Frame.Position = props.position
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = true
    
    if props.position.X.Scale < 0 then
        Frame.Position = UDim2.new(0.001, 0, props.position.Y.Scale, 0)
    end
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Frame
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Position = UDim2.new(0, 0, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.TextStrokeColor3 = props.color
    TextLabel.TextStrokeTransparency = 0
    TextLabel.Text = props.text
    TextLabel.TextScaled = true
    TextLabel.TextWrapped = true
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    TextLabel.TextSize = 50
end

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
    return true
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
    pcall(function()
        lplr.Character.Humanoid:ChangeState(15)
    end)
end)

Mix.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    SaveMinimizedState(isMinimized)
    UpdateVisibility()
end)

local saveFileName = "Legends_Switches.json"

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

local activeBar, speed = nil, 0
local flying = true

local function saveValue(name, value)
    writefile(name..".json", HttpService:JSONEncode({v=value,t=os.time()}))
end

local function loadValue(name)
    return isfile(name..".json") and HttpService:JSONDecode(readfile(name..".json")).v or 0
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

local getIsActive1  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.120, 0), "Legends1",  LoadSwitchState("Legends1"))
local getIsActive2  = createSwitch(Barra1, UDim2.new(0.735, 0, 0.115, 0), "Legends2",  LoadSwitchState("Legends2"))
local getIsActive3  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.2,   0), "Legends3",  LoadSwitchState("Legends3"))
local getIsActive4  = createSwitch(Barra1, UDim2.new(0.735, 0, 0.195, 0), "Legends4",  LoadSwitchState("Legends4"))
local getIsActive5  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.275, 0), "Legends5",  LoadSwitchState("Legends5"))
local getIsActive6  = createSwitch(Barra1, UDim2.new(0.740, 0, 0.275, 0), "Legends6",  LoadSwitchState("Legends6"))
local getIsActive7  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.420, 0), "Legends7",  LoadSwitchState("Legends7"))
local getIsActive8  = createSwitch(Barra1, UDim2.new(0.740, 0, 0.420, 0), "Legends8",  LoadSwitchState("Legends8"))
local getIsActive9  = createSwitch(Barra1, UDim2.new(0.2,   0, 0.495, 0), "Legends9",  LoadSwitchState("Legends9"))
local getIsActive10 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.495, 0), "Legends10", LoadSwitchState("Legends10"))
local getIsActive11 = createSwitch(Barra1, UDim2.new(0.2,   0, 0.570, 0), "Legends11", LoadSwitchState("Legends11"))
local getIsActive12 = createSwitch(Barra1, UDim2.new(0.740, 0, 0.570, 0), "Legends12", LoadSwitchState("Legends12"))

local jumpInput = 0
local originalJumpPower

createBar(0, "Jump", Color3.fromRGB(255, 0, 0), 0.37, 100, function(v) 
    jumpInput = v
end, "jump")

local jumpTask = task.spawn(function()
    while true do
        local success, errorMsg = pcall(function()
            if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
                local hum = lplr.Character.Humanoid
                if not originalJumpPower then
                    originalJumpPower = hum.JumpPower
                end
                if jumpInput == 0 then
                    hum.JumpPower = originalJumpPower
                else
                    local val = jumpInput * 5
                    hum.JumpPower = val
                    local stats = lplr:FindFirstChild("leaderstats")
                    if stats and stats:FindFirstChild("Jump") then
                        stats.Jump.Value = val
                    end
                end
            end
        end)
        
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Jump System", "jumpTask", "Jump Control")
        end
        task.wait()
    end
end)
addTask(jumpTask)

local originalSpeed = nil

createBar(0.513, "Speed", Color3.fromRGB(0, 255, 0), 0.37, 200, function(v)
    local success, errorMsg = pcall(function()
        if originalSpeed == nil then
            local char = lplr.Character or lplr.CharacterAdded:Wait()
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                originalSpeed = hum.WalkSpeed
            end
        end
        speed = (v == 0 and originalSpeed) or v
        
        local speedTask = task.spawn(function()
            while true do
                task.wait()
                local success2, errorMsg2 = pcall(function()
                    local char = lplr.Character or lplr.CharacterAdded:Wait()
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then
                        hum.WalkSpeed = speed
                    end
                end)
                
                if not success2 then
                    addError(errorMsg, debug.info(1, "l"), "Speed System", "speedTask", "Speed Control")
                end
            end
        end)
        addTask(speedTask)
    end)
    
    if not success then
        addError(errorMsg, debug.info(1, "l"), "Speed System", "createBar callback", "Speed Control")
    end
end, "Speed")



--Aki incio del regitro 
local mainTask = task.spawn(function()
    local success, errorMsg = pcall(function()
        function player()
            if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
                if lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart") then
                    return true
                end
            end
            return false
        end
        
local multipliers = {
    K = 1e3,
    M = 1e6,
    B = 1e9,
    T = 1e12,
    Q = 1e15
}

local function getNextStatRequirement()
    local text = lplr.PlayerGui.MainGui.Frame.Rebirth.RebirthBar.Amount.Text
    local _, valorDerecho = text:match("([^/]+)/([^/]+)")
    if valorDerecho then
        local number, suffix = valorDerecho:match("([%d%.]+)(%a?)")
        local valor = tonumber(number)
        if valor then
            if suffix ~= "" and multipliers[suffix] then
                valor = valor * multipliers[suffix]
            end
            return valor
        end
    end
    return 0
end        
        
local task1 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive1() then
			local root = lplr.Character:WaitForChild("HumanoidRootPart")
			local wins = workspace:WaitForChild("Wins")
			local leaderstats = lplr:WaitForChild("leaderstats")
			local playerWins = leaderstats:WaitForChild("Wins").Value

			local mundos = {
				["World14"] = 20000,
				["World13"] = 15000,
				["World12"] = 10000,
				["World11"] = 6000,
				["World10"] = 3000,
				["World9"] = 1500,
				["World8"] = 750,
				["World7"] = 400,
				["World6"] = 200,
				["World5"] = 100,
				["World4"] = 50,
				["World3"] = 20,
				["World2"] = 5,
				["World1"] = 0,
			}

			local scrollingFrame = lplr.PlayerGui.MainGui.Frame.Teleport.ScrollingFrame
			local allOpen = true

			for _, child in pairs(scrollingFrame:GetDescendants()) do
				if child:IsA("TextLabel") and child.Name == "priceLabel" then
					if child.Text ~= "OPEN!" then
						allOpen = false
						break
					end
				end
			end

			local maxUnlockedIndexValue = leaderstats:FindFirstChild("MaxWorldUnlocked")
			if not maxUnlockedIndexValue then
				maxUnlockedIndexValue = Instance.new("IntValue")
				maxUnlockedIndexValue.Name = "MaxWorldUnlocked"
				maxUnlockedIndexValue.Value = 1
				maxUnlockedIndexValue.Parent = leaderstats
			end

			local targetIndex = 1

			if allOpen then
				targetIndex = math.max(14, maxUnlockedIndexValue.Value)
				if targetIndex > 14 then targetIndex = 14 end
			else
				for i = 14, 1, -1 do
					local worldName = "World" .. i
					local required = mundos[worldName]
					if playerWins >= required then
						targetIndex = i
						break
					end
				end
				if targetIndex < maxUnlockedIndexValue.Value then
					targetIndex = maxUnlockedIndexValue.Value
				end
			end

			if targetIndex > maxUnlockedIndexValue.Value then
				maxUnlockedIndexValue.Value = targetIndex
			end

			for i = targetIndex, 1, -1 do
				local worldName = "World" .. i
				local part = wins:FindFirstChild(worldName)
				if part and part:IsA("BasePart") then
					firetouchinterest(root, part, 0)
					task.wait()
					firetouchinterest(root, part, 1)
					break
			  	end
			   end
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 1", "task1", "AutoFarm")
        end
    end
end)
addTask(task1)

local task2 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive2() then
            game:GetService("ReplicatedStorage"):WaitForChild("SpinFolder"):WaitForChild("Spin"):FireServer()
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 2", "task2", "Spin Switch")
        end
    end
end)
addTask(task2)

local task3 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive3() then
            game:GetService("ReplicatedStorage"):WaitForChild("RebirthEvent"):FireServer()
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 3", "task3", "Reb|Stats")
        end
    end
end)
addTask(task3)

local task4 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive4() then
            for i = 1, 15 do
    game:GetService("ReplicatedStorage"):WaitForChild("Recv"):InvokeServer("TimeGift", tostring(i))
            end
            end
        end)
        if not success then
           addError(errorMsg, debug.info(1, "l"), "Switch Task 4", "task4", "Gift")
        end
    end
end)
addTask(task4)

local task5 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive5() then
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local workspaceEggs = workspace:WaitForChild("Eggs")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local huevoMasCercano = nil
            local menorDistancia = math.huge
            for _, huevo in pairs(workspaceEggs:GetChildren()) do
                local ui = huevo:FindFirstChild("UIanchor")
                if ui then
                    local distancia = (hrp.Position - ui.Position).Magnitude
                    if distancia < menorDistancia then
                        menorDistancia = distancia
                        huevoMasCercano = huevo
                    end
                end
            end
            if huevoMasCercano then
                local destino = huevoMasCercano:FindFirstChild("UIanchor")
                if destino and menorDistancia > 10 then
                    hrp.CFrame = destino.CFrame + Vector3.new(0, 3, 0)
                    task.wait(0.3)
                end
                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("EggOpened"):InvokeServer(huevoMasCercano.Name, "Single")
            end      
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 5", "task5", "Pets")
        end
    end
end)
addTask(task5)

local task6 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive6() then
            game.ReplicatedStorage.RemoteEvents.PetActionRequest:InvokeServer("EquipBest", {Pets = {}})
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 6", "task6", "EquipPets")
        end
    end
end)
addTask(task6)


local huevos = {
    {nombre = "Noob", requisito = 1},
    {nombre = "Starter", requisito = 2},
    {nombre = "Rare", requisito = 3},
    {nombre = "Pro", requisito = 8},
    {nombre = "Epic", requisito = 10},
    {nombre = "Legendary", requisito = 20},
    {nombre = "Mythical", requisito = 40},
    {nombre = "Godly", requisito = 80},
    {nombre = "Dark", requisito = 150},
    {nombre = "Void", requisito = 300},
    {nombre = "Desert", requisito = 500},
    {nombre = "Forest", requisito = 1200},
    {nombre = "Candy", requisito = 2000},
    {nombre = "Steampunk", requisito = 3000},
    {nombre = "Beach", requisito = 4000},
    {nombre = "Heaven", requisito = 5000},
}
local task8 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive8() then
            local wins = lplr.leaderstats:FindFirstChild("Wins")
        if wins then
            local disponibles = {}
            for _, huevo in ipairs(huevos) do
                if wins.Value >= huevo.requisito then
                    table.insert(disponibles, huevo)
                end
            end
            local top = {}
            for i = math.max(#disponibles - 3, 1), #disponibles do
                table.insert(top, disponibles[i])
            end
            for _, huevo in ipairs(top) do
                local obj = workspace:FindFirstChild("Eggs")
                if obj and obj:FindFirstChild(huevo.nombre) then
                    local pos = obj[huevo.nombre]:FindFirstChild("PriceBrick")
                    if pos then
                        lplr.Character:PivotTo(pos.CFrame + Vector3.new(0, 3, 0))
                        task.wait(10)
                    end
                end
            end
        end
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 8", "task8", "PestTP")
        end
    end
end)
addTask(task8)

local task9 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive9() then
            local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
		char:WaitForChild("Humanoid").BreakJointsOnDeath = false
		char:WaitForChild("Humanoid").Health = char.Humanoid.MaxHealth
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 9", "task9", "INMORTAL")
        end
    end
end)
addTask(task9)

local task10 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive10() then
            local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 10", "task10", "NoTouch")
        end
    end
end)
addTask(task10)

local task11 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive11() then
            
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 11", "task11", "Daily Switch")
        end
    end
end)
addTask(task11)

local task12 = task.spawn(function()
    while task.wait() do
        local success, errorMsg = pcall(function()
            if getIsActive12() then
            
            end
        end)
        if not success then
            addError(errorMsg, debug.info(1, "l"), "Switch Task 12", "task12", "Weekly Switch")
        end
    end
end)
addTask(task12)

 
 
local statsTask = task.spawn(function()
     while wait(1) do
    local success, errorMsg = pcall(function()
        if player() then
            local ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            pingLabel.Text = "Ping: " .. (ping < 1000 and ping or math.floor(ping / 10) * 10) .. " ms"---PING

               local fpsValue = math.floor(game:GetService("Stats").Workspace["Heartbeat"]:GetValue())
             Fps.Text = "FPS: " .. tostring(fpsValue)
             
             local serverPing = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() * 1.5)
			 serverPingLabel.Text = "Serv: " .. serverPing .. " ms"
			 
			 local cpuUsage = math.floor(Stats.PerformanceStats.CPU:GetValue() * 100)
			cpuLabel.Text = "CPU: " .. cpuUsage .. "%"
             		 	
             local RebirthV = lplr.leaderstats.Rebirth.Value			
             Rebiths.Text = "Rebirths: " .. tostring(RebirthV)
             
           if not totalWins then totalWins = 0 end			if not previousWins then previousWins = lplr.leaderstats.Wins.Value end
			local currentWins = lplr.leaderstats.Wins.Value
			if currentWins > previousWins then
				totalWins = totalWins + (currentWins - previousWins)
			end
			previousWins = currentWins
			Exp.Text = "Exps: " .. formatNumber(totalWins)
           
				local rebirthValue = lplr.leaderstats.Rebirth.Value
				local strengthValue = lplr.leaderstats.Wins.Value
				local nextRequirement = getNextStatRequirement()		
				statusLabel.Text = string.format(
				    "%s/%s\n%s",
				    formatNumber(nextRequirement),
				    formatNumber(strengthValue),
				    formatNumber(rebirthValue)
				)		
				local currentRebirthValue = lplr.leaderstats.Rebirth.Value
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
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Stats System", "statsTask", "Sistema  (Datos)")
                end
            end
        end)
        addTask(statsTask)
        
        
        
        --Traflamr en pato
        local isTransformed = false
        local originalAccessories = {}
        local originalTransparencies = {}
        local duckMesh = nil
        
        local function transformToDuck()
            if isTransformed or not lplr.Character then return end
            
            local success, errorMsg = pcall(function()
                originalAccessories = {}
                originalTransparencies = {}
                
                for _, v in pairs(lplr.Character:GetChildren()) do
                    if v:IsA("Hat") or v:IsA("Accessory") or v.Name:lower():find("hair") then
                        v.Parent = game.ReplicatedStorage
                        table.insert(originalAccessories, v)
                    elseif v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                        originalTransparencies[v] = v.Transparency
                        v.Transparency = 1
                    elseif v:IsA("MeshPart") then
                        originalTransparencies[v] = v.Transparency
                        v.Transparency = 1
                    end
                end
                
                if lplr.Character:FindFirstChild("Head") then
                    originalTransparencies[lplr.Character.Head] = lplr.Character.Head.Transparency
                    lplr.Character.Head.Transparency = 1
                    
                    local face = lplr.Character.Head:FindFirstChild("face")
                    if face then
                        face.Transparency = 1
                    end
                end
                
                duckMesh = Instance.new("SpecialMesh", lplr.Character.HumanoidRootPart)
                duckMesh.MeshId = "http://www.roblox.com/asset/?id=9419831"
                duckMesh.TextureId = "http://www.roblox.com/asset/?id=9419827"
                duckMesh.Scale = Vector3.new(5, 5, 5)
                duckMesh.Name = "DuckMesh"
                
                lplr.Character.HumanoidRootPart.Transparency = 0
                
                isTransformed = true
            end)
            
            if not success then
                addError(errorMsg, debug.info(1, "l"), "Duck Transform", "transformToDuck", "Duck Switch")
            end
        end
        
        local function revertTransformation()
            if not isTransformed or not lplr.Character then return end
            
            local success, errorMsg = pcall(function()
                local duckMeshToRemove = lplr.Character.HumanoidRootPart:FindFirstChild("DuckMesh")
                if duckMeshToRemove then
                    duckMeshToRemove:Destroy()
                end
                
                for _, accessory in pairs(originalAccessories) do
                    if accessory and accessory.Parent == game.ReplicatedStorage then
                        accessory.Parent = lplr.Character
                    end
                end
                
                for part, transparency in pairs(originalTransparencies) do
                    if part and part.Parent then
                        part.Transparency = transparency
                    end
                end
                
                if lplr.Character:FindFirstChild("Head") then
                    lplr.Character.Head.Transparency = 0
                    local face = lplr.Character.Head:FindFirstChild("face")
                    if face then
                        face.Transparency = 0
                    end
                end
                
                if lplr.Character:FindFirstChild("HumanoidRootPart") then
                    lplr.Character.HumanoidRootPart.Transparency = 1
                end
                
                isTransformed = false
                originalAccessories = {}
                originalTransparencies = {}
            end)
            
            if not success then
                addError(errorMsg, debug.info(1, "l"), "Duck Revert", "revertTransformation", "Duck Switch")
            end
        end
        
        local duckTask = task.spawn(function()
            while wait(0.4) do
                local success, errorMsg = pcall(function()
                    if player() then
                        if getIsActive7() and not isTransformed then
                            transformToDuck()
                        elseif not getIsActive7() and isTransformed then
                            revertTransformation()
                        end
                    end
                end)               
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Duck Controller", "duckTask", "Duck Switch")
                end
            end
        end)
        addTask(duckTask)
        
       
        
        local antiAfkTask1 = task.spawn(function()
            local success, errorMsg = pcall(function()
                local vu = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new())
                end)
            end)         
            if not success then
                addError(errorMsg, debug.info(1, "l"), "Anti-AFK System", "antiAfkTask1", "Anti-AFK")
            end
        end)
        addTask(antiAfkTask1)
        
        local antiAfkTask2 = task.spawn(function()
            local success, errorMsg = pcall(function()
                local bb = game:service 'VirtualUser'
                game:service 'Players'.LocalPlayer.Idled:connect(function()
                    bb:CaptureController()
                    bb:ClickButton2(Vector2.new())
                    task.wait(2)
                end)
            end)          
            if not success then
                addError(errorMsg, debug.info(1, "l"), "Anti-AFK Backup", "antiAfkTask2", "Anti-AFK")
            end
        end)
        addTask(antiAfkTask2)
        
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
    end)   
    if not success then
        addError(errorMsg, debug.info(1, "l"), "Main Task", "mainTask", "Core System")
    end
    task.wait()
end)
addTask(mainTask)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == lplr then
        cleanupAndClose()
    end
end)

Fernando.AncestryChanged:Connect(function()
    if not Fernando.Parent then
        cleanupAndClose()
    end
end)

--Fin de regitro 