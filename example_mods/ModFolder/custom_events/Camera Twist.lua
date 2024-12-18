local enable = false
local angle = 1
local intencity2 = 0.6
local intencity = 0.6
local speed = 0

function onEvent(name,v1,v2)
    if name == "Camera Twist" then
        if tonumber(v1) ~= 0 and tonumber(v1) ~= nil then
            intencity = tonumber(v1) + 0.1
        else
            disableBeat()
            return
        end
        if tonumber(v2) ~= 0 and tonumber(v1) ~= nil then
            intencity2 = tonumber(v2)
            setProperty('camHUD.height',screenHeight + (angle * 35))
            setProperty('camHUD.width',screenWidth + (angle * 30))
        else
            disableBeat()
            return
        end
        enable = true
    end
end
function disableBeat()
    if enable then
        doTweenY('camHUDYBack','camHUD',0,1,'sineOut')
        doTweenAngle('camHUDBackAngle','camHUD',0,1,'sineInOut')
        setProperty('camHUD.height',screenHeight)
        setProperty('camHUD.width',screenWidth)
        enable = false
        intencity = 0.6
        intencity2 = 0.8
    end
end
function onBeatHit()
    if enable then
        speed = stepCrochet*0.002
        local speed2 = stepCrochet*0.001
        local curAngle = angle*intencity
        local camXAngle = -curAngle*3
		if curBeat % 2 ~= 0 then
			curAngle = -curAngle
		end
        cancelTween('camHUDBackAngle')
        cancelTween('camHUDYBack')
        setProperty('camHUD.angle',curAngle*(intencity/2))
        doTweenAngle('camHUDAngleGo','camHUD',curAngle,speed2,'circOut')
        doTweenY('camHUDYGo','camHUD',-12 * intencity2,speed,'circOut')
        doTweenX('camHUDXGo','camHUD',curAngle,speed2,'linear')
        runTimer('camYBackEvent',speed)
    end
end
function onTimerCompleted(tag)
    if tag == 'camYBackEvent' then
        doTweenY('camHUDYBack','camHUD',0,speed,'sineIn')
        doTweenAngle('camHUDBackAngle','camHUD',0,speed,'sineOut')
    end
end