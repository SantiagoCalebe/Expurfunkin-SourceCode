strings = {"YOU AREN'T HANK", "WHERE IS HANK", "HANK???", "WHO ARE YOU", "WHERE AM I", "THIS ISN'T RIGHT", "MIDGET", "SYSTEM UNRESPONSIVE", "WHY CAN'T I KILL?????"}
missStrings = {"TERRIBLE","WASTE","MISCALCULTED","PREDICTED","FAILURE","DISGUSTING","ABHORRENT","FORESEEN","CONTEMPTIBLE","PROGNOSTICATE","DISPICABLE","REPREHENSIBLE"}
saidString = false
stringTimer = 0.2

function onCreatePost()
    precacheSound('staticSound')
    makeLuaSprite("TrickyOverlay", "", 0, 0)
	makeGraphic("TrickyOverlay", 1280, 720, "FF0000")
	setObjectCamera("TrickyOverlay", "camOther")
	addLuaSprite("TrickyOverlay")
    makeLuaSprite("TrickyOverlay2", "stage/TrickyStatic", 0, 0)
	setObjectCamera("TrickyOverlay2", "camOther")
	addLuaSprite("TrickyOverlay2")

    makeLuaText("trickyString", "", 1000, 1500, 1000)
    setTextColor("trickyString", "FF0000")
    setTextFont("trickyString", "impact.ttf")
    setTextBorder("trickyString", 0, "0x00000000")
    setTextSize("trickyString", 96)
    setTextAlignment("trickyString", "center")
    setObjectCamera("trickyString", "camGame")
    addLuaText("trickyString")
    enableTextMove('trickyString')

    setProperty('trickyString.alpha', 0)
    setProperty('TrickyOverlay.alpha', 0)
    setProperty('TrickyOverlay2.alpha', 0)
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    local enemyHitRoll = math.random(1, 80)
    if enemyHitRoll >= 70 then
        if saidString == false then 
            playSound('staticSound')
            stringRoll = getRandomInt(1, #strings)
            curString = strings[stringRoll]
            setTextString("trickyString", curString)
            setProperty('trickyString.alpha', 1)
            setStringAngle = math.random(-5,5)
            setProperty('trickyString.angle', setStringAngle)
            saidString = true
            runTimer('stringReset', 0.2)
            setPropertyFromClass("openfl.Lib", "application.window.title", curString) 
            setProperty('trickyString.alpha', 1)
            setProperty('TrickyOverlay.alpha', 0.35)
            setProperty('TrickyOverlay2.alpha', 0.35)
        end
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    local missRoll = math.random(1, 40)
    if missRoll >= 30 then
        if saidString == false then 
            playSound('staticSound')
            stringRoll = getRandomInt(1, #strings)
            curString = missStrings[stringRoll]
            setTextString("trickyString", curString)
            setProperty('trickyString.alpha', 1)
            setStringAngle = math.random(-5,5)
            setProperty('trickyString.angle', setStringAngle)
            saidString = true
            runTimer('stringReset', 0.2)
            setPropertyFromClass("openfl.Lib", "application.window.title", curString)
            setProperty('trickyString.alpha', 1)
            setProperty('TrickyOverlay.alpha', 0.35)
            setProperty('TrickyOverlay2.alpha', 0.35)
        end
    end
end


function onTimerCompleted(tag)
    if tag == "stringReset" then
        saidString = false
        setProperty('trickyString.alpha', 0)
        setProperty('TrickyOverlay.alpha', 0)
        setProperty('TrickyOverlay2.alpha', 0)
        setPropertyFromClass("openfl.Lib", "application.window.title", "Expurfunkin' 4.0 - Twitter Expurgation")
    end
end


local trickyStringX={}
local trickyStringY={}
function enableTextMove(var)
	trickyStringX[var]=getProperty(var..'.x')
	trickyStringY[var]=getProperty(var..'.y')
end

function updateTextPos(var, scroll)
	setProperty(var..'.x', (trickyStringX[var]-getProperty('camGame.target.x'))*scroll )
	setProperty(var..'.y', (trickyStringY[var]-getProperty('camGame.target.y'))*scroll )
end

function onUpdate()
	updateTextPos('trickyString', 1)
end