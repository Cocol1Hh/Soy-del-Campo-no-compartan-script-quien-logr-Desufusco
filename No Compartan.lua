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
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)
task.spawn(function()
    pcall(function()
    -- Inicio 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
function characterInvisible()
	return lplr.Character
end

function player()
	return lplr.Character and lplr.Character.Humanoid and lplr.Character.Humanoid.Health > 0 and lplr.Character:FindFirstChild("HumanoidRootPart")
end


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


spawn(function()
    if lplr.PlayerGui:FindFirstChild("Start") then
        ReplicatedStorage.Package.Events.Start:InvokeServer()
        if Workspace.Others:FindFirstChild("Title") then
            Workspace.Others.Title:Destroy()
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
local bb = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    bb:CaptureController()
    bb:ClickButton2(Vector2.new())
end)


task.spawn(function()
    while task.wait() do
        pcall(function()
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
            if game:GetService("ReplicatedStorage").Package.Events.equipskill:InvokeServer(form) then break end 
        end
        if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
            game:GetService("ReplicatedStorage").Package.Events.ta:InvokeServer()
                       end
                end
           end)
        end
     end)


local moves = {
    {name = "Wolf Fang Fist", condition = 5000},
    {name = "Meteor Crash", condition = 40000},
    {name = "High Power Rush", condition = 100000},
    {name = "Mach Kick", condition = 125000},
    {name = "Spirit Barrage", condition = 60e6},
    {name = "God Slicer", condition = 60e6}
}

task.spawn(function()
    while true do
        pcall(function()
            local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            local Ki = lplr.Character.Stats.Ki
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and data.Quest.Value ~= "" and player() and characterInvisible() then
                for _, move in pairs(moves) do
                    if not lplr.Status:FindFirstChild(move.name) and yo() >= move.condition and Ki.Value > Ki.MaxValue * 0.20 then
                        task.spawn(function()
                            game.ReplicatedStorage.Package.Events.mel:InvokeServer(move.name, "Blacknwhite27")
                            game.ReplicatedStorage.Package.Events.voleys:InvokeServer("Energy Volley", { FaceMouse = false, MouseHit = CFrame.new() }, "Blacknwhite27")
                        end)
                    end
                end
            end
        end)
        wait()
    end
end)

--Ciclo para  TP Tierra y Bills
task.spawn(function()
    while true do
        pcall(function()         
            if game.PlaceId == 5151400895 and data.Strength.Value <= 200000000 then
                game:GetService("ReplicatedStorage").Package.Events.TP:InvokeServer("Earth")
                task.wait()
            elseif game.PlaceId ~= 5151400895 and data.Strength.Value >= 200000000 then
                game:GetService("ReplicatedStorage").Package.Events.TP:InvokeServer("Vills Planet")
                task.wait()                
            end
        end)
        wait(.5)
    end
end)


task.spawn(function()
    while true do
        pcall(function()
            local questValue = data.Quest.Value
            if questValue ~= "" then
                local boss = game.Workspace.Living:FindFirstChild(questValue)
                if boss and boss:FindFirstChild("HumanoidRootPart") then
                    if boss:FindFirstChild("Humanoid") and boss.Humanoid.Health <= 0 then
                        wait(1)
                    end
                    lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
                    game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
                end
            end
        end)
        task.wait()
    end
end)

task.spawn(function()
    while true do
        pcall(function()
             game:GetService("ReplicatedStorage").Package.Events.block:InvokeServer(true)
             game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
             game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
        end)
        wait(.4)
    end
end)


task.spawn(function()
    while task.wait() do
        pcall(function()   
        if game.PlaceId ~= 5151400895 and player() and characterInvisible() then
         game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
                end
               if data.Quest.Value ~= "" and player() and characterInvisible() then
               game:GetService("ReplicatedStorage").Package.Events.p:FireServer("Blacknwhite27",1)
               end
        end)
    end
end)    


local questData = game.PlaceId ~= 5151400895 and {
    {0, 2e5, {"Klirin", "Kid Nohag"}}, {2e5, 8.5e5, {"Mapa", "Radish"}}, {8.5e5, 4.5e6, {"Super Vegetable", "Chilly"}},
    {4.5e6, 5e6, {"Perfect Atom", "SSJ2 Wukong"}}, {5e6, 2.5e7, {"SSJB Wukong", "Kai-fist Master"}},
    {2.5e7, 5e7, {"SSJB Wukong", "Broccoli"}}, {5e7, math.huge, {"SSJG Kakata", "Broccoli"}}
} or {
    {1e8, 3e8, {"Vegetable (GoD in-training)", "Wukong (Omen)"}}, {3e8, 9e8, {"Vills (50%)", "Vis (20%)"}},
    {9e8, 1.5e9, {"Vis (20%)", "Vegetable (LBSSJ4)"}}, {1.5e9, 2.5e9, {"Wukong (LBSSJ4)", "Vegetable (LBSSJ4)"}},
    {2.5e9, math.huge, {"Vekuta (SSJBUI)", "Wukong Rose"}}
}

task.spawn(function()
    while task.wait() do
        pcall(function()
            if player() and characterInvisible() then
                for _, quest in ipairs(questData) do
                    if data.Defense.Value >= quest[1] and data.Defense.Value < quest[2] then
                        local currentQuestMob = game.Workspace.Living:FindFirstChild(data.Quest.Value)
                        if data.Quest.Value ~= "" and (not currentQuestMob or not currentQuestMob:FindFirstChild("Humanoid")) then
                            data.Quest.Value = ""
                        end
                        if data.Quest.Value == "" then
                            for _, mob in ipairs(quest[3]) do
                                local npc = game.Workspace.Others.NPCs:FindFirstChild(mob)
                                local boss = game.Workspace.Living:FindFirstChild(mob)
                                if npc and boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                                    lplr.Character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame
                                    game.ReplicatedStorage.Package.Events.Qaction:InvokeServer(npc)
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

--Fin del bucle
end)    
    wait(.5)
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

while task.wait() do
    if not claveEsValida() then
        resetearClave()
        KeyGui.Enabled = true
    end
end
