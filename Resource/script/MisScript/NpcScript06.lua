--------------------------------------------------------------------------
--									--
--									--
--				NPCScript06.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading NPCScript06.lua" )


--Custom Npc--

-------------------------------------------------------
--------------------- Job Changer ---------------------
-------------------------------------------------------
JobCh = {}
JobCh.Money = {}
JobCh.Money.First = 5000	-- Money needed for first class advancement.
JobCh.Money.Second = 50000	-- Money needed for second class advancement.
JobCh.Level = {}
JobCh.Level.First = 9		-- Level needed for first class advancement.
JobCh.Level.Second = 40		-- Level needed for second class advancement.

function JobChanger()



	Talk(1, "Class Trainer: You want to become a Swordsman?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)
	TriggerAction(1, SetProfession, 1)
	TriggerFailure(1, JumpPage, 10)
	Text(1, "Swordsman", MultiTrigger, GetMultiTrigger(), 1)

	Talk(2, "Class Trainer: You want to become a Champion?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.Second - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.Second, JobCh.Money.Second)
	TriggerAction(1, TakeMoney, JobCh.Money.Second)
	TriggerAction(1, SetProfession, 8)
	TriggerFailure(1, JumpPage, 11)
	Text(2, "Champion", MultiTrigger, GetMultiTrigger(), 1)

	Talk(3, "Class Trainer: You want to change class?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 1)
	TriggerFailure(1, JumpPage, 10)
	Text(3, "Swordsman", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 2)
	TriggerFailure(1, JumpPage, 10)
	Text(3, "Hunter", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 4)
	TriggerFailure(1, JumpPage, 10)
	Text(3, "Explorer", MultiTrigger, GetMultiTrigger(), 1)

	Talk(4, "Class Trainer: You want to change class?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 1)
	TriggerFailure(1, JumpPage, 10)
	Text(4, "Swordsman", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 2)
	TriggerFailure(1, JumpPage, 10)
	Text(4, "Hunter", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 4)
	TriggerFailure(1, JumpPage, 10)
	Text(4, "Explorer", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 5)
	TriggerFailure(1, JumpPage, 10)
	Text(4, "Herbalist", MultiTrigger, GetMultiTrigger(), 1)

	Talk(5, "Class Trainer: You want to change class?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 4)
	TriggerFailure(1, JumpPage, 10)
	Text(5, "Explorer", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.First - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.First, JobCh.Money.First)
	TriggerAction(1, TakeMoney, JobCh.Money.First)	
	TriggerAction(1, SetProfession, 5)
	TriggerFailure(1, JumpPage, 10)
	Text(5, "Herbalist", MultiTrigger, GetMultiTrigger(), 1)

	Talk(6, "Class Trainer: You want to change class?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.Second - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.Second, JobCh.Money.Second)
	TriggerAction(1, TakeMoney, JobCh.Money.Second)
	TriggerAction(1, SetProfession, 9)
	TriggerFailure(1, JumpPage, 11)
	Text(6, "Crusader", MultiTrigger, GetMultiTrigger(), 1)

	Talk(7, "Class Trainer: You want to change class?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.Second - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.Second, JobCh.Money.Second)
	TriggerAction(1, TakeMoney, JobCh.Money.Second)
	TriggerAction(1, SetProfession, 12)
	TriggerFailure(1, JumpPage, 11)
	Text(7, "Sharpshooter", MultiTrigger, GetMultiTrigger(), 1)

	Talk(8, "Class Trainer: You want to change class?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.Second - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.Second, JobCh.Money.Second)
	TriggerAction(1, TakeMoney, JobCh.Money.Second)
	TriggerAction(1, SetProfession, 16)
	TriggerFailure(1, JumpPage, 11)
	Text(8, "Voyager", MultiTrigger, GetMultiTrigger(), 1)

	Talk(9, "Class Trainer: You want to change class?")
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.Second - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.Second, JobCh.Money.Second)
	TriggerAction(1, TakeMoney, JobCh.Money.Second)
	TriggerAction(1, SetProfession, 13)
	TriggerFailure(1, JumpPage, 11)
	Text(9, "Cleric", MultiTrigger, GetMultiTrigger(), 1)
	InitTrigger()
	TriggerCondition(1, LvCheck, ">", JobCh.Level.Second - 1)
	TriggerCondition(1, HasMoney, JobCh.Money.Second, JobCh.Money.Second)
	TriggerAction(1, TakeMoney, JobCh.Money.Second)
	TriggerAction(1, SetProfession, 14)
	TriggerFailure(1, JumpPage, 11)
	Text(9, "Seal Master", MultiTrigger, GetMultiTrigger(), 1)

	Talk(10, "Class Trainer: you need to be Lv"..JobCh.Level.First.." and have "..JobCh.Money.First.." to do First Class Advancement.")
	Text(10, "Leave", CloseTalk)

	Talk(11, "Class Trainer: you need to be Lv"..JobCh.Level.Second.." and have "..JobCh.Money.Second.." to do Second Class Advancement.")
	Text(11, "Leave", CloseTalk)

	Talk(12, "Class Trainer: Why are you bothering? You already have Second Class Advancement!")
	Text(12, "Leave", CloseTalk)

	InitTrigger()
	-- Carsise Swordman
	TriggerCondition(1, PfEqual, 0)
	TriggerCondition(1, IsCategory, 2)
	TriggerAction(1, JumpPage, 1)
	-- Carsise Champion
	TriggerCondition(2, PfEqual, 1)
	TriggerCondition(2, IsCategory, 2)
	TriggerAction(2, JumpPage, 2)
	-- Lance: Swordsman/Hunter/Explorer
	TriggerCondition(3, PfEqual, 0)
	TriggerCondition(3, IsCategory, 1)
	TriggerAction(3, JumpPage, 3)
	-- Phyllis: Swordsman/Hunter/Exporer/Herbalist
	TriggerCondition(4, PfEqual, 0)
	TriggerCondition(4, IsCategory, 3)
	TriggerAction(4, JumpPage, 4)
	-- Ami: Explorer/Herbalist
	TriggerCondition(5, PfEqual, 0)
	TriggerCondition(5, IsCategory, 4)
	TriggerAction(5, JumpPage, 5)
	-- Lance/Phyllis: Crusader
	TriggerCondition(6, PfEqual, 1)
	TriggerAction(6, JumpPage, 6)
	-- Lance/Phyllis: Sharpshooter
	TriggerCondition(7, PfEqual, 2)
	TriggerAction(7, JumpPage, 7)
	-- Lance/Phyllis/Ami: Voyager
	TriggerCondition(8, PfEqual, 4)
	TriggerAction(8, JumpPage, 8)
	-- Phyllis/Ami: Cleric/Seal Master
	TriggerCondition(9, PfEqual, 5)
	TriggerAction(9, JumpPage, 9)
	TriggerAction(10, JumpPage, 12)
	Start(GetMultiTrigger(), 10)
end