local ESX = exports["es_extended"]:getSharedObject()

carblacklist = {
    ["RHINO"] = true,
    ["APC"] = true,
    ["TITAN"] = true,
    ["AVENGER"] = true,
    ["DIRIGEABLE"] = true,
    ["JET"] = true,
    ["BOMBUSHKA"] = true,
    ["VIGILENTE"] = true,
    ["HYDRA"] = true,
    ["VALKYRIE2"] = true,
    ["VALKYRIE"] = true,
    ["SAVAGE"] = true,
    ["AKULA"] = true,
    ["KOSATKA"] = true,
    ["PATROLBOAT"] = true,
    ["LIMO2"] = true,
    ["BUZZARD"] = true,
    ["ANNihilator"] = true,
    ["CARGOBOB"] = true,
    ["SAVAGE"] = true,
    ["VALKYRIE"] = true,
    ["HUNTER"] = true,
    ["AKULA"] = true,
    ["HYDRA"] = true,
    ["LAZER"] = true,
    ["BESRA"] = true,
    ["LUXOR"] = true,
    ["LUXOR2"] = true,
    ["SHAMAL"] = true,
    ["TITAN"] = true,
    ["MILJET"] = true,
    ["TULA"] = true,
    ["SEABREEZE"] = true,
    ["OPPRESSOR2"] = true,
    ["OPPRESSOR"] = true,
    ["DELUXO"] = true,
    ["STROMBERG"] = true,
    ["RUINER2"] = true,
    ["VIGILANTE"] = true,
    ["SCRAMJET"] = true,
    ["THRUSTER"] = true,
    ["BLAZERAQUA"] = true,
    ["DINGHY2"] = true,
    ["DINGHY4"] = true,
    ["JETMAX"] = true,
    ["MARQUIS"] = true,
    ["PREDATOR"] = true,
    ["SEASHARK"] = true,
    ["SEASHARK2"] = true,
    ["SEASHARK3"] = true,
    ["SPEEDER"] = true,
    ["SPEEDER2"] = true,
    ["SQUALO"] = true,
    ["SUBMERSIBLE"] = true,
    ["SUBMERSIBLE2"] = true,
    ["SUNTRAP"] = true,
    ["TORO"] = true,
    ["TORO2"] = true,
    ["TROPIC"] = true,
    ["TROPIC2"] = true,
    ["TUG"] = true,
    ["BESRA"] = true,
    ["CUBAN800"] = true,
    ["DODO"] = true,
    ["DUSTER"] = true,
    ["HYDRA"] = true,
    ["JET"] = true,
    ["LAZER"] = true,
    ["MAMMATUS"] = true,
    ["MILJET"] = true,
    ["NIMBUS"] = true,
    ["SHAMAL"] = true,
    ["STUNT"] = true,
    ["TITAN"] = true,
    ["VELUM"] = true,
    ["VELUM2"] = true,
    ["VESTRA"] = true,
    ["ANNIHILATOR"] = true,
    ["BLIMP"] = true,
    ["BLIMP2"] = true,
    ["BUZZARD"] = true,
    ["CARGOBOB"] = true,
    ["CARGOBOB2"] = true,
    ["CARGOBOB3"] = true,
    ["CARGOBOB4"] = true,
    ["FROGGER"] = true,
    ["FROGGER2"] = true,
    ["MAVERICK"] = true,
    ["POLMAV"] = true,
    ["SAVAGE"] = true,
    ["SKYLIFT"] = true,
    ["SUPERVOLITO"] = true,
    ["SUPERVOLITO2"] = true,
    ["SWIFT"] = true,
    ["SWIFT2"] = true,
    ["VALKYRIE"] = true,
    ["VALKYRIE2"] = true,
    ["VOLATUS"] = true,
    ["CERBERUS3"] = true,
    ["CERBERUS2"] = true,
    ["CERBERUS"] = true,
    ["PHANTOM2"] = true,
    ["AMBULANCE"] = true,
    ["KHANJALI"] = true,
    ["MINITANK"] = true,
    ["CARGOPLANE"] = true,
    ["CARGOPLANE2"] = true,
    ["ALKONOST"] = true,
    ["VOLATOL"] = true,
    ["PYRO"] = true,
    ["ALPHAZ1"] = true,
    ["NOKOTA"] = true,
    ["MOLOTOK"] = true,
    ["MOGUL"] = true,
    ["STARLING"] = true,
    ["ROGUE"] = true,
    ["BUZARD2"] = true,
    ["CHERNOBOG"] = true,
    ["VOLTIC2"] = true,
    }

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(250)
    
            local playerPed = PlayerPedId()
            if IsPedInAnyVehicle(playerPed, false) then
                checkCar(GetVehiclePedIsIn(playerPed, false))
            end
    
            local x, y, z = GetEntityCoords(playerPed, true)
            for _, blacklistedCar in pairs(carblacklist) do
                local vehicle = GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70)
                if vehicle ~= nil and DoesEntityExist(vehicle) then
                    checkCar(vehicle)
                end
            end
        end
    end)
    
    function checkCar(car)
        if car then
            local carModel = GetEntityModel(car)
    
            if isCarBlacklisted(carModel) then
                Citizen.Wait(100)
                DeleteVehicle(car)
            end
        end
    end
    
    function isCarBlacklisted(model)
        return carblacklist[GetDisplayNameFromVehicleModel(model)] ~= nil
    end
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0) 
    
            local allVehicles = ESX.Game.GetVehicles()
            for _, vehicle in ipairs(allVehicles) do
                local coords = GetEntityCoords(vehicle)
                if not IsPedInAnyVehicle(vehicle, true) and isCarBlacklisted(GetEntityModel(vehicle)) then
                    DeleteVehicle(vehicle)
                end
            end
        end
    end)