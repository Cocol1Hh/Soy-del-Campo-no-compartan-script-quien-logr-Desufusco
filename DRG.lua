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

local scriptId = generateUniqueComplexId()
local scriptName = "FernandoHubV2"
if _G[scriptName] then
    print("Ya hay un " .. scriptName .. " abierto!")
    return
end
_G[scriptName] = true

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
local lplr = game.Players.LocalPlayer
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)
local Ex = game:GetService("ReplicatedStorage").Package.Events
local MarketplaceService = game:GetService("MarketplaceService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gto = Players.LocalPlayer
local dataFolder = ReplicatedStorage:WaitForChild("Datas")

local cam = workspace.CurrentCamera

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
    descTextBox.Text = "Detalles del Error" .. errorInfo.line .. "..."
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

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 100, 0, 23)
statusLabel.Position = UDim2.new(0.134, 0, 0.03, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.Text = "Stats..."
statusLabel.Parent = Barra1

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


local masteryLabel = Instance.new("TextLabel")
masteryLabel.Size = UDim2.new(0, 100, 0, 10)
masteryLabel.Position = UDim2.new(0.120, 0, 0.009, 0)
masteryLabel.BackgroundTransparency = 1
masteryLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
masteryLabel.TextScaled = true
masteryLabel.Text = "Mastery"
masteryLabel.Parent = Barra1

local Fps = Instance.new("TextLabel")
Fps.Size = UDim2.new(0, 100, 0, 10)
Fps.Position = UDim2.new(0.663, 0, 0.009, 0)
Fps.TextSize = 7
Fps.BackgroundTransparency = 1
Fps.TextColor3 = Color3.fromRGB(255, 255, 255)
Fps.Parent = Barra1

local VS = Instance.new("TextLabel")
VS.Parent = Barra1
VS.Text = "V [1.0]"
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

local tierra = Instance.new("ImageButton", Barra3)
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

local bills = Instance.new("ImageButton", Barra3)
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

local grvd = Instance.new("ImageButton", Barra3)
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

local time = Instance.new("ImageButton", Barra3)
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

local Selct = Instance.new("ScrollingFrame", Barra3)  
Selct.Size = UDim2.new(0, 110, 0, 190)  
Selct.Position = UDim2.new(0.820, 0, 0.165, 0)  
Selct.AnchorPoint = Vector2.new(0.5, 0.5)  
Selct.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
Selct.BorderSizePixel = 0  
Selct.ScrollBarThickness = 5
Selct.ScrollingDirection = Enum.ScrollingDirection.Y  
Selct.CanvasSize = UDim2.new(0, 0, 0, 0)  -- lo actualizaremos después

local forms = {'Beast', 'SSJBUI', 'Ultra Ego', 'LBSSJ4', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 'SSJ Blue', 'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 'Spirit SSJ', 'SSJ2 Majin', 'SSJ2', 'SSJ', 'FSSJ', 'Kaioken'}

local frame = Instance.new("Frame", Selct)  
frame.Size = UDim2.new(1, 0, 0, 0)  -- ancho igual al ScrollingFrame, altura dinámica  
frame.Position = UDim2.new(0, 0, 0, 0)  
frame.BackgroundTransparency = 1  

local list = Instance.new("UIListLayout", frame)  
list.Padding = UDim.new(0, 5)  -- separacion entre botones  
list.SortOrder = Enum.SortOrder.LayoutOrder


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
    {text = "NoTouch", position = UDim2.new(0.520, 0, 0.115, 0), color = Color3.fromRGB(0, 255, 0)},
    {text = "Reb|Stats", position = UDim2.new(0.010, 0, 0.195, 0), color = Color3.fromRGB(0, 255, 255)},
    {text = "MultiRebirth", position = UDim2.new(0.520, 0, 0.195, 0), color = Color3.fromRGB(0, 0, 255)},
    {text = "Atackes1", position = UDim2.new(0.010, 0, 0.270, 0), color = Color3.fromRGB(255, 255, 0)},
    {text = "Atackes2", position = UDim2.new(0.520, 0, 0.270, 0), color = Color3.fromRGB(255, 0, 255)},
    {text = "Jump", position = UDim2.new(0.1, 0, 0.320, 0), color = Color3.fromRGB(200, 200, 200)},
    {text = "Fly", position = UDim2.new(0.653, 0, 0.320, 0), color = Color3.fromRGB(180, 200, 100)},
    {text = "Radar", position = UDim2.new(0.010, 0, 0.420, 0), color = Color3.fromRGB(200, 100, 200)},
    {text = "Security", position = UDim2.new(0.520, 0, 0.420, 0), color = Color3.fromRGB(200, 30, 70)},
    {text = "Requesito", position = UDim2.new(0.010, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},
    {text = "Tp|Planet", position = UDim2.new(0.520, 0, 0.495, 0), color = Color3.fromRGB(100, 200, 100)},
    {text = "Formas|Normal", position = UDim2.new(0.010, 0, 0.570, 0), color = Color3.fromRGB(200, 200, 90)},
    {text = "Formas|Vip", position = UDim2.new(0.520, 0, 0.570, 0), color = Color3.fromRGB(100, 200, 100)},
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

--[Formas]
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
local buttonHeight = 25
for _, form in ipairs(forms) do  
    local btn = Instance.new("TextButton", frame)  
    btn.Size = UDim2.new(0.9, 0, 0, buttonHeight)  
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

local totalHeight = (#forms * (buttonHeight + list.Padding.Offset)) + list.Padding.Offset
frame.Size = UDim2.new(1, 0, 0, totalHeight)
Selct.CanvasSize = UDim2.new(0, 0, 0, totalHeight)


selectedForm = loadForm()  
if selectedForm then  
    for _, btn in ipairs(frame:GetChildren()) do  
        if btn:IsA("TextButton") and btn.Text == selectedForm then  
            btn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)  
            break  
        end  
    end  
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
            addError(errorMsg, 650, "Jump System", "jumpTask", "Jump Control")
        end
        task.wait()
    end
end)
addTask(jumpTask)


local originalSpeed = nil
local flyTask = nil
createBar(0.513, "Fly Speed", Color3.fromRGB(0, 255, 0), 0.37, 200, function(v)
    local success, errorMsg = pcall(function()
        local char = lplr.Character or lplr.CharacterAdded:Wait()
        local humanoid = char:FindFirstChild("Humanoid")
        
        if originalSpeed == nil and humanoid then
            originalSpeed = humanoid.WalkSpeed
        end
        
        if v == 0 then
            flying = false
            if flyTask then
                task.cancel(flyTask)
                flyTask = nil
            end
            if humanoid and originalSpeed then
                humanoid.WalkSpeed = originalSpeed
            end
            return
        end
        
        flying = true
        local speed = originalSpeed * v
        
        flyTask = task.spawn(function()
            while flying do
                pcall(function()
                    local char = lplr.Character
                    local hum = char and char:FindFirstChild("HumanoidRootPart")
                    local humanoid = char and char:FindFirstChild("Humanoid")
                    
                    if hum and humanoid then
                        local moveDir = humanoid.MoveDirection
                        local yDirection = 0
                        
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                        raycastParams.FilterDescendantsInstances = {char}
                        
                        local raycastResult = workspace:Raycast(hum.Position, Vector3.new(0, -1000, 0), raycastParams)
                        local distanceToGround = 0
                        
                        if raycastResult then
                            distanceToGround = hum.Position.Y - raycastResult.Position.Y
                        else
                            distanceToGround = 7000 
                        end
                        
                        if humanoid.WalkSpeed >= originalSpeed * 2 and distanceToGround >= 10 then
                            local verticalSpeed = speed * 1.0
                      
                            if humanoid.Jump then
                                yDirection = verticalSpeed
                            end
                            
                            if moveDir.Y < -0.1 then
                                yDirection = -verticalSpeed
                            end
                            
                            if moveDir.Magnitude > 0 or yDirection ~= 0 then
                                hum.CFrame = hum.CFrame + Vector3.new(
                                    moveDir.X * speed * 2,  
                                    yDirection,             
                                    moveDir.Z * speed * 2   
                                ) * task.wait()
                            end
                        end
                    end
                end)
                task.wait()
            end
        end)       
        addTask(flyTask)
    end)  
    if not success then
        addError(errorMsg, 691, "Fly System", "createBar callback", "Fly Control")
    end
end, "Fly Speed")



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


local sts = {"Strength", "Speed", "Defense", "Energy"}
function yo()
	local min = nil
	for _, statName in ipairs(sts) do
		local stat = data:FindFirstChild(statName)
		if stat and stat:IsA("IntValue") or stat:IsA("NumberValue") then
			if min == nil or stat.Value < min then
				min = stat.Value
			end
		else
			return 0
		end
	end
	return min or 0
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

local lastWasDead = false
function player()
	if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
		if lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart") then
			lastWasDead = false
			return true
		else
			if not lastWasDead then
				data.Quest.Value = ""
				lastWasDead = true
			end
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
function getRebirthRequirement()
    local text = lplr.PlayerGui.Main.MainFrame.Frames.Rebirth.req.Text
    local number, suffix = text:match("([%d%.]+)(%a?)")
    number = tonumber(number)
    if number and suffix ~= "" and multipliers[suffix] then
        return number * multipliers[suffix]
    end
    return number or 0
end

local function formatearStat(txt)
    local etiqueta, base, extra = txt:match("^(.-:%s*)(%d+)%s*%((%+%d+)%)$")
    if etiqueta and base and extra then
        local baseForm = formatNumber(tonumber(base))
        local extraForm = "+" .. formatNumber(tonumber(extra:match("%d+")))
        return etiqueta .. baseForm .. " (" .. extraForm .. ")"
    else
        etiqueta, base = txt:match("^(.-:%s*)(%d+)$")
        if etiqueta and base then
            local baseForm = formatNumber(tonumber(base))
            return etiqueta .. baseForm
        else
            return txt
        end
    end
end

local function getKiPercent(player)
    local character = workspace.Living:FindFirstChild(player.Name)
    if not character then return 0 end
    local ki = character.Stats and character.Stats:FindFirstChild("Ki")
    if not ki then return 0 end
    local currentKi = ki.Value
    local maxKi = ki.MaxValue or 0
    if maxKi == 0 then return 0 end
    return tonumber(string.format("%.2f", (currentKi / maxKi) * 100))
end

local function vidaPercent(player)
    local character = workspace.Living:FindFirstChild(player.Name)
    if not character then return 0 end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return 0 end    
    local currentHealth = humanoid.Health
    local maxHealth = humanoid.MaxHealth
    if maxHealth == 0 then return 0 end
    local percent = (currentHealth / maxHealth) * 100
    return tonumber(string.format("%.2f", percent))
end


--SCRIPTS PARA PROTEGER EN [Vips]
--Script 1 \/ Para Pausar Los Bucles 
local lplr = game.Players.LocalPlayer
local estadoCongela = false

function Congela()
    return estadoCongela
end
if #game.Players:GetPlayers() == 1 and getIsActive8() then
    task.spawn(function()
        while true do
            pcall(function()
                local players = game.Players:GetPlayers()
                if #players == 1 and players[1] == lplr then
                    estadoCongela = true
                else
                    estadoCongela = false
                end
            end)
            task.wait(.7)
        end
    end)
else
    if getIsActive8() and #game.Players:GetPlayers() > 1 then
        estadoCongela = true 
        elseif not getIsActive8() then
        estadoCongela = true 
    end
end--Script 1 \/ Para Pausar Los Bucles 

--Script 2 \/ Tp ah wiis
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer

local coordenadas = {
    Vector3.new(5054.7, 1288.8, -6006.0),
    Vector3.new(5056.3, 1288.5, -5994.1),
    Vector3.new(5019.3, 1288.8, -6005.7),
    Vector3.new(5041.5, 1288.8, -6008.1),
    Vector3.new(5041.7, 1288.8, -5996.1),
}

local function elegirCoordenada()
    return coordenadas[math.random(#coordenadas)]
end

local function enZona(val)
    local pos = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character.HumanoidRootPart.Position
    if not pos then return false end
    for _, zona in ipairs(coordenadas) do
        if (pos - zona).Magnitude <= val then
            return true
        end
    end
    return false
end

local function teletransportar()
    local char = lplr.Character or lplr.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local pos = elegirCoordenada()
    hrp.CFrame = CFrame.new(pos)
end

if #Players:GetPlayers() == 1 and getIsActive8() then
    Players.PlayerAdded:Connect(function(p)
        if p ~= lplr then
            teletransportar()
            task.spawn(function()
                while true do            
                    task.wait()
                    if not enZona(70) then
                        teletransportar()
                    else
                        break
                    end
                end
            end)
        end 
    end)
end--Script 2 \/ Tp ah wiis


--Script 3 \/ Duplicar server
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer

if #Players:GetPlayers() == 1 and getIsActive8() then
task.spawn(function()
    local tpHecho = false
    while not tpHecho do
        pcall(function()
            local char = lplr.Character or lplr.CharacterAdded:Wait()
            if #Players:GetPlayers() > 1 and getIsActive8() then
                local destino = (game.PlaceId == 5151400895) and "Vills Planet" or "Earth"
                game:GetService("ReplicatedStorage").Package.Events.TP:InvokeServer(destino)
                tpHecho = true
             end
          end)
           task.wait(.5)
      end
   end)
end--FIN DE LA PROTECION SCRIPTS

--Aki incio del regitro 
local mainTask = task.spawn(function()
    local success, errorMsg = pcall(function()
    
    
    
               
local task1 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive1() then
                        if getIsActive1() and player() and Congela() then 
				local player = workspace.Living:FindFirstChild(lplr.Name)
				if player then
					local ki = player.Stats.Ki
					local maxKi = ki.MaxValue
					local currentKi = ki.Value
					local transform = lplr.Status.Transformation.Value
					if transform ~= "None" then
						if currentKi <= maxKi * 0.70 then
							game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
						end
					else
						if currentKi <= maxKi * 0.15 then
							game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
						end
					end
				end
			end
			task.spawn(function()--Incio
				repeat task.wait() until workspace.Living:FindFirstChild(lplr.Name)
				local player = workspace.Living:FindFirstChild(lplr.Name)
				local ki = player.Stats.Ki
				ki:GetPropertyChangedSignal("Value"):Connect(function()
					pcall(function()
					if lplr.Status.Transformation.Value ~= "None" then   
						local maxKi = ki.MaxValue
						local currentKi = ki.Value
						if currentKi <= maxKi * 0.70 then			
							game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
						end			
						end
					end)
				end)
			end)--Fin
                    end
                end)
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 1", "task1", "Farm Switch")
                end
            end
        end)
addTask(task1)
        
                              
local task1 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive1() then
                        if player() then
                               lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                       end --player() 
                    end                    
                end)               
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 1", "task1", "lplr.Character.HumanoidRootPart.Velocity")
                end
            end
        end)
addTask(task1)         
      
        
local task1 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive1() then
                        if player() and Congela() then           
            if game.Players.LocalPlayer.Status.Blocking.Value == false and getIsActive1() then
                    game.Players.LocalPlayer.Status.Blocking.Value = true               
             end                                                    
            pcall(function()
            task.spawn(function()
            if player() and game.PlaceId == 3311165597 and getIsActive1() then
                 if data.Quest.Value ~= "X Fighter Trainer" and yo() <= 30000 then
                 local npc = workspace.Others.NPCs["X Fighter Trainer"]
                    lplr.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
                       local args = {
                          [1] = npc }
                   game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(unpack(args))        
             elseif data.Quest.Value == "X Fighter Trainer" then
                  for _, boss in ipairs(workspace.Living:GetChildren()) do
             if boss.Name == "X Fighter" and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                 lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
                   game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27", 1)
                   game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27", 2) 
                           break
                             end
                          end
                       end 
                    end--if fin if game.PlaceId == 3311165597 then                
                 end)
              end)
           end
                    end
                end)               
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 1", "task1", "Block")
                end
            end
        end)
        addTask(task1)
       
        
