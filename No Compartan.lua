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
local EnhancedAutoFarmGUI = game.CoreGui:FindFirstChild("EnhancedAutoFarmGUI")
if EnhancedAutoFarmGUI then
    return  
end

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local lplr = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local folderName = "Missiones"
local fileName = folderName .. "/Estados.txt"
local lplr = game.Players.LocalPlayer
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)
local Ex = game:GetService("ReplicatedStorage").Package.Events


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EnhancedAutoFarmGUI"
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 30)
mainFrame.Position = UDim2.new(0.5, -100, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Parent = screenGui
local mainCorner = Instance.new("UICorner") mainCorner.CornerRadius = UDim.new(0, 20) mainCorner.Parent = mainFrame
local mainStroke = Instance.new("UIStroke") mainStroke.Color = Color3.new(1, 0, 1) mainStroke.Thickness = 1 mainStroke.Parent = mainFrame
local mainShadow = Instance.new("ImageLabel") mainShadow.Image = "rbxassetid://1316045217" mainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0) mainShadow.ImageTransparency = 0.5 mainShadow.Size = UDim2.new(1, 40, 1, 40) mainShadow.Position = UDim2.new(0, -20, 0, -20) mainShadow.BackgroundTransparency = 1 mainShadow.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.8, 0, 0, 30) 
titleLabel.Position = UDim2.new(0.1, 0, 0, 0) 
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.Text = "DBU" 
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = mainFrame

local minMaxButton = Instance.new("TextButton")
minMaxButton.Size = UDim2.new(0, 25, 0, 25)
minMaxButton.Position = UDim2.new(1, -30, 0, 2) 
minMaxButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
minMaxButton.TextColor3 = Color3.fromRGB(0, 0, 0)
minMaxButton.Text = "+" 
minMaxButton.Font = Enum.Font.GothamBold
minMaxButton.TextScaled = true
minMaxButton.Parent = mainFrame
local minMaxCorner = Instance.new("UICorner") minMaxCorner.CornerRadius = UDim.new(0, 12) minMaxCorner.Parent = minMaxButton

local isMinimized = true
local originalSize = UDim2.new(0, 450, 0, 350)
local originalPosition = UDim2.new(0.5, -225, 0.5, -175)

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -20, 0, 50)
tabFrame.Position = UDim2.new(0, 10, 0, 60)
tabFrame.BackgroundTransparency = 1
tabFrame.Visible = false
tabFrame.Parent = mainFrame

local tabs = {"Farm", "Teleport", "Extras"}
local currentTab = "Farm"
local tabButtons = {}

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.3, 0, 0, 40)
    tabButton.Position = UDim2.new((i-1) * 0.33, 5, 0, 0)
    tabButton.BackgroundColor3 = tabName == currentTab and Color3.fromRGB(0, 200, 255) or Color3.fromRGB(40, 40, 70)
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.TextScaled = true
    tabButton.Font = Enum.Font.GothamBold
    tabButton.Text = tabName
    tabButton.Parent = tabFrame
    local tabCorner = Instance.new("UICorner") tabCorner.CornerRadius = UDim.new(0, 10) tabCorner.Parent = tabButton
    local tabStroke = Instance.new("UIStroke") tabStroke.Color = Color3.fromRGB(0, 255, 220) tabStroke.Thickness = 1 tabStroke.Parent = tabButton
    tabButtons[tabName] = tabButton
end

local contentFrames = {}
local toggleStates = {}
local lastSaveTime = 0
local saveCooldown = 2

local function saveToggleStates()
    local currentTime = tick()
    if currentTime - lastSaveTime < saveCooldown then
        return
    end
    lastSaveTime = currentTime
    local data = {}
    for name, getState in pairs(toggleStates) do
        data[name] = getState()
    end
    local success, err = pcall(function()
        if not isfolder(folderName) then
            makefolder(folderName)
        end
        writefile(fileName, HttpService:JSONEncode(data))
    end)
    if not success then warn("Failed to save toggle states: " .. err) end
end

local function loadToggleStates()
    local success, data = pcall(function()
        if isfile(fileName) then
            return HttpService:JSONDecode(readfile(fileName))
        end
        return {}
    end)
    return success and data or {}
end

