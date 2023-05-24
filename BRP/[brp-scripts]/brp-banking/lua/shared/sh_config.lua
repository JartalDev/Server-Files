SimpleBanking = SimpleBanking or {} 
SimpleBanking.Config = SimpleBanking.Config or {}


SimpleBanking.Config["Days_Transaction_History"] = 7 -- How many days should the transaction history go back in the bank?

SimpleBanking.Config["business_ranks"] = { -- what ranks can see the society accounts in the menu, and deposit/withdraw/transfer from them?
    ['mayor'] = true,
    ['Manager'] = true,
    ['owner'] = true,
    ['chief'] = true,
    ['director'] = true,
}

SimpleBanking.Config["business_ranks_overrides"] = {
    ['police'] = {
        ['Commissioner'] = true,
    },
    ['nhs'] = {
        ['Chief Medical Director'] = true,
    },
    ['Reggie And Bons Real Estate Company'] = {
        ['Manager'] = true,
    },
    ['Premium Deluxe Motorsport'] = {
        ['Manager'] = true,
    },
    ['AA'] = {
        ['Manager'] = true,
    },
    ['Blackout Legal Services'] = {
        ['Head Solicitor'] = true,
    },
    ['Uber'] = {
        ['Manager'] = true,
    },
}

SimpleBanking.Config["gang_ranks"] = {
    ['boss'] = true,

}

SimpleBanking.Config["gang_ranks_overrides"] = {

}

SimpleBanking.Config["acc_using"] = "personal"