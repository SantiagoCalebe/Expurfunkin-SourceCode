function onEvent(name, value1, value2)
    if name == "movewindow" then
	setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") + value1)
	end
	setPropertyFromClass("openfl.Lib", "application.window.y", getPropertyFromClass("openfl.Lib", "application.window.y") + value2)
end
--hey if you're using this event do credit me https://gamebanana.com/members/2069141