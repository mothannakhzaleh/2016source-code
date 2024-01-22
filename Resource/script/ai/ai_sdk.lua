--------------------------------------------------------------------------
--									--
--									--
--				ai_sdk.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading Ai_Sdk.lua" )


dofile(GetResPath("script/help/help.lua"))
dofile(GetResPath("script/ai/ai_define.lua"))


function reload_ai_sdk()
  dofile(GetResPath("script/ai/ai.lua"))
end


function is_pos_valid(cha, x, y)
  can_move = IsPosValid(cha, x, y)
  if can_move==0 then
    AI_AI_SDK_LUA_000001 = GetResString("AI_AI_SDK_LUA_000001")
    AI_AI_SDK_LUA_000002 = GetResString("AI_AI_SDK_LUA_000002")
    LG("lua_ai", AI_AI_SDK_LUA_000002, x, " ", y, AI_AI_SDK_LUA_000001)
  end
  return can_move
end


function find_target(cha, flag)
  x,y = GetChaPos(cha)
  vision = GetChaVision(cha)
  return GetChaByRange(cha, x, y, vision, flag)
end


function clear_target(c)
  AI_AI_SDK_LUA_000003 = GetResString("AI_AI_SDK_LUA_000003")
  LG("lua_ai", AI_AI_SDK_LUA_000003)
  SetChaTarget(c, 0)
  SetChaPatrolState(c, 0)
end


function move_to(cha, target, flag)
  if is_near(cha, target, 250)==1 then
     return 2
  end
  
  x, y = GetChaPos(target)
  
  rx = 110 - Rand(220)
  ry = 110 - Rand(220)
  x = x + rx
  y = y + ry
  
  if is_pos_valid(cha, x, y)==0 then
    return 0 
  end 
  
  ChaMove(cha, x, y)
  
  return 1
end


function star_move_to(cha, target)
	local host_cha = GetChaHost(cha)
	local  x1, y1 = GetChaPos(host_cha)
	
	if is_near_pos(cha, x1, y1, 200)==1 then
		return 1
	end
	
	local rx = x1 + 200 - Rand(200 * 2)
	local ry = y1 + 200 - Rand(200 * 2)
	
	if is_pos_valid(cha, x1, y1)==0 then
	    return 0 
	end 
	
	ChaMove(cha, rx, ry)
	
	return 1
end


function star_delete_to(cha)
	local life = 1
	SetChaLifeTime( cha, life )
	return 1
end


function flee(cha, target)
   x, y = GetChaFacePos(target)
   ChaMove(cha, x, y)
end


function rand_move(cha, range)
  x, y = GetChaPos(cha)
  rx = x + range - Rand(range * 2)
  ry = y + range - Rand(range * 2)
  if is_pos_valid(cha, x, y)==0 then return end
  ChaMove(cha, rx, ry)
end


function birth_rand_move(cha, range)
  local move_flag = Rand(20)
  
  if move_flag > 1 then return end
  
  x, y = GetChaSpawnPos(cha)
  rx = x + range - Rand(range * 2)
  ry = y + range - Rand(range * 2)
  if is_pos_valid(cha, x, y)==0 then return end
  ChaMove(cha, rx, ry)
end


function is_near(cha, target, r)
  if target==nil or target==0 then 
     LG("ai_error", "is_near() target = "..target)
     return 0
  end
  local x, y = GetChaPos(cha)
  local tx, ty = GetChaPos(target)
  if ((tx - x) * (tx - x) + (ty - y) * (ty - y)) < (r * r) then
    return 1
  end
  return 0
end


function is_near_pos(cha, tx, ty, r)
  local x, y = GetChaPos(cha)
  local dis = math.sqrt((tx - x) * (tx - x) + (ty - y) * (ty - y))
  if dis < r then
    return 1
  end
  return 0
end


function get_distance(c1, c2)
    local x, y = GetChaPos(c1)
    local tx, ty = GetChaPos(c2)
    return math.sqrt((tx - x) * (tx - x) + (ty - y) * (ty - y))
end


function is_chase(cha)
   
   if GetChaTypeID(cha)==350 then return 1 end

   local chase_r = GetChaChaseRange(cha)
   AI_AI_SDK_LUA_000004 = GetResString("AI_AI_SDK_LUA_000004")
   LG("lua_ai", AI_AI_SDK_LUA_000004, chase_r)
   if chase_r==0 then
     return 1
   end
   
   local x, y = GetChaSpawnPos(cha)
   
   local host = GetChaHost(cha)

   if host~=nil then
       x, y = GetChaPos(host)
   end
   
   local now_x, now_y = GetChaPos(cha)
   
   local dis = (now_x - x) * (now_x - x) + (now_y - y) * (now_y - y)
   AI_AI_SDK_LUA_000005 = GetResString("AI_AI_SDK_LUA_000005")
   LG("lua_ai", AI_AI_SDK_LUA_000005, dis)
   if dis > chase_r * chase_r then
     
     
     if is_patrol(cha)==1 then
        local x, y = GetChaPatrolPos(cha)
        local dis2 =  (now_x - x) * (now_x - x) + (now_y - y) * (now_y - y)
        if dis2 < chase_r * chase_r then
           return 1
        end
     end    

     return 0
   
   
   else
     return 1
   end
   return 0