local npcList = {	
    {"Nohag (Beast)", 25.975e9, true},
    {"Vegetable (Ultra Ego)", 20.975e9, true},
	{"Wukong (MUI)", 15.975e9, true},
    {"Vekuta (SSJBUI)", 6.375e9, true},
    {"Wukong Rose", 4.65e9, true},
    {"Vekuta (LBSSJ4)", 3.05e9, true},
    {"Wukong (LBSSJ4)", 2e9, true},
    {"Vegetable (LBSSJ4)", 950e6, true},
    {"Vis (20%)", 700e6, true},
    {"Vills (50%)", 450e6, true},
    {"Wukong (Omen)", 250e6, true},
    {"Vegetable (GoD in-training)", 150e6, true},
    {"SSJG Kakata", 130e6, true},
    {"Broccoli", 45.5e6, true},
    {"SSJB Wukong", 6e6, true},
    {"Kai-fist Master", 3725000, true},
    {"SSJ2 Wukong", 2950000, true},
    {"Perfect Atom", 2075000, true},
    {"Chilly", 1550000, true},
    {"Super Vegetable", 758000, true},
    {"Mapa", 498000, true},
    {"Radish", 105000, true},
    {"Kid Nohag", 70000, true},
    {"Klirin", 30000, true}
}        
local task1 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive1() then
                        if Congela() then
					if game.PlaceId ~= 3311165597 or lplr.Status.Transformation.Value ~= "None" then   
					if getIsActive1() and player()  then
               if data.Quest.Value ~= "" then
                        local currentQuest = data.Quest.Value
                        local playerStats = yo()
                        for _, npc in ipairs(npcList) do
                            if npc[1] == currentQuest and playerStats < npc[2] then
                                data.Quest.Value = ""
                                break
                            end
                        end
                    end
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
           end
                    end
                end)               
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 1", "task1", "AutoFarm")
                end
            end
        end)
