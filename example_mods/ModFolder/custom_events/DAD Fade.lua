-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'BF Fade' then
		duration = tonumber(value1);
		if duration < 0 then
			duration = 0;
		end

		targetAlpha = tonumber(value2);
		if duration == 0 then
			setProperty('dad.alpha', targetAlpha);
			setProperty('iconP1.alpha', targetAlpha);
		else
			doTweenAlpha('dadFadeEventTween', 'dad', targetAlpha, duration, 'linear');
			doTweenAlpha('iconDadFadeEventTween', 'iconP2', targetAlpha, duration, 'linear');
		end
		--debugPrint('Event triggered: ', name, duration, targetAlpha);
	end
end