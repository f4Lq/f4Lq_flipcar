PlayerData = nil
PlayerJob = nil
PlayerGrade = nil

local VehicleData = nil

local flippedCar = nil

function prnt(msg, type)
    if Config.Debug then
        TriggerEvent('f4LqNotify:Alert', "", msg, 5000, type or "info")
    end
end

function isCarFlipped(vehicle)
    local roll = GetEntityRoll(vehicle)
    return roll > 75.0 or roll < -75.0
end

function displayText()
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 5.0, 0, 70)
    prnt("Displaying text")
    if DoesEntityExist(vehicle) and isCarFlipped(vehicle) and not IsPedRagdoll(playerPed) then
        prnt("Drawing 3D Text")
        DrawText3D(GetEntityCoords(vehicle).x, GetEntityCoords(vehicle).y, GetEntityCoords(vehicle).z + 1.0, "~w~Naciskać ~g~E~w~ aby przewrocic samochod")
        flippedCar = vehicle
    else
        prnt("Flipped car nil")
        flippedCar = nil
    end
end

function flipCar()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)
    if flippedCar ~= nil and not IsPedInAnyVehicle(PlayerPedId(), false) then
        local playerPed = GetPlayerPed(-1)
        VehicleData = GetClosestVehicle(GetEntityCoords(playerPed), 5.0, 0, 70)
        prnt("Rozpoczęcie anim", "warning")
        RequestAnimDict('missfinale_c2ig_11')
        while not HasAnimDictLoaded("missfinale_c2ig_11") do
            Wait(10)
        end
        TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
        local timesa = Config.TimesTillFlip * 1000
        if Config.CustomProgBar then
            prnt("Niestandardowy progbar true", "info")
            if lib.progressCircle({
                duration = timesa,
                position = 'bottom',
                useWhileDead = false,
                canCancel = true,
                disable = {
                    car = true,
                },
                anim = {
                    dict = 'missfinale_c2ig_11',
                    clip = 'pushcar_offcliff_m'
                },
                prop = {
                    model = `prop_ld_flow_bottle`,
                    pos = vec3(0.03, 0.03, 0.02),
                    rot = vec3(0.0, 0.0, -1.5)
                },
            }) then 
                TriggerEvent('f4LqNotify:Alert', "", Config.Lang[Config.Langes]['flipped'], 5000, "success")
            else 
                TriggerEvent('f4LqNotify:Alert', "", "Anulowano przewracanie samochodu", 5000, "error")
            end
        end
        Wait(timesa)
        local carCoords = GetEntityRotation(VehicleData, 2)
        SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
        SetVehicleOnGroundProperly(VehicleData)
        ClearPedTasks(ped)
        prnt("Odwrócony samochód", "success")
        flippedCar = nil
    elseif IsPedInAnyVehicle(PlayerPedId(), false) then
        prnt("Not in vehicle car", "error")
        TriggerEvent('f4LqNotify:Alert', "", Config.Lang[Config.Langes]['in_vehicle'], 5000, "error")
    end
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)

    AddTextComponentString(text)
    DrawText(_x, _y)
end

Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    while true do
        Citizen.Wait(0)
        displayText()

        if IsControlJustReleased(0, 38) and flippedCar ~= nil and not IsPedRagdoll(playerPed) then -- 'E' key
            flipCar()
        end
    end
end)


