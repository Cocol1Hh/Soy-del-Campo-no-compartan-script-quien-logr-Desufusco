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
    local historial = {}
    if isfile(ArchivoHistorial) then
        historial = HttpService:JSONDecode(readfile(ArchivoHistorial))
    end
    table.insert(historial, clave)
    if #historial > 5 then
        table.remove(historial, 1)
    end
    writefile(ArchivoHistorial, HttpService:JSONEncode(historial))
end

local function claveEsValida()
    if isfile(ArchivoClaveGuardada) then
        local datos = HttpService:JSONDecode(readfile(ArchivoClaveGuardada))
        if os.time() - datos.fecha < (24 * 60 * 60) then
            return true
        end
    end
    return false
end

local function resetearClave()
    if isfile(ArchivoClaveGuardada) then
        delfile(ArchivoClaveGuardada)
    end
end

local function lopoi()



local lplr = game.Players.LocalPlayer
local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)
local Ex = game:GetService("ReplicatedStorage").Package.Events

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

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
    {"Vekuta (SSJBUI)", 2.375e9},
    {"Wukong Rose", 1.65e9},
    {"Vekuta (LBSSJ4)", 1.05e9},
    {"Wukong (LBSSJ4)", 950e6},
    {"Vegetable (LBSSJ4)", 650e6},
    {"Vis (20%)", 500e6},
    {"Vills (50%)", 350e6},
    {"Wukong (Omen)", 200e6},
    {"Vegetable (GoD in-training)", 150e6},
    {"SSJG Kakata", 100e6},
    {"Broccoli", 45.5e6},
    {"SSJB Wukong", 8e6},
    {"Kai-fist Master", 3625000},
    {"SSJ2 Wukong", 2250000},
    {"Perfect Atom", 1275000},
    {"Chilly", 950000},
    {"Super Vegetable", 358000},
    {"Mapa", 0},
    {"Radish", 55000},
    {"Kid Nohag", 40000},
    {"Klirin", 0}
}

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
                            game:GetService("ReplicatedStorage").Package.Events.Qaction:InvokeServer(npcInstance)
                            break
                        end
                    end
                end
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
                    end
                end
            end)
        end)        
    end
end)