local function createToggle(name, posY, defaultState, parent)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.9, 0, 0, 40)
    toggleFrame.Position = UDim2.new(0, 0, 0, posY * 45)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    toggleLabel.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
    toggleLabel.TextStrokeTransparency = 0
    toggleLabel.TextScaled = true
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.Text = name
    toggleLabel.Parent = toggleFrame

    local colors = {
        Color3.fromRGB(0, 255, 255),
        Color3.fromRGB(255, 255, 0),
        Color3.fromRGB(255, 0, 255)
    }

    local initialColorIndex = (posY % 3) + 1
    toggleLabel.TextStrokeColor3 = colors[initialColorIndex]

    spawn(function()
        while toggleLabel and toggleLabel.Parent and toggleLabel.Parent.Parent.Visible do
            for i = 1, #colors do
                TweenService:Create(toggleLabel, TweenInfo.new(0.5), {TextStrokeColor3 = colors[i]}):Play()
                task.wait(2)
            end
        end
    end)

    local switchBase = Instance.new("Frame")
    switchBase.Size = UDim2.new(0.15, 0, 0, 25)
    switchBase.Position = UDim2.new(0.75, 0, 0.5, -12.5)
    switchBase.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    switchBase.BorderSizePixel = 0
    switchBase.Parent = toggleFrame
    local switchCorner = Instance.new("UICorner") switchCorner.CornerRadius = UDim.new(0, 12) switchCorner.Parent = switchBase
    local switchStroke = Instance.new("UIStroke") 
    switchStroke.Color = Color3.fromRGB(0, 220, 255)
    switchStroke.Thickness = 1 
    switchStroke.Parent = switchBase

    local switchKnob = Instance.new("Frame")
    switchKnob.Size = UDim2.new(0, 20, 0, 20)
    switchKnob.Position = defaultState and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    switchKnob.BackgroundColor3 = defaultState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
    switchKnob.BorderSizePixel = 0
    switchKnob.Parent = switchBase
    local knobCorner = Instance.new("UICorner") knobCorner.CornerRadius = UDim.new(0, 10) knobCorner.Parent = switchKnob

    local state = defaultState
    local clickDetector = Instance.new("TextButton")
    clickDetector.Size = UDim2.new(1, 0, 1, 0)
    clickDetector.BackgroundTransparency = 1
    clickDetector.Text = ""
    clickDetector.Parent = switchBase

    clickDetector.MouseButton1Click:Connect(function()
        state = not state
        local newPos = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        local newColor = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
        TweenService:Create(switchKnob, TweenInfo.new(0.2), {Position = newPos, BackgroundColor3 = newColor}):Play()
        saveToggleStates()
    end)

    toggleStates[name] = function() return state end
    return toggleStates[name]
end

local savedStates = loadToggleStates()

local farmFrame = Instance.new("Frame")
farmFrame.Size = UDim2.new(1, -20, 0, 230)
farmFrame.Position = UDim2.new(0, 10, 0, 110)
farmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 55)
farmFrame.BorderSizePixel = 0
farmFrame.Parent = mainFrame
local farmCorner = Instance.new("UICorner") farmCorner.CornerRadius = UDim.new(0, 15) farmCorner.Parent = farmFrame
local farmStroke = Instance.new("UIStroke") farmStroke.Color = Color3.fromRGB(0, 220, 255) farmStroke.Thickness = 2 farmStroke.Parent = farmFrame
contentFrames["Farm"] = farmFrame

local farmScroll = Instance.new("ScrollingFrame")
farmScroll.Size = UDim2.new(1, -10, 1, -10)
farmScroll.Position = UDim2.new(0, 5, 0, 5)
farmScroll.BackgroundTransparency = 1
farmScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
farmScroll.ScrollBarThickness = 5
farmScroll.Parent = farmFrame

local AutoFarm = createToggle("Auto Farm", 0, savedStates["Auto Farm"] or false, farmScroll)
local AutoForm = createToggle("Auto Form", 1, savedStates["Auto Form"] or false, farmScroll)
local FormVip = createToggle("Form|Vip", 2, savedStates["Form|Vip"] or false, farmScroll)
local Planet = createToggle("Tp|Planet", 3, savedStates["Tp|Planet"] or false, farmScroll)
local RbStats = createToggle("Reb|Stats", 4, savedStates["Reb|Stats"] or false, farmScroll)
local Dupli = createToggle("Rest|Server", 5, savedStates["Rest|Server"] or false, farmScroll)
local Ozaru = createToggle("Ozaru", 6, savedStates["Ozaru"] or false, farmScroll)
local GokuBlack = createToggle("GokuBlack", 7, savedStates["GokuBlack"] or false, farmScroll)

