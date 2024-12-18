luaDebugMode = true

totalBeat = 0
timeBeat = 0

gameZ = 0.015
hudZ = 0.015

gameShake = 0
hudShake = 0

shakeTime = false

function isNaN(num)
	return num ~= num
end

function onEvent(n, v1, v2)
    if n == "Camera Zoom Chain" then
		local split1 = stringSplit(v1, ",")
		gameZ = tonumber(split1[1])
		hudZ = tonumber(split1[2])

		if #split1 == 4 then
			gameShake = tonumber(split1[3])
			hudShake = tonumber(split1[4])
			shakeTime = true
		else
			shakeTime = false
		end

		local split2 = stringSplit(v2, ",")
		local toBeat = tonumber(split2[1])
		if isNaN(toBeat) then
			toBeat = 4
		end
		local tiBeat = tonumber(split2[2])
		if isNaN(tiBeat) then
			tiBeat = 1
		end

		totalBeat = toBeat
		timeBeat = tiBeat
	end
end

function onBeatHit()
	if totalBeat > 0 then
		if curBeat % timeBeat == 0 then
			triggerEvent("Add Camera Zoom", tostring(gameZ), tostring(hudZ))
			totalBeat = totalBeat - 1

			if shakeTime then
				triggerEvent(
					"Screen Shake",
					(((1 / (bpm / 60)) / 2) * timeBeat) + ', ' + gameShake,
					(((1 / (bpm / 60)) / 2) * timeBeat) + ', ' + hudShake
				)
			end
		end
	end
end