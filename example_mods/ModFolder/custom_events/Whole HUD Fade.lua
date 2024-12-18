function onEvent(name, value1, value2)
if name == "Whole HUD Fade" then
if value1 == '0' or value1 == '' then
	doTweenAlpha('holaHUD', 'camHUD', 1, 0.7, 'linear')
end
if value1 == '1' then
	doTweenAlpha('adiosGauge', 'camHUD', 0, 0.7, 'linear')
end
end
end