local teleportFrame = Instance.new("Frame")
teleportFrame.Size = UDim2.new(1, -20, 0, 230)
teleportFrame.Position = UDim2.new(0, 10, 0, 110)
teleportFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 55)
teleportFrame.BorderSizePixel = 0
teleportFrame.Parent = mainFrame
teleportFrame.Visible = false
local teleportCorner = Instance.new("UICorner") teleportCorner.CornerRadius = UDim.new(0, 15) teleportCorner.Parent = teleportFrame
local teleportStroke = Instance.new("UIStroke") teleportStroke.Color = Color3.fromRGB(0, 220, 255) teleportStroke.Thickness = 2 teleportStroke.Parent = teleportFrame
contentFrames["Teleport"] = teleportFrame

local teleportScroll = Instance.new("ScrollingFrame")
teleportScroll.Size = UDim2.new(1, -10, 1, -10)
teleportScroll.Position = UDim2.new(0, 5, 0, 5)
teleportScroll.BackgroundTransparency = 1
teleportScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
teleportScroll.ScrollBarThickness = 5
teleportScroll.Parent = teleportFrame

local Calculo1 = createToggle("Lector|Calculador", 0, savedStates["Lector|Calculador"] or false, teleportScroll)

local tpPos = Instance.new("TextButton")
tpPos.Size = UDim2.new(0.9, 0, 0, 40)
tpPos.Position = UDim2.new(0, 0, 0, 90)
tpPos.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
tpPos.TextColor3 = Color3.fromRGB(255, 255, 255)
tpPos.TextScaled = true
tpPos.Font = Enum.Font.GothamBold
tpPos.Text = "TP Ciudad Vis"
tpPos.Parent = teleportScroll
local tpPosCorner = Instance.new("UICorner") tpPosCorner.CornerRadius = UDim.new(0, 10) tpPosCorner.Parent = tpPos
local tpPosStroke = Instance.new("UIStroke") tpPosStroke.Color = Color3.fromRGB(0, 120, 200) tpPosStroke.Thickness = 1.5 tpPosStroke.Parent = tpPos

local extrasFrame = Instance.new("Frame")
extrasFrame.Size = UDim2.new(1, -20, 0, 230)
extrasFrame.Position = UDim2.new(0, 10, 0, 110)
extrasFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 55)
extrasFrame.BorderSizePixel = 0
extrasFrame.Parent = mainFrame
extrasFrame.Visible = false
local extrasCorner = Instance.new("UICorner") extrasCorner.CornerRadius = UDim.new(0, 15) extrasCorner.Parent = extrasFrame
local extrasStroke = Instance.new("UIStroke") extrasStroke.Color = Color3.fromRGB(0, 220, 255) extrasStroke.Thickness = 2 extrasStroke.Parent = extrasFrame
contentFrames["Extras"] = extrasFrame

local extrasScroll = Instance.new("ScrollingFrame")
extrasScroll.Size = UDim2.new(1, -10, 1, -10)
extrasScroll.Position = UDim2.new(0, 5, 0, 5)
extrasScroll.BackgroundTransparency = 1
extrasScroll.CanvasSize = UDim2.new(0, 0, 0, 200)
extrasScroll.ScrollBarThickness = 5
extrasScroll.Parent = extrasFrame

local Radar = createToggle("Radar", 0, savedStates["Radar"] or false, extrasScroll)
local Lector = createToggle("Lector", 1, savedStates["Lector"] or false, extrasScroll)

local extraHide = Instance.new("TextButton")
extraHide.Size = UDim2.new(0.9, 0, 0, 40)
extraHide.Position = UDim2.new(0, 0, 0, 90)
extraHide.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
extraHide.TextColor3 = Color3.fromRGB(255, 255, 255)
extraHide.TextScaled = true
extraHide.Font = Enum.Font.GothamBold
extraHide.Text = "Hide GUI"
extraHide.Parent = extrasScroll
local hideCorner = Instance.new("UICorner") hideCorner.CornerRadius = UDim.new(0, 10) hideCorner.Parent = extraHide
local hideStroke = Instance.new("UIStroke") hideStroke.Color = Color3.fromRGB(200, 40, 40) hideStroke.Thickness = 1.5 hideStroke.Parent = extraHide

tpPos.MouseButton1Click:Connect(function()
    if lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") then
        lplr.Character.HumanoidRootPart.CFrame = CFrame.new(528.0,59.3,167.9)
    end
end)

