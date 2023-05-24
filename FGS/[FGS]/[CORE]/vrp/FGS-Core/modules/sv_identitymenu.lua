local lang = vRP.lang
local cfg = module("cfg/identity")
local sanitizes = module("cfg/sanitizes")

RegisterServerEvent("IdentityMenu:NewIdentity")
AddEventHandler('IdentityMenu:NewIdentity', function()
    local player = source
    local coords = GetEntityCoords(GetPlayerPed(source))
    local comparison = vector3(-262.25286865234, -969.47399902344, 31.223146438599)
    local user_id = vRP.getUserId(player)

    if user_id ~= nil then
      vRP.prompt(player,lang.cityhall.identity.prompt_firstname(),"",function(player,firstname)
        if string.len(firstname) >= 2 and string.len(firstname) < 50 then
          firstname = sanitizeString(firstname, sanitizes.name[1], sanitizes.name[2])
          vRP.prompt(player,lang.cityhall.identity.prompt_name(),"",function(player,name)
            if string.len(name) >= 2 and string.len(name) < 50 then
              name = sanitizeString(name, sanitizes.name[1], sanitizes.name[2])
              vRP.prompt(player,lang.cityhall.identity.prompt_age(),"",function(player,age)
                age = parseInt(age)
                if age >= 16 and age <= 150 then
                  if vRP.tryPayment(user_id,cfg.new_identity_cost) then
                    vRP.generateRegistrationNumber(function(registration)
                      vRP.generatePhoneNumber(function(phone)
  
                        MySQL.execute("vRP/update_user_identity", {
                          user_id = user_id,
                          firstname = firstname,
                          name = name,
                          age = age,
                          registration = registration,
                          phone = phone
                        })
  
                        -- update client registration
                        vRPclient.setRegistrationNumber(player,{registration})
                        vRPclient.notify(player,{"Paid ~g~£100"})
                      end)
                    end)
                  else
                    vRPclient.notify(player,{lang.money.not_enough()})
                  end
                else
                  vRPclient.notify(player,{lang.common.invalid_value()})
                end
              end)
            else
              vRPclient.notify(player,{lang.common.invalid_value()})
            end
          end)
        else
          vRPclient.notify(player,{lang.common.invalid_value()})
        end
      end)
    end

    if #(coords - comparison) > 20 then
        print(GetPlayerName(source).." is a cheating scum, he's trying to change his identity when he's miles away!")
        vRP.AnticheatBanVRP(user_id, 'Type: [1](Injecting Code)')
        return
    end
end)