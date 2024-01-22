--------------------------------------------------------------------------
--									--
--									--
--				AInit_Attr.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading Init_Attr.lua" )


function Init_attr() 
--LG("init_attr", "enter function initattr : " , "\n" ) 
for i = 0, 240, 1 do
	SetChaAttrMax( i, 100000000) 
end 
end 

Init_attr() 

SetChaAttrMax( ATTR_LV		,	130		)	-- Max Level Possible
SetChaAttrMax( ATTR_HP		,	2000000000	)	-- Current HP
SetChaAttrMax( ATTR_SP		,	2000000000	)	-- Current SP
SetChaAttrMax( ATTR_JOB		,	100		)	-- The role of professional
SetChaAttrMax( ATTR_CEXP	,	120080000000	)	-- The current experience
SetChaAttrMax( ATTR_NLEXP	,	120080000000	)	-- The next level of experience required
SetChaAttrMax( ATTR_AP		,	300		)	-- Attribute points
SetChaAttrMax( ATTR_TP		,	250		)	-- Skill points
SetChaAttrMax( ATTR_GD		,	2000000000	)	-- Money
SetChaAttrMax( ATTR_CLEXP	,	120080000000	)	-- The current level of experience
SetChaAttrMax( ATTR_MXHP	,	2000000000	)	-- Maximum hp
SetChaAttrMax( ATTR_MXSP	,	2000000000	)	-- Maximum sp
SetChaAttrMax( ATTR_BSTR	,	130		)	-- Max STR Possible             
SetChaAttrMax( ATTR_BDEX	,	130		)	-- Max ACC Possible            
SetChaAttrMax( ATTR_BAGI	,	130		)	-- Max AGI Possible            
SetChaAttrMax( ATTR_BCON	,	130		)	-- Max CON Possible             
SetChaAttrMax( ATTR_BSTA	,	130		)	-- Max SPR Possible             
SetChaAttrMax( ATTR_BLUK	,	130		)	-- Max LUK Possible        
SetChaAttrMax( ATTR_BMXHP	,	2000000000	)	-- Basic Max HP        
SetChaAttrMax( ATTR_BMXSP	,	2000000000	)	-- Basic maximum SP         
SetChaAttrMax( ATTR_BMNATK	,	13000		)	-- Basic minimum attack   
SetChaAttrMax( ATTR_BMXATK	,	13000		)	-- Basic maximum attack    
SetChaAttrMax( ATTR_BDEF	,	9999		)	-- Basic defense          
SetChaAttrMax( ATTR_BHIT	,	9999		)	-- Basic shooting         
SetChaAttrMax( ATTR_BFLEE	,	9999		)	-- Basic dodge rate          
SetChaAttrMax( ATTR_BMF		,	9999		)	-- Treasure basic rate           
SetChaAttrMax( ATTR_BCRT	,	9999		)	-- Basic crit         
SetChaAttrMax( ATTR_BHREC	,	9999		)	-- Hp recovery speed of the basic    
SetChaAttrMax( ATTR_BSREC	,	9999		)	-- Basic sp recovery rate   
SetChaAttrMax( ATTR_BASPD	,	9999		)	-- Basic attack interval      
SetChaAttrMax( ATTR_BADIS	,	9999		)	-- Basic attacks from the      
SetChaAttrMax( ATTR_BMSPD	,	9999		)	-- The basic speed      
SetChaAttrMax( ATTR_BCOL	,	9999		)	-- Basic resource gathering speed 
SetChaAttrMax( ATTR_MSPD	,	9999		)	-- Speed
SetChaAttrMax( ATTR_LHAND_ITEMV	,	9999		)	-- Addition of the left hand props
SetChaAttrMax( ATTR_BOAT_SHIP	,	100000		)	-- Vessel ID
SetChaAttrMax( ATTR_BOAT_HEADER	,	100000		)	-- Bow type
SetChaAttrMax( ATTR_BOAT_BODY	,	100000		)	-- Hull type
SetChaAttrMax( ATTR_BOAT_ENGINE	,	100000		)	-- Type of boat engines
SetChaAttrMax( ATTR_BOAT_CANNON	,	100000		)	-- Type of ship artillery
SetChaAttrMax( ATTR_BOAT_PART	,	100000		)	-- Type of boat accessories
SetChaAttrMax( ATTR_BOAT_BERTH	,	100000		)	-- Berthing port
SetChaAttrMax( ATTR_BOAT_DBID	,	2000000000	)	-- ID of the owner