addTask(task1)
        
        
 --Equip Meles [Atakes]--Inicio
local habilidades = {
    { name = "Wolf Fang Fist", requerimiento = 5000 },
    { name = "Meteor Crash", requerimiento = 40000 },
    { name = "High Power Rush", requerimiento = 100000 },
    { name = "Mach Kick", requerimiento = 125000 },
    { name = "Super Dragon Fist", requerimiento = 125000 },
    { name = "Flash Kick", requerimiento = 200000 },
    { name = "Spirit Breaking Cannon", requerimiento = 500000 },
    { name = "Spirit Barrage", requerimiento = 60e6 },
    { name = "God Slicer", requerimiento = 60e6 },
}

local equipadas = {}
local function equipToolByName(toolName)
    task.spawn(function()
    pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Package"):WaitForChild("Events"):WaitForChild("equipskill"):InvokeServer(toolName)
        end)
    end)
end

local function getModule(tool)
    if tool and tool:FindFirstChildWhichIsA("ModuleScript") then
        return require(tool:FindFirstChildWhichIsA("ModuleScript"))
    end
    return nil
end

local function activateToolModule(tool)
    local module = getModule(tool)
    if module and type(module.Activate) == "function" then
        module.Activate(lplr, nil, tool.Name)
    end
end

local function isInHabilidades(toolName)
    for _, info in ipairs(habilidades) do
        if info.name == toolName then
            return true
        end
    end
    return false
