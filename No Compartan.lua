local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local ArchivoClaveGuardada = "ClaveGuardada.json"
local ArchivoHistorial = "HistorialClaves.json"

local function crearGUI()
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "KeySystemGUI"
    KeyGui.ResetOnSpawn = false
    KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    KeyGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 350, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = KeyGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = MainFrame

    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 50))
    }
    Gradient.Rotation = 45
    Gradient.Parent = MainFrame

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 47, 1, 47)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.new(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceScale = 1
    Shadow.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = "🔐 Secure Key System"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 28
    Title.Parent = MainFrame

    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.Size = UDim2.new(0.9, 0, 0, 50)
    KeyInput.Position = UDim2.new(0.05, 0, 0.2, 0)
    KeyInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.PlaceholderText = "Enter your key here..."
    KeyInput.Text = ""
    KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyInput.TextSize = 16
    KeyInput.Parent = MainFrame

    local UICornerInput = Instance.new("UICorner")
    UICornerInput.CornerRadius = UDim.new(0, 10)
    UICornerInput.Parent = KeyInput

    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Name = "SubmitButton"
    SubmitButton.Size = UDim2.new(0.9, 0, 0, 50)
    SubmitButton.Position = UDim2.new(0.05, 0, 0.4, 0)
    SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.Text = "Submit Key"
    SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitButton.TextSize = 18
    SubmitButton.Parent = MainFrame

    local UICornerSubmit = Instance.new("UICorner")
    UICornerSubmit.CornerRadius = UDim.new(0, 10)
    UICornerSubmit.Parent = SubmitButton

    local CopyURLButton = Instance.new("TextButton")
    CopyURLButton.Name = "CopyURLButton"
    CopyURLButton.Size = UDim2.new(0.425, 0, 0, 50)
    CopyURLButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    CopyURLButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    CopyURLButton.Font = Enum.Font.Gotham
    CopyURLButton.Text = "Copy Key URL"
    CopyURLButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyURLButton.TextSize = 16
    CopyURLButton.Parent = MainFrame

    local UICornerCopyURL = Instance.new("UICorner")
    UICornerCopyURL.CornerRadius = UDim.new(0, 10)
    UICornerCopyURL.Parent = CopyURLButton

    local DiscordButton = Instance.new("TextButton")
    DiscordButton.Name = "DiscordButton"
    DiscordButton.Size = UDim2.new(0.425, 0, 0, 50)
    DiscordButton.Position = UDim2.new(0.525, 0, 0.6, 0)
    DiscordButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    DiscordButton.Font = Enum.Font.Gotham
    DiscordButton.Text = "Join Discord"
    DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordButton.TextSize = 16
    DiscordButton.Parent = MainFrame

    local UICornerDiscord = Instance.new("UICorner")
    UICornerDiscord.CornerRadius = UDim.new(0, 10)
    UICornerDiscord.Parent = DiscordButton

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "StatusLabel"
    StatusLabel.Size = UDim2.new(0.9, 0, 0, 40)
    StatusLabel.Position = UDim2.new(0.05, 0, 0.8, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.TextSize = 16
    StatusLabel.Parent = MainFrame

    return KeyGui, KeyInput, SubmitButton, CopyURLButton, DiscordButton, StatusLabel
end

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
local Ex = game:GetService("ReplicatedStorage").Package.Events

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local t = 24 * 60 * 60
local d = isfile("ClaveGuardada.json") and t - (os.time() - game:GetService("HttpService"):JSONDecode(readfile("ClaveGuardada.json")).fecha) or 0


local l = Instance.new("TextLabel", screenGui)
l.Size = UDim2.new(0.3, 0, 0.1, 0)
l.Position = UDim2.new(0.35, 0, -0.1, 0)
l.TextColor3 = Color3.new(1, 1, 1)
l.TextScaled = true
l.BackgroundTransparency = 1

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
    switchButton.Size = UDim2.new(0, 88, 0, 30)
    switchButton.Text = "Reb"
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

local getIsActive5 = createSwitch(screenGui, UDim2.new(0.2, 0, 0.120, 0), "Switch1", LoadSwitchState("Switch1"))--Farm

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

--Ciclo Para Auto = Main y Start
local gui = lplr.PlayerGui.Main.bruh
if workspace.Others:FindFirstChild("Title") then
    Ex.Start:InvokeServer()
    gui.Disabled = true
    gui.Disabled = false
      end
 end)


local npcList = {
    {"Vekuta (SSJBUI)", 2.375e9}, {"Wukong Rose", 1.65e9}, {"Vekuta (LBSSJ4)", 1.05e9},
    {"Wukong (LBSSJ4)", 950e6}, {"Vegetable (LBSSJ4)", 650e6}, {"Vis (20%)", 500e6},
    {"Vills (50%)", 350e6}, {"Wukong (Omen)", 200e6}, {"Vegetable (GoD in-training)", 150e6},
    {"SSJG Kakata", 100e6}, {"Broccoli", 38.5e6}, {"SSJB Wukong", 8e6},
    {"Kai-fist Master", 3625000}, {"SSJ2 Wukong", 2250000}, {"Perfect Atom", 1275000},
    {"Chilly", 950000}, {"Super Vegetable", 358000}, {"Mapa", 0}, {"Radish", 55000},
    {"Kid Nohag", 40000}, {"Klirin", 0}
}

local moves = {
    {name = "Wolf Fang Fist", condition = 5000},
    {name = "Meteor Crash", condition = 40000},
    {name = "High Power Rush", condition = 100000},
    {name = "Mach Kick", condition = 125000},
    {name = "Spirit Barrage", condition = 60e6},
    {name = "God Slicer", condition = 60e6}
}

local Forms = {'Divine Rose Prominence', 'Astral Instinct', 'Ultra Ego', 'SSJB4', 'True God of Creation', 
    'True God of Destruction', 'Super Broly', 'LSSJG', 'LSSJ4', 'SSJG4', 'LSSJ3', 'Mystic Kaioken', 
    'LSSJ Kaioken', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 
    'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 
    'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 'SSJ Blue', 
    'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 'Spirit SSJ', 'SSJ2 Majin', 
    'SSJ2', 'SSJ Kaioken', 'SSJ', 'FSSJ', 'Kaioken'}


spawn(function()
    while task.wait() do
        pcall(function()
            if data.Quest.Value == "" then
                for _, npc in ipairs(npcList) do
                    local npcName, FZ = npc[1], npc[2]
                    if (data.Rebirth.Value > 1000 or npcName ~= "Mapa") and yo() >= FZ then
                        local npcInstance = game.Workspace.Others.NPCs:FindFirstChild(npcName)
                        if npcInstance and npcInstance:FindFirstChild("HumanoidRootPart") then
                            lplr.Character.HumanoidRootPart.CFrame = npcInstance.HumanoidRootPart.CFrame          
                              if data.Quest.Value == "" then
            Ex.Qaction:InvokeServer(npcInstance)              
                            break
                               end
                        end
                    end
                end
            end
        end)
    end
end)

task.spawn(function()
    while d > 0  do
        pcall(function()
        if d > 0 then
        l.Text = string.format("%02d:%02d:%02d", math.floor(d / 3600), math.floor((d % 3600) / 60), d % 60)
        d -= 1
        wait(1)
    l.Text = "00:00:00"
else
    l.Text = "Clave no válida"
end
 end)
     end
 end)

--Ciclo Para Auto = Tp Boss A Cualquier Tipo De Boss
task.spawn(function()
    while task.wait() do
        pcall(function()
        task.spawn(function()
        if data.Quest.Value ~= "" then
            local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                lplr.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4.5)
                Ex.p:FireServer("Blacknwhite27", 1)
                    end
                end
         game.Workspace.FallenPartsDestroyHeight = 0/0
           lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
                       if game.PlaceId ~= 5151400895 and data.Quest.Value ~= "" then
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
        end)        
    end
end)


task.spawn(function()
    while wait(1) do
        pcall(function()
            TOD() Detry()
        end)
    end
end)



task.spawn(function()
    while true do
        pcall(function()
            local boss = game.Workspace.Living:FindFirstChild(data.Quest.Value)
            local Ki = lplr.Character.Stats.Ki
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and data.Quest.Value ~= "" and lplr.Character.Humanoid.Health > 0 then
                for _, move in pairs(moves) do
                    if not lplr.Status:FindFirstChild(move.name) and yo() >= move.condition and Ki.Value > Ki.MaxValue * 0.20 then
                        task.spawn(function()
                            Ex.mel:InvokeServer(move.name, "Blacknwhite27")
                            Ex.voleys:InvokeServer("Energy Volley", { FaceMouse = false, MouseHit = CFrame.new() }, "Blacknwhite27")                          
                        end)
                    end
                end
            end
        end)
        wait()
    end
end)

function Detry()
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj:IsA("") or obj.Name == "Effects" or obj:IsA("ParticleEmitter") then
              obj:Destroy()
                end
            end          
            if getIsActive5() then 
game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
             end
                      if game.PlaceId == 5151400895 and yo() <= 150e6 then
                Ex.TP:InvokeServer("Earth")
            elseif game.PlaceId ~= 5151400895 and yo() >= 150e6 then
               Ex.TP:InvokeServer("Vills Planet")                                
            end
                   if data.Quest.Value ~= "" then
            wait(1)
            for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
                if npc:FindFirstChild("HumanoidRootPart") and (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude <= 500 and npc.Name ~= "Halloween NPC" then
                    data.Quest.Value = ""
                    break
                end
            end
        end
  end


task.spawn(function()
    while task.wait() do
        pcall(function()   
     task.spawn(function()  
        if game.PlaceId ~= 5151400895 then
         game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")
                end
            end)
        end)
    end
end)    
            

--Ciclo de Todo
function TOD()
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
           keypress(Enum.KeyCode.L)  
          game:GetService('Players').LocalPlayer.Idled:Connect(function()
                local bb = game:GetService('VirtualUser')
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
                wait(20)
            end)
        if lplr.Status.Transformation.Value ~= "None" and game.PlaceId == 5151400895 then
                    game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")            
                end
end

task.spawn(function()
    while task.wait() do
        pcall(function()
        task.spawn(function()
        local status = lplr.Status
    if status.Transformation.Value == "None" then
        for _, form in ipairs(Forms) do 
            if Ex.equipskill:InvokeServer(form) then break end 
        end
        if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
            Ex.ta:InvokeServer()
                       end
                   end
               end)
           end)
        end
     end)
 end)
end

local function verificarClave()
    if claveEsValida() then
        lopoi()
    else
        task.delay(1, verificarClave)
    end
end
verificarClave()

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

local KeyGui, KeyInput, SubmitButton, CopyURLButton, DiscordButton, StatusLabel = crearGUI()

local function mostrarMensaje(mensaje, color)
    StatusLabel.Text = mensaje
    StatusLabel.TextColor3 = color
    StatusLabel.TextTransparency = 1
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(StatusLabel, tweenInfo, {TextTransparency = 0})
    tween:Play()
    wait(2)
    tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    tween = TweenService:Create(StatusLabel, tweenInfo, {TextTransparency = 1})
    tween:Play()
end

local function animateButton(button)
    local originalColor = button.BackgroundColor3
    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(100, 100, 110)})
    tween:Play()
    wait(0.1)
    tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = originalColor})
    tween:Play()