--Borrador de Quets si algun Npc esta serca
task.spawn(function()
    while true do
        if data.Quest.Value ~= "" then
            wait(1)
            for _, npc in ipairs(game.Workspace.Others.NPCs:GetChildren()) do
                if npc:FindFirstChild("HumanoidRootPart") and (npc.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude <= 500 and npc.Name ~= "Halloween NPC" then
                    data.Quest.Value = ""
                    break
                end
            end
        end
        wait()
    end
end)



--Ciclo Para Auto = Tp Boss y Halloween_Farm
task.spawn(function()
    while true do
        pcall(function()
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
        task.wait()
    end
end)



task.spawn(function()
    while wait(.1) do
        pcall(function()
            TOD()
        end)
    end
end)


--Ciclo Para Auto = Tierra/Bills
task.spawn(function()
    while wait() do
        pcall(function()         
            if game.PlaceId == 5151400895 and yo() <= 150e6 then
                Ex.TP:InvokeServer("Earth")
            elseif game.PlaceId ~= 5151400895 and yo() >= 150e6 then
               Ex.TP:InvokeServer("Vills Planet")                                
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
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and data.Quest.Value ~= "" and lplr.Character.Humanoid.Health > 0 then
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

local Q = data:WaitForChild("Quest")
local notified = false
local function NotyQ()
    if Q.Value ~= "" and not notified then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Misión Iniciada",
            Text = tostring(Q.Value),
            Duration = 2
        })
        notified = true
    elseif Q.Value == "" then
        notified = false
    end
end
NotyQ()
game.ReplicatedStorage.Datas[lplr.UserId].Quest.Changed:Connect(function()
    NotyQ()
end)


task.spawn(function()
    while true do
        pcall(function()
        task.spawn(function()
           game.Workspace.FallenPartsDestroyHeight = 0/0
           lplr.PlayerGui.Main.MainFrame.Frames.Quest.Visible = false
           end)
        end)
        task.wait()
    end
end)


--Ciclo para ancti afk
task.spawn(function()
    while true do
        pcall(function()
          keypress(Enum.KeyCode.L)  
          game:GetService('Players').LocalPlayer.Idled:Connect(function()
                local bb = game:GetService('VirtualUser')
                bb:CaptureController()
                bb:ClickButton2(Vector2.new())
            end)
        end)
        wait(100)
    end
end)


task.spawn(function()
    while task.wait() do
        pcall(function()
        task.spawn(function()
        if getIsActive5() then 
game:GetService("ReplicatedStorage").Package.Events.reb:InvokeServer()
             end
           if data.Quest.Value ~= "" then
                Ex.p:FireServer("Blacknwhite27", 1)
                Ex.p:FireServer("Blacknwhite27", 2)
                end
            end)
        end)        
    end
end)



--Ciclo para Auto = Carga en bills/Tierra
task.spawn(function()
    while wait(.3) do
        pcall(function()       
            if lplr.Status.Transformation.Value ~= "None" and game.PlaceId == 5151400895 then
                    game:GetService("ReplicatedStorage").Package.Events.cha:InvokeServer("Blacknwhite27")            
                end
        end)
    end
end)


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
end


local Forms = { 'Divine Rose Prominence', 'Astral Instinct', 'Ultra Ego', 'SSJB4', 'True God of Creation', 
    'True God of Destruction', 'Super Broly', 'LSSJG', 'LSSJ4', 'SSJG4', 'LSSJ3', 'Mystic Kaioken', 
    'LSSJ Kaioken', 'SSJR3', 'SSJB3', 'God Of Destruction', 'God Of Creation', 'Jiren Ultra Instinct', 
    'Mastered Ultra Instinct', 'Godly SSJ2', 'Ultra Instinct Omen', 'Evil SSJ', 'Blue Evolution', 
    'Dark Rose', 'Kefla SSJ2', 'SSJ Berserker', 'True Rose', 'SSJB Kaioken', 'SSJ Rose', 'SSJ Blue', 
    'Corrupt SSJ', 'SSJ Rage', 'SSJG', 'SSJ4', 'Mystic', 'LSSJ', 'SSJ3', 'Spirit SSJ', 'SSJ2 Majin', 
    'SSJ2', 'SSJ Kaioken', 'SSJ', 'FSSJ', 'Kaioken' }

task.spawn(function()
    while task.wait() do
        pcall(function()
        task.spawn(function()
            if lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character.Humanoid.Health > 0 then
                for _, form in ipairs(Forms) do if Ex.equipskill:InvokeServer(form) then break end end
                local status = lplr.Status
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
    local m = #a
    local n = #b
    local dp = {}
    for i = 0, m do
        dp[i] = {}
        dp[i][0] = i
    end
    for j = 0, n do
        dp[0][j] = j
    end
    for i = 1, m do
        for j = 1, n do
            local cost = (a:sub(i, i) == b:sub(j, j)) and 0 or 1
            dp[i][j] = math.min(dp[i - 1][j] + 1, dp[i][j - 1] + 1, dp[i - 1][j - 1] + cost)
        end
    end

    return dp[m][n]
end

TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local texto = TextBox.Text
        local clave = texto:match("KEY:%[(.-)%]$")
        
        if clave and #clave == 64 then
            local tieneMayuscula = clave:match("%u") ~= nil
            local tieneMinuscula = clave:match("%l") ~= nil
            local tieneNumero = clave:match("%d") ~= nil

            if tieneMayuscula and tieneMinuscula and tieneNumero then
                local historial = HttpService:JSONDecode(isfile(ArchivoHistorial) and readfile(ArchivoHistorial) or "[]")
                local claveExistente = false

                for _, v in pairs(historial) do
                    local distancia = calcularDistanciaLevenshtein(v, clave)
                    if distancia <= 14 then 
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
                    TextBox.Text = "Clave Igual"
                    TextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
                    wait(1)
                    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextBox.Text = ""
                end
            else
                TextBox.Text = "Clave Incorrecto"
                TextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
                wait(1)
                TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextBox.Text = ""
            end
        else
            TextBox.Text = "Clave inválida"
            TextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
            wait(1)
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.Text = ""
        end
    end
end)

BotonInvitacion.MouseButton1Click:Connect(function()
    setclipboard("https://discord.com/invite/P6b85GfDdF")
end)

BotonUrl.MouseButton1Click:Connect(function()
    setclipboard("https://luatt11.github.io/Keysistema/")
end)

while wait() do
    if not claveEsValida() then
        resetearClave()
        KeyGui.Enabled = true
    end
end
