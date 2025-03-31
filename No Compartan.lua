task.spawn(function()
    while wait() do
        pcall(function()
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
            local Requisito = data.Defense.Value -- Valor de defensa del jugador

            -- Opción 1: Seleccionar la forma con requisito menor o igual a Defense
            local selectedForm = nil
            for form, requirement in pairs(Forms) do
                if requirement <= Requisito then
                    if Ex.equipskill:InvokeServer(form) then
                        selectedForm = form
                        break
                    end
                end
            end

            -- Opción 2: Seleccionar la forma con el requisito más fuerte posible
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

            -- Activar la transformación seleccionada (usa maxForm para la más fuerte)
            if status and status.SelectedTransformation.Value ~= status.Transformation.Value then
                Ex.ta:InvokeServer()
            end
        end)
    end
end)