end

SubmitButton.MouseButton1Click:Connect(function()
    animateButton(SubmitButton)
    local clave = KeyInput.Text:match("KEY:%[(.-)%]$")
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
            mostrarMensaje("Key accepted!", Color3.fromRGB(0, 255, 0))
            -- Aquí iría la función para iniciar el script principal
        else
            mostrarMensaje("Similar key already used", Color3.fromRGB(255, 0, 0))
        end
    else
        mostrarMensaje("Invalid key format", Color3.fromRGB(255, 0, 0))
    end
    KeyInput.Text = ""
end)

CopyURLButton.MouseButton1Click:Connect(function()
    animateButton(CopyURLButton)
    setclipboard("https://discord.com/invite/P6b85GfDdF")
    mostrarMensaje("URL copied to clipboard", Color3.fromRGB(0, 255, 0))
end)

DiscordButton.MouseButton1Click:Connect(function()
    animateButton(DiscordButton)
    setclipboard("https://luatt11.github.io/Keysistema/")
    mostrarMensaje("Discord invite copied", Color3.fromRGB(0, 255, 0))
end)

spawn(function()
    while wait() do
        if not claveEsValida() then
            resetearClave()
            KeyGui.Enabled = true
        end
    end
end)


if claveEsValida() then
    KeyGui.Enabled = false
else
    KeyGui.Enabled = true
end