end

task.spawn(function()
    while true do
        pcall(function()
            if data.Quest.Value ~= "" and player() and getIsActive5() and not getIsActive6() then
                if lplr.Status.Transformation.Value ~= "None" then   
                    task.spawn(function()
                        local activados = 0
                        for _, tool in ipairs(lplr:WaitForChild("Backpack"):GetChildren()) do
                            if tool:IsA("Tool") then
                                if not isInHabilidades(tool.Name) then
                                    tool:Destroy()
                                elseif activados < 4 then
                                    activateToolModule(tool)
                                    activados += 1
                                end
                            end
                        end
                        game.ReplicatedStorage.Package.Events.voleys:InvokeServer("Energy Volley", {FaceMouse = false, MouseHit = CFrame.new()}, "Blacknwhite27")
                    end)
                end
            end
        end)
        task.wait()
    end
end)

task.spawn(function()
    while true do
        pcall(function()                      
            game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
        end)
        task.wait(1)
    end
end)

task.spawn(function()
    while true do
        pcall(function()
if player() and getIsActive5() and not getIsActive6() then 
            local stats = yo()
            for _, info in ipairs(habilidades) do
                if stats >= info.requerimiento and not equipadas[info.name] then
                    equipToolByName(info.name)
                    equipadas[info.name] = true
                end
            end
            end
        end)
        task.wait(.5)
    end
end)
--Meles [Atakes] --Fin

