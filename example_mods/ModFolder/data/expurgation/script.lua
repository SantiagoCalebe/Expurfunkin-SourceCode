function onBeatHit()
	if curBeat >= 64 and curBeat < 520 then
		if curBeat % 1 == 0 then
			triggerEvent('Add Camera Zoom','','')
		end
	end
end

function onCreate()
	setProperty('skipCountdown', true)
end