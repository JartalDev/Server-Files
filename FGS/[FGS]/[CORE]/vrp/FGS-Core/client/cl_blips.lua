local blips = {
    --[[ Weed ]]
    {title="Weed Digging", colour=25, id=140, coords = vector3(2943.5905761719,4690.5493164062,51.169910430908)},
    {title="Weed Processing", colour=25, id=469, coords = vector3(1945.3312988281,4853.1108398438,45.452812194824)},
    {title="Weed Trader", colour=52, id=496, coords = vector3(2685.1176757812,3515.3781738281,53.303936004639)},

    --[[ Ecstasy ]]
    {title="Ecstasy Digging", colour=58, id=403, coords = vector3(5337.4912109375,-5263.515625,32.730861663818)},
    {title="Frog Leg Processing", colour=58, id=651, coords = vector3(-2083.5766601563,2617.1372070313,3.0839664936066)},
    {title="Ecstasy Processing", colour=58, id=651, coords = vector3(462.25802612305,-3235.4230957031,6.0695581436157)},
    {title="Ecstasy Trader", colour=1, id=622, coords = vector3(2496.666015625,-383.76452636719,94.12003326416)},

    --[[ Coke ]]
    {title="Cocaine Digging", colour=0, id=501, coords = vector3(1467.2235107422,1112.7380371094,114.33924865723)},
    {title="Cocaine Processing", colour=0, id=501, coords = vector3(-291.93908691406,2524.5732421875,74.659271240234)},
  	{title="Cocaine Trader", colour=0, id=501, coords = vector3(123.57997131348,-1294.9934082031,29.26953125)},

    --[[ Meth ]]
    {title="Meth Lab", colour=3, id=521, coords = vector3(422.35244750977,6465.5004882812,28.819103240967)},
    {title="Meth Processing", colour=3, id=521, coords = vector3(2338.5649414062,2570.6274414062,47.725009918213)},
    {title="Meth Trader", colour=3, id=521, coords = vector3(1671.890625,-25.552042007446,173.77465820313)},

    -- Gun Stores 
    {title="Small Arms Dealer", colour=1, id=159, coords = vector3(-1500.0893554688,-216.69902038574,47.88939666748)},
    {title="Melee Dealer", colour=1, id=154, coords = vector3(-3172.5656738281,1087.0919189453,20.838743209839)},
    {title="Rebel Dealer", colour=1, id=310, coords = vector3(    1542.6922607422,6332.4282226563,24.075044631958)},

    -- Diamond 
    {title="Diamond Collect", colour=0, id=617, coords = vector3(409.96615600586,2891.7504882813,41.319911956787)},
    {title="Diamond Process", colour=0, id=617, coords = vector3(2665.3227539063,2845.0732421875,39.56840133667)},
    {title="Diamond Trader", colour=0, id=617, coords = vector3(1220.6447753906,-3005.4614257813,5.8653602600098)},

   -- Heroin 
   {title="Heroin Collect", colour=1, id=514, coords = vector3(-1907.5427246094,2117.8500976562,127.10972595215)},
   {title="Heroin Process", colour=1, id=514, coords = vector3(2432.4343261719,4970.1743164062,42.347618103027)},
   {title="Heroin Trader", colour=1, id=586, coords = vector3(3586.4919433594,3667.7507324219,33.885871887207)},

    -- Hospital
    {title="Sandy Shores Medical Center", colour=2, id=61, coords = vector3(1828.3488769531,3685.0124511719,34.271068572998)},
    {title="Paleto Bay Medical Center", colour=2, id=61, coords = vector3(-254.51573181152,6332.248046875,32.427242279053)},
    {title="Pillbox Medical Center", colour=2, id=61, coords = vector3(308.89663696289,-592.33825683594,43.28405380249)},
   -- {title="Viceroy Medical Center", colour=2, id=61, coords = vector3(-814.865234375,-1234.9249267578,7.3374218940735)},
	
--	Licence Shop
    {title="Licence Shop", colour=0, id=351, coords = vector3(-533.36059570313,-193.43663024902,38.222400665283)},
    
	 {title="Jewelry Trader", colour=50, id=617, coords = vector3(202.9670715332, -1854.2999267578, 27.00379447937)},
    {title="Bank Robbery", colour=1, id=303, coords = vector3(257.10,220.30,106.28)},

    {title="Diamond Casino & Blackjack", colour=50, id=617, coords = vector3(930.27868652344,37.645889282227,81.095779418945)},
    {title="Prison", colour=39, id=189, coords = vector3(1779.6016845703,2592.501953125,50.549648284912)},
    {title="Large Arms", colour=1, id=150, coords = vector3(5131.583984375,-4620.9389648438,2.2606110572815)},
    {title="Large Arms", colour=1, id=150, coords = vector3(-1115.0303955078,4935.8471679688,218.36589050293)},
    {title="Server Room(BTC Miner)", colour=25, id=354, scale = 1.2, coords = vector3(1126.7713623047,-471.87377929688,66.486640930176)}
}

Citizen.CreateThread(function()
  local blip_scale = 0.9
  for _, info in pairs(blips) do
    if info.scale then
      blip_scale = info.scale
    else
      blip_scale = 0.7
    end
    info.blip = AddBlipForCoord(info.coords.x,info.coords.y)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, blip_scale )
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    end
end)