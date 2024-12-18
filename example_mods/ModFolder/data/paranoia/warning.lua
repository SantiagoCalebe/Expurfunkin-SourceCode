showWarning = true
touch = false


imagelocal = '/Warn'
timerGo = 0.2 
ease = 'linear'
tweenT = 1 


function onStartCountdown()
if showWarning then
showWarning = false
makeLuaSprite('WarningText', imagelocal, 0, 0)
addLuaSprite('WarningText', false)
setObjectCamera('WarningText', 'camOther')
return Function_Stop;
end
return Function_Continue;
end

function onTimerCompleted(tag)
if tag == 'a' then
doTweenAlpha('warn', 'WarningText', 0, tweenT, ease)
startCountdown()
end
end

function onUpdate()
if mouseClicked() == true and touch == false then
touch = true
runTimer('a', timeGo)
end
end