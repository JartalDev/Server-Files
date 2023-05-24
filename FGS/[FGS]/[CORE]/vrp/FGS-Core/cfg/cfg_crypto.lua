cryptocfg = {}

cryptocfg.coords = {1722.4333496094,4684.9692382812,16.317060470581}
cryptocfg.enter = {1126.7713623047,-471.87377929688,66.486640930176}
cryptocfg.exit = {1725.7144775391,4684.2041015625,16.317060470581}
cryptocfg.systems = {
    {id = 1, name = "Starter Miner",  gpu = '1050-TI', cpu = 'Intel i5-3570', amountPerMin = 0.000005, stringedFormat = '0.000005', price = 1000000},
    {id = 2, name = "Bitcoin Miner 1",  gpu = '1060', cpu = 'AMD Ryzen 5 3600X', amountPerMin = 0.000015, stringedFormat = '0.000013', price = 2000000},
    {id = 3, name = "Bitcoin Miner 2",  gpu = '1080', cpu = 'AMD Ryzen 7 3700X', amountPerMin = 0.000025, stringedFormat = '0.000023', price = 3000000},
    {id = 4, name = "Bitcoin Miner 3", gpu = '2060', cpu = 'AMD Ryzen 9 3900X', amountPerMin = 0.000035, stringedFormat = '0.000028', price = 5000000}
}

return cryptocfg