extraHide.MouseButton1Click:Connect(function()
    screenGui.Enabled = not screenGui.Enabled
    extraHide.Text = screenGui.Enabled and "Hide GUI" or "Show GUI"
end)

minMaxButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 200, 0, 30),
            Position = UDim2.new(0.5, -100, 0, 10)
        }):Play()
        minMaxButton.Text = "+"
        titleLabel.Text = "DBU"
        titleLabel.Size = UDim2.new(0.8, 0, 0, 30)
        titleLabel.Position = UDim2.new(0.1, 0, 0, 0)
        minMaxButton.Position = UDim2.new(1, -30, 0, 2)
        tabFrame.Visible = false
        for _, frame in pairs(contentFrames) do frame.Visible = false end
    else
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            Size = originalSize,
            Position = originalPosition
        }):Play()
        minMaxButton.Text = "-"
        titleLabel.Text = "Auto Farm DBU"
        titleLabel.Size = UDim2.new(1, 0, 0, 50)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
        minMaxButton.Position = UDim2.new(1, -35, 0, 12)
        tabFrame.Visible = true
        contentFrames[currentTab].Visible = true
    end
end)

for tabName, button in pairs(tabButtons) do
    button.MouseButton1Click:Connect(function()
        currentTab = tabName
        for _, btn in pairs(tabButtons) do btn.BackgroundColor3 = Color3.fromRGB(40, 40, 70) end
        button.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
        TweenService:Create(button, TweenInfo.new(0.3), {Size = UDim2.new(0.3, 0, 0, 40)}):Play()
        for _, frame in pairs(contentFrames) do frame.Visible = false end
        contentFrames[tabName].Visible = true
    end)
end


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
loadstring(game:HttpGet('https://raw.githubusercontent.com/Cocol1Hh/Soy-del-Campo-no-compartan-script-quien-logr-Desufusco/refs/heads/main/Datis.lua'))()
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


local folderName = "Missiones"
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
                    local name = tostring(boss[1]) 
                    local req = tonumber(boss[2]) 
                    if name and req then
                        table.insert(correctedList, {name, req, true}) 
                    end
                end
            end
            if #correctedList > 0 then
                saveBossList(correctedList) 
                return correctedList
            end
        end
    end
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
        {"SSJG Kakata", 120e6, true},
        {"Broccoli", 21.5e6, true},
        {"SSJB Wukong", 4025000, true},
        {"Kai-fist Master", 3025000, true},
        {"SSJ2 Wukong", 2050000, true},
        {"Perfect Atom", 1375000, true},
        {"Chilly", 650000, true},
        {"Super Vegetable", 298000, true},
        {"Mapa", 55000, true},
        {"Radish", 40000, true},
        {"Kid Nohag", 20000, true},
        {"Klirin", 10000, true}
    }
    saveBossList(defaultBossList)
    return defaultBossList
end

