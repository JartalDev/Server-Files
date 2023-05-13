RegisterNetEvent('CX:checkTutorial')
AddEventHandler('CX:checkTutorial', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasGroup(user_id, 'TutorialCompleted') then
        print("Tutorial Not Completed")
        TriggerClientEvent('CX:startTutorial', source)
    else
        
    end
end)

RegisterNetEvent('CX:setCompletedTutorial')
AddEventHandler('CX:setCompletedTutorial', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasGroup(user_id, 'TutorialCompleted') then
        vRP.addUserGroup(user_id,'TutorialCompleted')
    end
end)