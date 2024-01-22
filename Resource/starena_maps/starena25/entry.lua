--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

SetTeamFightMapName("starena3") 

function config_entry(entry) 

end 

function after_create_entry(entry) 
    

end

function after_destroy_entry_starena23(entry)
 

end

function after_player_login_starena23(entry, player_name)
    

end


--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_starena23( role, copy_mgr )


end

function begin_enter_starena23(role, copy_mgr) 
	
end 