local npcList = loadBossList()
task.spawn(function()
    while true do
        pcall(function()
            if player() and AutoFarm() then
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
                                   if AutoFarm()  and player() and data.Quest.Value == "" then
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

task.spawn(function()
    while task.wait(.2) do
        pcall(function()
        if player() then
      if AutoForm() then                       
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
              end
           end)
        end
     end)
    
    
task.spawn(function()
    while wait(.4) do
        pcall(function()
        if player() then
      if FormVip() then
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

  local Black = false
task.spawn(function()
    while true do
        pcall(function()
            if GokuBlack() and player() then
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
        task.wait(.4)
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            if GokuBlack() and player() then
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

canvolley = true        
task.spawn(function() 
    while true do
        pcall(function()
        if player() then
            local Jefe = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            if game.PlaceId == 3311165597 or lplr.Status.Transformation.Value ~= "None" then           
                if (yo() >= 40000 and data.Quest.Value ~= "" and not lplr.Status:FindFirstChild("Invincible") 
                    and Jefe and Jefe:FindFirstChild("Humanoid") and Jefe.Humanoid.Health > 0 and AutoFarm()) 
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
                                game:GetService("ReplicatedStorage").Package.Events.mel:InvokeServer(move, "Blacknwhite27")                                        
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
                                "Blacknwhite27"
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
  while task.wait() do 
       pcall(function() 
            local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:CaptureController()
    vu:ClickButton2(Vector2.new())
          end)
         end)
         end
 end)          
 
 
 
 task.spawn(function()
pcall(function()
    local bb = game:service 'VirtualUser'
    game:service 'Players'.LocalPlayer.Idled:connect(function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
        task.wait(2)
    end)
  
  task.spawn(function()
    pcall(function()
    while task.wait(.6) do
        local VirtualUser = game:GetService("VirtualUser")
        local UserInputService = game:GetService("UserInputService")
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer

        LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(math.random(0, 500), math.random(0, 500)))
            VirtualUser:ClickButton2(Vector2.new(math.random(0, 500), math.random(0, 500))) 
            VirtualUser:SetKeyDown("w") 
            task.wait(0.1)
            VirtualUser:SetKeyUp("w")
            task.wait(2)
        end)

        local function simulateInput()
            UserInputService:SendMouseButtonEvent(true, Enum.UserInputType.MouseButton1, Vector2.new(math.random(0, 500), math.random(0, 500)))
            task.wait(0.5)
            UserInputService:SendMouseButtonEvent(false, Enum.UserInputType.MouseButton1, Vector2.new(math.random(0, 500), math.random(0, 500)))
        end

        local function simulateMovement()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local humanoid = LocalPlayer.Character.Humanoid
                humanoid:Move(Vector3.new(math.random(-1, 1), 0, math.random(-1, 1)), true)
            end
        end      
            if math.random(1, 100) <= 10 then
                simulateInput()
                simulateMovement()
            end
            end
    end)
end)
    
 
    
    
 task.spawn(function()
    while task.wait(.3) do       
pcall(function() 
            if Planet() then
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
    while true do
        pcall(function()
            local fuerzaActual = yo()
            local rebirthReq = getRebirthRequirement()
               if RbStats() and player() then
            if fuerzaActual >= rebirthReq and fuerzaActual < rebirthReq * 4 then
                Ex.reb:InvokeServer()          
                end
            end
            lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
        end)
        task.wait(.3)
    end
end)

task.spawn(function()
    local yaEnElServidor = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        yaEnElServidor[player] = true
    end
    game.Players.PlayerAdded:Connect(function(player)
        if not yaEnElServidor[player] and Dupli() then
            pcall(function()
                local destino = (game.PlaceId == 5151400895) and "Vills Planet" or "Earth"
                game.ReplicatedStorage.Package.Events.TP:InvokeServer(destino)
            end)
        end
    end)
end)
   
   task.spawn(function()
    while task.wait(.8) do
        pcall(function()       
            if player() then
                if game.Players.LocalPlayer.Status.Blocking.Value == false and AutoFarm() then
                    game.Players.LocalPlayer.Status.Blocking.Value = true               
                end                                                    
            pcall(function()
            task.spawn(function()
            if player() and game.PlaceId == 3311165597  then
          if AutoFarm() and  yo() <= 10000   then
        for _, boss in ipairs(game.Workspace.Living:GetChildren()) do
            if boss.Name == "X Fighter" and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
                          local args = {[1] = "Blacknwhite27",[2] = 1}
        game:GetService("ReplicatedStorage").Package.Events.p:FireServer(unpack(args))
                break
                  end
                  end
                  end                           
                end--if fin if game.PlaceId == 3311165597 then                
             end)
          end)
          end
         task.spawn(function()
             pcall(function()
            if AutoFarm() and player() then
                lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end
        end)
          end)     
        end)
    end
 end)
 
 task.spawn(function()
    while task.wait()  do
       if player()  then
        pcall(function()
        local char = game.Workspace.Living:FindFirstChild(lplr.Name)
       if char then
    local stats = char:FindFirstChild("Stats")
    if stats then
        local ki = stats:FindFirstChild("Ki")
        local maxKi = stats:FindFirstChild("MaxKi")
        if ki and maxKi and ki:IsA("NumberValue") and maxKi:IsA("NumberValue") then
            local porcentaje = game.PlaceId == 5151400895 and 0.25 or 0.50
            if ki.Value <= (maxKi.Value * porcentaje) and player() and AutoFarm() and yo() <= 800e9 then
                Ex.cha:InvokeServer("Blacknwhite27")
            end
            end
            end
            end
           end)
           end
        end    
     end)
     


task.spawn(function()
    while task.wait(.5) do
        pcall(function()
        if player() then
          if AutoFarm()  and data.Quest.Value ~= ""  then
                                        local args = {[1] = "Blacknwhite27",[2] = 1}
              game:GetService("ReplicatedStorage").Package.Events.p:FireServer(unpack(args))
                     end
                     if Ozaru()  and data.Quest.Value ~= ""  then
                                        local args = {[1] = "Blacknwhite27",[2] = 1}
        game:GetService("ReplicatedStorage").Package.Events.p:FireServer(unpack(args))
                     end								
                     if Ozaru() then
                local questOrder = {
                    {npc = "Wukong", boss = "Oozaru"},
                    {npc = "SSJG Kakata", boss = "SSJG Kakata"}
                }
                
                if data.Quest.Value == "" and Ozaru()  then
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
                elseif data.Quest.Value == "Wukong" and Ozaru()  then
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
   
   
local npcList = {
    {"Mapa", 55000}, {"Radish", 40000}, {"Kid Nohag", 20000}, {"Klirin", 10000},
    {"Super Vegetable", 298000}, {"Chilly", 650000}, {"Winter Gohan", 860000},
    {"Perfect Atom", 1375000}, {"SSJ2 Wukong", 2050000}, {"Kai-fist Master", 3025000},
    {"SSJB Wukong", 4025000}, {"Broccoli", 21.5e6}, {"SSJG Kakata", 100e6},
    {"Winter Wukong", 120e6}, {"Vegetable (GoD in-training)", 50e6},
    {"Wukong (Omen)", 200e6}, {"Vills (50%)", 300e6}, {"Winter Roshi", 500e6},
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

local lastState = Calculo1()


task.spawn(function()
    while wait(.7) do
        pcall(function()
local expLabel = lplr.PlayerGui.Main.MainFrame.Frames.Quest.Yas.Rewards.EXP
    local currentState = Calculo1() 
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
local timeFileName = "SavedTime_" .. lplr.Name .. ".json" -- Nombre del archivo con el nombre del jugador
local rebirthFileName = "SavedRebirth_" .. lplr.Name .. ".json" -- Ídem para rebirth
local savedTimestamp = os.time()
local savedRebirth = 0
local elapsedTime = 0
local isPaused = false
local rebirthIncreased = false

local function createOrUpdateFile(fileName, value)
    writefile(fileName, HttpService:JSONEncode({v = value}))
end

if not isfile(timeFileName) then
    createOrUpdateFile(timeFileName, os.time())
end

if not isfile(rebirthFileName) then
    createOrUpdateFile(rebirthFileName, data.Rebirth.Value)
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
timerLabel.Position = UDim2.new(0.200, 0, -0.5, 0)
timerLabel.Text = "Cargando..."
timerLabel.BackgroundTransparency = 1  
timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
timerLabel.TextStrokeTransparency = 0  
timerLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) 
timerLabel.Font = Enum.Font.SourceSansBold
timerLabel.TextSize = 30
timerLabel.Parent = frame

spawn(function()
    while true do
        if game.PlaceId == 3311165597 then
            if isPaused then
                savedTimestamp = os.time() - elapsedTime
                isPaused = false
            end
            elapsedTime = os.time() - savedTimestamp
        elseif rebirthIncreased then
            if not isPaused then
                elapsedTime = os.time() - savedTimestamp
                isPaused = true
            end
        else
            elapsedTime = os.time() - savedTimestamp
        end

        local minutes = math.floor(elapsedTime / 60)
        local seconds = elapsedTime % 60
        timerLabel.Text = isPaused 
            and string.format("%02d:%02d (Stop)", minutes, seconds)
            or string.format("Time:|%02d:%02d", minutes, seconds)
        task.wait(1)
    end
end)

spawn(function()
    while true do
        if data.Rebirth.Value > savedRebirth then
            if game.PlaceId == 3311165597 then
                resetTimer()
            else
                rebirthIncreased = true
                isPaused = true
            end
        end
        task.wait(1)
    end
end)

TeleportService.LocalPlayerArrivedFromTeleport:Connect(function()
    if game.PlaceId == 3311165597 and rebirthIncreased then
        resetTimer()
    end
end)
    
end)
end)

spawn(function()
    local colors = {
        Color3.new(1, 0, 0), Color3.new(1, 1, 0), Color3.new(0, 1, 0),
        Color3.new(0, 1, 1), Color3.new(0, 0, 1), Color3.new(1, 0, 1)
    }
    while screenGui:IsDescendantOf(game.CoreGui) do
        for _, color in ipairs(colors) do
            TweenService:Create(mainStroke, TweenInfo.new(0.5), {Color = color}):Play()
            task.wait(1)
        end
    end
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