--Equip Meles [Atakes1]--Inicio
canvolley = true        
local Actakes2 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                 if player() and Congela() then          
                 if lplr.Status.Transformation.Value ~= "None" then   
        if (yo() >= 5000 and data.Quest.Value ~= ""  and getIsActive6() and not getIsActive5()) then                                                     
                    local stats = yo()
                    local moves = {}
                    local attacked = false                                                     
                                            
                        if stats >= 5000 then table.insert(moves, "Wolf Fang Fist") end
                        if stats >= 40000 then table.insert(moves, "Meteor Crash") end
                        if stats >= 100000 then table.insert(moves, "High Power Rush") end
                        if stats >= 125000 then table.insert(moves, "Mach Kick") end                   
                       if stats >= 60e6 then
                        if data.Allignment.Value == "Good" then
                            table.insert(moves, "Spirit Barrage")
                        else
                            table.insert(moves, "God Slicer")
                        end
                    end                      
                    for i, move in pairs(moves) do
                        if not lplr.Status:FindFirstChild(move) then
                            spawn(function()                           
                                 if game.PlaceId == 3311165597 then 
                               game:GetService("ReplicatedStorage").Package.Events.letsplayagame:InvokeServer(move, "Blacknwhite27")                                           
                                elseif game.PlaceId ~= 3311165597 then
                                game:GetService("ReplicatedStorage").Package.Events.b.Dece:InvokeServer(move, "Blacknwhite27")               
                                 end                                                    
                            end)
                            attacked = true
                        end
                    end
                    if stats > 5000 and canvolley then
                        canvolley = false
                           game.ReplicatedStorage.Package.Events.voleys:InvokeServer("Energy Volley", {FaceMouse = false, MouseHit = CFrame.new()}, "Blacknwhite27")
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
        if not success then
                    addError(errorMsg, debug.info(1, "l"), "Error:", "Actakes2", "Actakes2")
                end
            end
        end)
addTask(Actakes2)

--Meles [Atakes1] --Fin        
        
local task2 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive2() then
                        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
						for _, v in pairs(char:GetDescendants()) do
							if v:IsA("BasePart") then
								v.CanCollide = false
							end
						end
                    end
                    if player() and data.Quest.Value ~= "" and getIsActive1() and Congela() then         
		           game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27", 1)
		           game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27", 2)
                           end 
                end)               
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 2", "task2", "Puch,NoTouch")
                end
            end
        end)
addTask(task2)
        
local task3 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive3() then
                       	local fuerzaActual = yo()
							local rebirthReq = getRebirthRequirement()
							if getIsActive3() and player() and Congela() then
								if fuerzaActual >= rebirthReq and fuerzaActual < rebirthReq * 2 then
				                game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
								end
							end
                    end
                end)             
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 3", "task3", "Rebirth Normal")
                end
            end
        end)
