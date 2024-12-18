function onEvent(name, value1, value2)
	if name == 'Replace stage layer' then
		if value1 == '1' then
			removeLuaSprite('twitter')
			addLuaSprite('twitter2')
		end 
	end
end