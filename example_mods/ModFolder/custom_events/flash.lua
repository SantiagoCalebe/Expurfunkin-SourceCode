local flashCount = 0
function onCreate()
    makeLuaSprite('flashEvent',nil)
    makeGraphic('flashEvent',screenWidth,screenHeight,'FFFFFF')
    setScrollFactor('flashEvent',0,0)
end
function onEvent(name,v1,v2)
    if name == 'flash' then
        
    end
end
function doFlash(color,camera,time,easing)
    if camera == nil then
        camera = 'game'
    end
    if easing == nil then
        easing = 'linear'
    end
    local scale = math.abs(1 - (1 - getProperty('camGame.zoom')))*6
    setProperty('flashEvent.x',-300*scale)
    scaleObject('flashEvent',scale,scale)
    setProperty('flashEvent.y',-200*scale)
    setProperty('flashEvent.color',getColorFromHex(color))
    setObjectCamera('flashEvent',camera)
    addLuaSprite('flashEvent',true)
    doTweenAlpha('flashEventAlpha','flashEvent',0,time,easing)
    setObjectORder('flashEvent',99999)
end
function onTweenCompleted(tag)
    if string.find(tag,'flashEvent',0,true) then
        removeLuaSprite(string.gsub(tag,'Alpha',''),false)
    end
end