addTask(task3)
        
        
local task4 = task.spawn(function()
            while task.wait(.5) do
                local success, errorMsg = pcall(function()
                    if getIsActive4() and MarketplaceService:UserOwnsGamePassAsync(lplr.UserId, 1167830866) then        
                           game:GetService("ReplicatedStorage").Package.Events.Multireb:InvokeServer()      
                      elseif getIsActive4() and data.Zeni.Value >= 400000 then
                      game:GetService("ReplicatedStorage").Package.Events.Multireb:InvokeServer()
                   end
                end)             
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 4", "task4", "Milti|Rebirth")
                end
            end
        end)
addTask(task4)
                        
        
local task10 = task.spawn(function()
            while task.wait(.5) do
                local success, errorMsg = pcall(function()
                    if getIsActive10() then
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
                    end
                end)             
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 10", "task10", "Tp|Planet")
                end
            end
        end)
addTask(task10)
        
        
local task11 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive11() then
                    if getIsActive11() and player() and Congela() then
		                local Forms = {
		            	'Pure Astral',
                        'Corrupt Astral',
		                'Beast',
					    'SSJBUI',
					    'Ultra Ego',
					    'LBSSJ4',
					    'SSJR3',
					    'SSJB3',
					    'God Of Destruction',
					    'God Of Creation',
					    'Jiren Ultra Instinct',
					    'Mastered Ultra Instinct',
					    'Godly SSJ2',
					    'Ultra Instinct Omen',
					    'Evil SSJ',
					    'Blue Evolution',
					    'Dark Rose',
					    'Kefla SSJ2',
					    'SSJ Berserker',
					    'True Rose',
					    'SSJB Kaioken',
					    'SSJ Rose',
					    'SSJ Blue',
					    'Corrupt SSJ',
					    'SSJ Rage',
					    'SSJG',
					    'SSJ4',
					    'Mystic',
					    'LSSJ',
					    'SSJ3',
					    'Spirit SSJ',
					    'SSJ2 Majin',
					    'SSJ2',
					    'SSJ',
					    'FSSJ',
					    'Kaioken'
		                }
              local status = lplr.Status    
                  for _, form in ipairs(Forms) do 
                   if Ex.equipskill:InvokeServer(form) then break end  
             end
        if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
            if game.PlaceId == 3311165597 then
            game.ReplicatedStorage.Package.Events.Higoober:InvokeServer()
            elseif game.PlaceId ~= 3311165597 then 
            game:GetService("ReplicatedStorage").Package.Events.a.Cece:InvokeServer()
                               end 
                           end                
                        end                               
                    end
                    if not getIsActive11() and not getIsActive12()  and selectedForm and not transforming and lplr.Status.Transformation.Value ~= selectedForm  then
                  transforming = true
                    pcall(function()
           if Ex.equipskill:InvokeServer(selectedForm) then
            if game.PlaceId == 3311165597 then
            game.ReplicatedStorage.Package.Events.Higoober:InvokeServer()
            elseif game.PlaceId ~= 3311165597 then 
            game:GetService("ReplicatedStorage").Package.Events.a.Cece:InvokeServer()
                       end 
                    end
                  end)
                transforming = false
                    end
                end)             
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 11", "task11", "Form|Normal")
                end
            end
        end)
addTask(task11)


local task12 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive12() then
                       if getIsActive12() and not getIsActive11()  and player() and Congela() then
					        local Forms = {                                                           
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
		        if game.PlaceId == 3311165597 then
		            game.ReplicatedStorage.Package.Events.Higoober:InvokeServer()
		            elseif game.PlaceId ~= 3311165597 then 
		            game:GetService("ReplicatedStorage").Package.Events.a.Cece:InvokeServer()
		                    end 
		                 end                
		               end      
                    end
                end)             
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 12", "task12", "Form|Vip")
                end
            end
        end)
addTask(task12)

local task12 = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive12() then
                       if getIsActive12() and not getIsActive11()  and player() and Congela() then
					        local Forms = {                                                           
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
		        if game.PlaceId == 3311165597 then
		            game.ReplicatedStorage.Package.Events.Higoober:InvokeServer()
		            elseif game.PlaceId ~= 3311165597 then 
		            game:GetService("ReplicatedStorage").Package.Events.a.Cece:InvokeServer()
		                    end 
		                 end                
		               end      
                    end
                end)             
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Task 12", "task12", "Form|Vip")
                end
            end
        end)
addTask(task12)

local Radar = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
                    if getIsActive7() then                   
local function createBillboard(player)
    if player == Gto then return end
    local char = workspace.Living:FindFirstChild(player.Name)
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    if head:FindFirstChild("StatsBillboard") then
        head.StatsBillboard:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "StatsBillboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 400, 0, 35)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextScaled = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = billboard

    local data = dataFolder:FindFirstChild(tostring(player.UserId))
    local strengthVal = 0
    local rebirthVal = 0
    if data then
        local strength = data:FindFirstChild("Strength") or data:FindFirstChild("sts")
        local rebirth = data:FindFirstChild("Rebirth")
        strengthVal = strength and strength.Value or 0
        rebirthVal = rebirth and rebirth.Value or 0
    end

    local function updateText()
        local name = player.Name
        local apodo = player.DisplayName or player.Name
        local Ki = getKiPercent(player)
        local Vida = vidaPercent(player)
        textLabel.Text = string.format("%s (%s) / F:%s / R:%s / Ki:%d / Vida:%d", name, apodo, formatNumber(strengthVal), formatNumber(rebirthVal), Ki, Vida)
    end

