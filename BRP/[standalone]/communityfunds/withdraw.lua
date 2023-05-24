if playerPedID = 1 or 2 then 
    TriggerClientEvent("chat:addMessage: 'you have tried to withdraw money without specifying the amount'")
    Print(" please specify the amount ") --- only id 1 and 2 can withdraw money

    if playerPedID = nil do 
        Print("dont even try take money from the community.")
