QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.QBJobsStatus = false -- true: integrate qb-jobs into the whole of qb-core | false: treat qb-jobs as an add-on resource.
QBShared.Jobs = {} -- All of below has been migrated into qb-jobs
if QBShared.QBJobsStatus then return end
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 30
            },
        
        },
    },
	},
	['police'] = {
		label = 'Met Police',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'PCSO',
                payment = 75
            },
			['1'] = {
                name = 'Police Constable',
                payment = 125
            },
			['2'] = {
                name = 'Sergeant',
                payment = 150
            },
			['3'] = {
                name = 'Inspector',
                payment = 320
            },
			['4'] = {
                name = 'Chief Inspector',
				isboss = true,
                payment = 350
            },
            ['5'] = {
                name = 'Superintendent',
                payment = 435
            },
            ['6'] = {
                name = 'Chief Superintendent',
                payment = 450
            },
            ['7'] = {
                name = 'Chief Of Police',
                payment = 675
            },
            ['8'] = {
                name = 'Commander',
                payment = 550
            },
            ['9'] = {
                name = 'Deputy Assistant Commissioner',
                payment = 650
            },
            ['10'] = {
                name = 'Assistant Commissioner',
                payment = 675
            },
            ['11'] = {
                name = 'Deputy Commissioner',
                payment = 750
            },
            ['12'] = {
                name = 'Commissioner',
                payment = 800
            },
        },
        },
	['NHS'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee Paramedic',
                payment = 55
            },
			['1'] = {
                name = 'Junior Paramedic',
                payment = 100
            },
			['2'] = {
                name = 'Paramedic',
                payment = 150
            },
			['3'] = {
                name = 'Critical Care Paramedic',
                payment = 250
            },
			['4'] = {
                name = 'Junior Doctor',
                payment = 275
            },
            ['5'] = {
                name = 'Doctor',
                payment = 290
            },
            ['6'] = {
                name = 'Senior Doctor',
                payment = 300
            },
            ['7'] = {
                name = 'Honorable Doctor',
                payment = 350
            },
            ['8'] = {
                name = 'HEMS',
                payment = 200
            },
            ['9'] = {
                name = 'HEMS Deputy Director',
                payment = 350
            },
            ['10'] = {
                name = 'HEMS Director' ,
                payment = 370
            },
            ['11'] = {
                name = 'Academy Director',
                payment = 420
            },
            ['12'] = {
                name = 'Assistant Chief Medical Director',
                payment = 575
            },
            ['13'] = {
                name = 'Deputy Chief Medical Director',
                payment = 625
            },
            ['14'] = {
                name = 'Chief Medical Director',
                payment = 700
     
            },       
        },   
    },   
	['Reggie And Bons Real Estate Company'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee Agent',
                payment = 60
            },
			['1'] = {
                name = 'Salesman',
                payment = 90
            },
			['2'] = {
                name = 'Estate Agent',
                payment = 105
            },
			['3'] = {
                name = 'Broker',
                payment = 145
            },
            ['4'] = {
                name = 'Assistant Manager',
                payment = 175
            },
			['5'] = {
                name = 'Manager',
				isboss = true,
                payment = 195
            },
        },
    },
['Uber'] = {
	label = 'Taxi',
		defaultDuty = true,
	offDutyPay = false,
		grades = {
            ['0'] = {
               name = 'Trainee Driver',
               payment = 25
            },
			['1'] = {
                name = 'Driver',
                payment = 45
         },
			['2'] = {
                name = 'Experienced Driver',
                payment = 75
            },
			['3'] = {
                name = 'Uber Luxe Driver',
                payment = 150               
           },
			['4'] = {
                name = 'Chauffer',
                payment = 100
            },
			['5'] = {
               name = 'Manager',
				isboss = true,
               payment = 200
            },
   --     },
--	},
 --   ['bus'] = {
--		label = 'Bus',
	--	defaultDuty = true,
	--	offDutyPay = false,
--		grades = {
   --         ['0'] = {
  --              name = 'Driver',
 --               payment = 50
 --           },
--		},
	},
	['Premium Deluxe Motorsport'] = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 35
            },
			['1'] = {
                name = 'Showroom Sales',
                payment = 50
            },
			['2'] = {
                name = 'Salesman',
                payment = 60
            },
			['3'] = {
                name = 'Finance',
                payment = 85
            },
            ['4'] = {
                name = 'Assistant Manager',
                payment = 125
            },
			['5'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['AA'] = {
		label = 'Mechanic',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee Mechanic',
                payment = 35
            },
			['1'] = {
                name = 'Mechanic',
                payment = 75
            },
			['2'] = {
                name = 'Senior Mechanic',
                payment = 100
            },
			['3'] = {
                name = 'Experienced Mechanic',
                payment = 125
            },
            ['4'] = {
                name = 'Assistant Manager',
                payment = 350
            },
			['5'] = {
                name = 'Manager',
				isboss = true,
                payment = 375
            },
        },
	},
	['Blackout Legal Services'] = {
		label = 'Law Firm',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Trainee Solicitor',
                payment = 80
            },
            ['1'] = {
                name = 'Solicitor',
                payment = 135
            },
            ['2'] = {
                name = 'Senior Solicitor',
                payment = 205
            },
            ['3'] = {
                name = 'Experienced Solicitor',
                payment = 285
            },
            ['4'] = {
                name = 'Barrister',
                payment = 455
            },
            ['5'] = {
                name = 'Associate',
                payment = 345
            },
            ['6'] = {
                name = 'Leading Solicitor',
                payment = 500
            },
            ['7'] = {
                name = 'Judge',
                payment = 550
            },
            ['8'] = {
                name = 'Deputy Head Solicitor',
                payment = 650
            },
            ['9'] = {
                name = 'Head Solicitor',
                isboss = true,
                payment = 750
            },
        },
	},
}