local function getPlayerStatsString(player)
    local data = dataFolder:FindFirstChild(tostring(player.UserId))
    local strengthVal = 0
    local rebirthVal = 0
    if data then
        local strength = data:FindFirstChild("Strength") or data:FindFirstChild("sts")
        local rebirth = data:FindFirstChild("Rebirth")
        strengthVal = strength and strength.Value or 0
        rebirthVal = rebirth and rebirth.Value or 0
    end

    local name = player.Name
    local apodo = player.DisplayName or player.Name
    local Ki = getKiPercent(player)
    local Vida = vidaPercent(player)
    local statsText = string.format("%s (%s) / F:%s / R:%s / Ki:%d / Vida:%d", name, apodo, formatNumber(strengthVal), formatNumber(rebirthVal), Ki, Vida)
    return statsText
end

local function setupClickDetectorsForCharacter(character)
    if not character then return end
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            if not part:FindFirstChildOfClass("ClickDetector") then
                local clickDetector = Instance.new("ClickDetector")
                clickDetector.MaxActivationDistance = 40
                clickDetector.Parent = part

                clickDetector.MouseClick:Connect(function(clickingPlayer)
                    if clickingPlayer == game.Players.LocalPlayer then
                        local player = game.Players:GetPlayerFromCharacter(character)
                        if player then
                            local statsText = getPlayerStatsString(player)
                            if setclipboard then
                                setclipboard(statsText)
                                print("Datos copiados:\n" .. statsText)
                            else
                                print("No se pudo copiar, aquí están los datos:\n" .. statsText)
                            end
                        end
                    end
                end)
            end
        end
    end
end

for _, player in pairs(Players:GetPlayers()) do
    if player.Character then
        setupClickDetectorsForCharacter(player.Character)
    end
    player.CharacterAdded:Connect(function(char)
        wait(1)
        setupClickDetectorsForCharacter(char)
    end)
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        wait(1)
        setupClickDetectorsForCharacter(char)
    end)
end)


    updateText()

    spawn(function()
        while billboard.Parent do
            updateText()
            local dist = (head.Position - cam.CFrame.Position).Magnitude
            local scale = math.clamp(1.3 - (dist / 50), 0.7, 1.3)
            textLabel.TextScaled = false
            textLabel.TextSize = 14 * scale
            local living = workspace:WaitForChild("Living") 
				for _, character in pairs(living:GetChildren()) do
				    local humanoid = character:FindFirstChildOfClass("Humanoid")
				    if humanoid then
				        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
				    end
				end
            wait(0.1)
        end
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function()
        wait(1)
        createBillboard(player)
    end)
    if player.Character then
        createBillboard(player)
    end
end

Players.PlayerRemoving:Connect(function(player)
    local char = workspace.Living:FindFirstChild(player.Name)
    if char then
        local head = char:FindFirstChild("Head")
        if head then
            local bb = head:FindFirstChild("StatsBillboard")
            if bb then
                bb:Destroy()
            end
        end
    end
end)
                    end
                end)             
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Switch Lector", "Radar", "Lector/Radar")
                end
            end
        end)
addTask(Radar)


local Formato = task.spawn(function()
            while task.wait() do
                local success, errorMsg = pcall(function()
        local MainFrame = lplr.PlayerGui:WaitForChild("Main"):WaitForChild("MainFrame")
        local ZeniLabel = MainFrame.Indicator:FindFirstChild("Zeni")
        local Bars = MainFrame:WaitForChild("Bars")
        local HPText = Bars.Health:FindFirstChild("TextLabel")
        local EnergyText = Bars.Energy:FindFirstChild("TextLabel")
        local statsFolder = lplr.PlayerGui.Main.MainFrame.Frames.Stats
        local health = lplr.Character and lplr.Character:FindFirstChild("Humanoid") and lplr.Character.Humanoid.Health or 0
        local maxHealth = lplr.Character and lplr.Character:FindFirstChild("Humanoid") and lplr.Character.Humanoid.MaxHealth or 0
        local ki = lplr.Character and lplr.Character:FindFirstChild("Stats") and lplr.Character.Stats.Ki.Value or 0
        local maxKi = lplr.Character and lplr.Character:FindFirstChild("Stats") and lplr.Character.Stats.Ki.MaxValue or 0
        
            HPText.Text = "SALUD: " .. formatNumber(health) .. " / " .. formatNumber(maxHealth)

            EnergyText.Text = "ENERGÍA: " .. formatNumber(ki) .. " / " .. formatNumber(maxKi)
        
            ZeniLabel.Text = formatNumber(data.Zeni.Value) .. " Zeni"


        local statsToFormat = {
		    "Energy",
		    "Speed",
		    "Defense",
		    "Strength" }
        for _, statName in ipairs(statsToFormat) do
            local statLabel = statsFolder:FindFirstChild(statName)
            if statLabel and statLabel:IsA("TextLabel") then
                local originalText = statLabel.Text
                statLabel.Text = formatearStat(originalText)
            end
        end
    end)             
    if not success then
        addError(errorMsg, debug.info(1, "l"), "Switch Formato", "Formato", "Formato/Frames")
    end
 end
end)
addTask(Formato)
    
        
      