end


function is_cha_can_summon(c1)
 	
    if GetChaPatrolState(c1)>=10 then
    	return 0
  	end

	local type_id = GetChaTypeID(c1)
	if ai_flag_summon[type_id]~=nil then 
		return 1
	end 
  
   	return 0
end


function is_cha_can_pick(c)
	return 0
end


function summon_child(c, t)
   if Rand(25) > 1 then return end
   chaType = GetChaTypeID(c)
   x, y = GetChaPos(c)
   if chaType==206 then
       AI_AI_SDK_LUA_000006 = GetResString("AI_AI_SDK_LUA_000006")
       LG("lua_ai", AI_AI_SDK_LUA_000006)
       nx = x + 100 - Rand(200)
       ny = y + 100 - Rand(200)
       cha1 = CreateCha(103, nx, ny, 90, 1000)
       SetChaTarget(cha1, t)
       
       nx = x + 100 - Rand(200)
       ny = y + 100 - Rand(200)
       cha2 = CreateCha(103, nx, ny, 145, 1000)
       SetChaTarget(cha2, t)
       
       nx = x + 100 - Rand(200)
       ny = y + 100 - Rand(200)
       cha3 = CreateCha(103, nx, ny, 180, 1000)
       SetChaTarget(cha3, t)
   end
end


function select_skill(c)
   
   local num = GetChaSkillNum(c) - 1
   local s = 0
   local e = 0
   local r = Rand(100)
   local skill_id = 0
   for i = 0, num do          
       skill_id, ratio = GetChaSkillInfo(c, i)
       local e = s + ratio
       if r > s and r<=e then
          break
       end
       s = s + ratio
   end
   return skill_id
end


function CreatePatrolCha(t_id, x, y, dir, relive_time, px, py)
    local cha = CreateCha(t_id, x, y, dir, relive_time)
    SetChaPatrolPos(cha, px, py)
    return cha
end


function summon_monster(cnn, t)
  AI_AI_SDK_LUA_000007 = GetResString("AI_AI_SDK_LUA_000007")
  LG("lua_ai", AI_AI_SDK_LUA_000007, GetChaTypeID(cnn));
  SetChaEmotion(cnn, 10)
  SetChaPatrolState(cnn, 10)
  local x,y = GetChaPos(cnn)
  local m_type = GetChaTypeID(cnn)
  local m = {}
  m[0], m[1],m[2], m[3] = GetChaSetByRange(cnn, x, y, 800, m_type)
  for id, monster in m do
    if monster~=nil then
       name = GetChaDefaultName(monster)
       AI_AI_SDK_LUA_000008 = GetResString("AI_AI_SDK_LUA_000008")
       LG("lua_ai", name, AI_AI_SDK_LUA_000008, GetChaDefaultName(t))
       local skill_id = select_skill(monster)
       SetChaTarget(monster, t)
       ChaUseSkill(monster, t, skill_id)
       SetChaEmotion(monster, 11)
       SetChaPatrolState(monster, 11)
    end
  end
end


function tempt_monster(cha, m_type)
  AI_AI_SDK_LUA_000007 = GetResString("AI_AI_SDK_LUA_000007")
  LG("lua_tempt", AI_AI_SDK_LUA_000007, GetChaTypeID(cha));
  x,y = GetChaPos(cha)
  local m = {}
  m[0], m[1], m[2], m[3] = GetChaSetByRange(cha, x, y, 900, m_type)
  for id, monster in m do
    if monster~=nil then
       local name = GetChaDefaultName(monster)
       AI_AI_SDK_LUA_000009 = GetResString("AI_AI_SDK_LUA_000009")
       LG("lua_tempt", name, AI_AI_SDK_LUA_000009, GetChaDefaultName(cha))
       SetChaTarget(monster, cha)
       local skill_id = select_skill(monster)
       ChaUseSkill(monster, cha, skill_id)
       SetChaEmotion(monster, 11)
    end
  end
end


function is_patrol(c)
  local px, py = GetChaPatrolPos(c)
  if px==0 then return 0 end
  return 1
end


function is_moving_back(c)
   if GetChaPatrolState(c)==9 then
       return 1
   end
   return 0
end


function set_moving_back(c, bFlag)
    if bFlag==1 then
       SetChaPatrolState(c, 9)
    else
       if is_moving_back(c)==1 then
          SetChaPatrolState(c, 0)
       end
    end
end