local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local discordWebhookUrl = "https://discord.com/api/webhooks/1326572470488141835/-yh97OuQh63GSfo6aAgZ3w-9krwwfsRb1nMSVPSS2DHHTm_L5fAoN8lFSoI11LsYSKoA"
local lplr = Players.LocalPlayer

local jugadoresPermitidos = {
    ["iLordYamoshi666"] = true,
    ["camilito10059"] = true
}

if not jugadoresPermitidos[lplr.Name] then
    return
end

local data = game.ReplicatedStorage:WaitForChild("Datas"):WaitForChild(lplr.UserId)

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
    local avatarUrl = getAvatarUrl(player.UserId)

    if avatarUrl then
        local embed = {
            ["embeds"] = {
                {
                    ["title"] = "Script Activado",
                    ["description"] = "**El jugador `" .. player.Name .. "` ha ejecutado el script correctamente.**",
                    ["color"] = 0x3498db,
                    ["fields"] = {
                        {["name"] = "Usuario", ["value"] = "`" .. player.Name .. "`", ["inline"] = true},
                        {["name"] = "Apodo", ["value"] = "`" .. player.DisplayName .. "`", ["inline"] = true},
                        {["name"] = "Rebirth", ["value"] = "`" .. tostring(data.Rebirth.Value) .. "`", ["inline"] = true},
                        {["name"] = "Defense", ["value"] = "`" .. tostring(data.Defense.Value) .. "`", ["inline"] = true}
                    },
                    ["thumbnail"] = {
                        ["url"] = avatarUrl
                    },
                    ["footer"] = {
                        ["text"] = "Sistema de monitoreo"
                    },
                    ["timestamp"] = DateTime.now():ToIsoDate()
                }
            }
        }

        pcall(function()
            http_request({
                Url = discordWebhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = HttpService:JSONEncode(embed)
            })
        end)
    end
end

sendAvatarToDiscord(lplr)