local Datos = task.spawn(function()
            while wait(1) do
                local success, errorMsg = pcall(function()
                    if player() then
                        local serverPing = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() * 1.5)                       
                        serverPingLabel.Text = "Serv: " .. serverPing .. " ms"
                        
                        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
                        pingLabel.Text = "Ping: " .. (ping < 1000 and ping or math.floor(ping / 10) * 10) .. " ms"
                        
                        local cpuUsage = math.floor(Stats.PerformanceStats.CPU:GetValue() * 100)
                        cpuLabel.Text = "CPU: " .. cpuUsage .. "%"
                        
                        
                        local fpsValue = math.floor(Stats.Workspace["Heartbeat"]:GetValue())
                        Fps.Text = "FPS: " .. tostring(fpsValue)
                        
                           local Rebirthvalue = data.Rebirth.Value
                        Exp.Text = "Reb: " .. tostring(Rebirthvalue)
                        
                                                
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
                if not success then
                    addError(errorMsg, debug.info(1, "l"), "Stats System", "statsTask", "Datos(Sytema)")
                end
            end
        end)
addTask(Datos)

        
          
       
        
        local antiAfkTask1 = task.spawn(function()
            local success, errorMsg = pcall(function()
                local vu = game:GetService("VirtualUser")
                game:GetService("Players").LocalPlayer.Idled:Connect(function()
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new())
                    task.wait(2)
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


--REQUISITOS LEER
local npcList = {
	{"Klirin", 30000, true},
	{"Kid Nohag", 70000, true},
	{"Radish", 105000, true},
	{"Mapa", 498000, true},
	{"Super Vegetable", 758000, true},
	{"Chilly", 1550000, true},
	{"Perfect Atom", 2075000, true},
	{"SSJ2 Wukong", 2950000, true},
	{"Kai-fist Master", 3725000, true},
	{"SSJB Wukong", 6e6, true},
	{"Broccoli", 45.5e6, true},
	{"SSJG Kakata", 130e6, true},
	{"Vegetable (GoD in-training)", 150e6, true},
	{"Wukong (Omen)", 250e6, true},
	{"Vills (50%)", 450e6, true},
	{"Vis (20%)", 700e6, true},
	{"Vegetable (LBSSJ4)", 950e6, true},
	{"Wukong (LBSSJ4)", 2e9, true},
	{"Vekuta (LBSSJ4)", 3.05e9, true},
	{"Wukong Rose", 4.65e9, true},
	{"Vekuta (SSJBUI)", 6.375e9, true},
	{"Wukong (MUI)", 15.975e9, true},
	{"Nohag (Beast)", 25.975e9, true},
    {"Vegetable (Ultra Ego)", 20.975e9, true},
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
screenGui.ResetOnSpawn = false 
screenGui.DisplayOrder = 999 
screenGui.Parent =  lplr:WaitForChild("PlayerGui")

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

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.DisplayOrder = 999 
gui.Parent = lplr:WaitForChild("PlayerGui")

local txt = Instance.new("TextLabel")
txt.Size = UDim2.new(0, 600, 0, 100)
txt.Position = UDim2.new(0.5, -300, 0.5, -50)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.fromRGB(255, 0, 0)
txt.TextStrokeTransparency = 0
txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 255)
txt.Font = Enum.Font.Arcade
txt.TextSize = 45
txt.Text = "Activar [Form|Normal] o [Form|Vip]"
txt.Visible = false
txt.Parent = gui

task.spawn(function()
    while true do
        pcall(function()
            local s11, a11 = pcall(getIsActive11)
            local s12, a12 = pcall(getIsActive12)
            local s1, a1 = pcall(getIsActive1)
            local tieneForma = (lplr.Status.Transformation.Value == selectedForm and selectedForm ~= nil and selectedForm ~= "")
            if s11 and s12 and s1 then
                txt.Visible = (a11 == false and a12 == false and a1 == true and not tieneForma)
            else
                txt.Visible = false
            end
        end)
        task.wait(.5)
    end
end)

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