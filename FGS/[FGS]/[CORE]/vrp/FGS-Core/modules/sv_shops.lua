local shopitems = {
-- {spawnname, title, desc, price},
    {"beer", "Beer", "", 5000},
    {"vodka", "Vodka", "", 1000},
    {"water", "Water", "", 10000},
    {"milk", "Milk", "Be like your dad", 10000},
    {"coffee", "Coffee", "", 10000},
    {"tea", "Tea", "", 10000},
    {"icetea", "Ice Tea", "", 10000},
    {"orangejuice", "Orange Juice", "", 10000},
    {"cocacola", "Coca Cola", "", 10000},
    {"redbull", "Redbull", "", 10000},
    {"lemonade", "Lemonade", "", 10000},
    {"vodka", "Vodka", "", 10000},
    {"bread", "Bread", "", 10000},
    {"donut", "Donut", "", 10000},
    {"tacos", "Tacos", "", 10000},
    {"sandwich", "Sandwich", "", 10000},
    {"kebab", "Kebab", "", 10000},
    {"pdonut", "Premium Donut", "", 10000},

    {"id_card", "ID Card", "(BANK HEIST)", 10000},
    {"laptop_h", "Laptop", "(BANK HEIST)", 10000},
    {"thermal_charge", "Thermal", "(BANK HEIST)", 10000},
}





--FOOD

-- create Breed item



   
RegisterServerEvent("Shop:refresh")
AddEventHandler("Shop:refresh", function()
    local source = source
    TriggerClientEvent('Shop:items', source, shopitems)
end)
   
   
RegisterServerEvent('Shop:brought')
AddEventHandler('Shop:brought', function(item, price)
    local source = source
    local user_id = tonumber(vRP.getUserId(source))

    if vRP.tryFullPayment(user_id, price) then
        vRP.giveInventoryItem(user_id, item, 1, true)
    else
        vRPclient.notify(source, {"~r~Not enough money."})
    end
end)
   
