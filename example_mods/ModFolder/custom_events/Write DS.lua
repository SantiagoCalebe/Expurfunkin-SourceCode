
--Not used Haxe script because he don't have FlxText.
local paperTime = -1

local lastMousePosX = 0
local lastMousePosY = 0
local circlesCount = 0

local canDraw = false
local nerf = true

function onCreatePost()
    addHaxeLibrary('FlxColor')
    addHaxeLibrary('FlxSpriteUtil','flixel.util')
    addHaxeLibrary('Math','')-- For 0.6.3
    addHaxeLibrary('Std','')-- For 0.6.3
    
    
    makeLuaSprite('paper','mario/piracy/paper',5,not downscroll and -300 or screenHeight + 100)
    scaleObject('paper',2,2)
    setObjectCamera('paper','other')
    setProperty('paper.antialiasing',false)
    addLuaSprite('paper',false)
    updateHitbox('paper')


    --[[
    makeLuaText('paperText','',getProperty('camOther.width'),0,0)
    setProperty('paperText.visible',false)
    setTextSize('paperText',100)
    setProperty('paperText.color',getColorFromHex('808080'));
    setTextFont('paperText','arial-rounded-mt-bold.ttf')
    setTextBorder('paperText',0,'808080')
    setObjectCamera('paperText','other')
    addLuaText('paperText',false)
  

    makeLuaText('paperTime','',getProperty('camOther.width'),0,0)
    setProperty('paperTime.visible',false)
    setObjectCamera('paperTime','other')
    addLuaText('paperTime',false)
    ]]

    makeLuaSprite('mousePoint','cursor2',0,0)
    addLuaSprite('mousePoint',true)
    setObjectCamera('mousePoint','other')

    makeLuaSprite('paperSpotlight','mario/piracy/spotlight',-70,-60)
    setObjectCamera('paperSpotlight','other')
    setProperty('paperSpotlight.flipY',not downscroll)
    setProperty('paperSpotlight.alpha',0.001)
    scaleObject('paperSpotlight',2,2)
    --updateHitbox('paperSpotlight')
    addLuaSprite('paperSpotlight',true)
    precacheSound('teethslam')
    runHaxeCode([[
    
        var paperTime = new FlxText(0,0,]]..getProperty('paper.width')..[[);
        game.insert(10,paperTime);
        paperTime.cameras = [game.camOther];
        paperTime.visible = false;
        
        paperTime.size = 10;
        paperTime.alignment = "center";
        paperTime.color = FlxColor.BLACK;
        
        paperTime.borderSize = 3;
        
        setVar('paperTime',paperTime);

        var paperText = new FlxText(0,0);
        paperText.antialiasing = false;
        game.insert(10,paperText);
        paperText.cameras = [game.camOther];
        
        paperText.visible = false;
        paperText.font = Paths.font('arial-rounded-mt-bold.ttf');
        paperText.color = 0xFF808080;
        paperText.borderSize = 0;
        paperText.scale.set(2,2);
        paperText.size = 50;
        paperText.fieldWidth = 240;
        paperText.alignment = "center";
        
        game.add(paperText);
        setVar('paperText',paperText);
    ]])
end

function onEvent(name,v1,v2)
    if name == 'Write DS' then
        if v2 ~= '' then
            local textColor = '808080'
            screenCenter('paper','x')
            cancelTween('paperYExit')
            setProperty('paperText.text',v2)
            
            updateHitbox('paperText')
            local time = tonumber(v1)
            if time == nil then
                time = 20
            end
            paperTime = time/2


            if(v2 == 'criminal') then
                textColor = 'FF7F7F';
            end
            setProperty('paper.x',getProperty('camOther.width')/2 - 245)
            setProperty('paperText.color',getColorFromHex(textColor))
            doTweenY('paperYEnter','paper',not downscroll and 0 or screenHeight - 200,stepCrochet*0.012,'quadOut')
            removeCircles()

        end
    elseif name == 'Triggers No Party' then
        if v1 == '3' then
            setProperty('paperSpotlight.alpha',1)
            playSound('teethslam')
            doTweenX('spotLightScaleX','paperSpotlight.scale',1,0.5,'quadOut')
            doTweenY('spotLightScaleY','paperSpotlight.scale',1,0.5,'quadOut')
        elseif v1 == '4' then
            doTweenAlpha('spotLightExit','paperSpotlight',0,1,'quadIn')
        end
    end
end
function removeCircles(drainHP)
    if circlesCount > 0 then
        local textLength = string.gsub(#getTextString('paperText'),' ','')
        local cal = math.max(#textLength*250,circlesCount)
        runHaxeCode(
            [[
                var percent = 0;
                var text = getVar('paperText');
                if(text != null){
                    for(i in 0...]]..(circlesCount+1)..[[){
                        var circle = getVar('paperCircle'+i);
                        if(circle != null){
                            if(FlxG.pixelPerfectOverlap(circle,text,255,game.camOther)){
                                percent += 1/]]..cal..[[;
                            }
                            else{
                                if(]]..tostring(nerf)..[[){
                                    percent -= 1/]]..cal..[[;
                                }
                                else{
                                    percent -= 1/]]..circlesCount..[[;
                                }
                            }
                            circle.kill();
                            circle.destroy();
                        }
                        removeVar('paperCircle'+i);
                    }
                }
                
                if(]]..tostring(drainHP == true)..[[){
                    FlxTween.tween(game,{health: game.health - (2-(percent*2))},0.3,{ease: FlxEase.quadOut});
                }
                getVar('paperTime').text = Std.string(Math.floor(percent*10000)/100)+'%';
            ]]
        )
        circlesCount = 0
    end
end
function onTweenCompleted(tag)
    if tag == 'paperYEnter' then
        --paperTime = setTime
        setProperty('paperTime.visible',true)
        setProperty('paperText.visible',true)
        canDraw = true
    elseif tag == 'paperYExit' then
        setProperty('paperText.visible',false)
    elseif tag == 'spotLightExit' then
        removeLuaSprite('paperSpotlight',true)
    end
end

function onTimerCompleted(tag)
    if tag == 'paperGoUp' then
        doTweenY('paperYExit','paper',not downscroll and -200 or screenHeight + 200,stepCrochet*0.008,'quadIn')
    end
end

function onUpdate(el)
    local mouseX = math.floor(getMouseX('other'))
    local mouseY = math.floor(getMouseY('other'))


    if mousePressed() and canDraw then
        if((mouseX ~= lastMousePosX or mouseY ~= lastMousePosY) and mouseX >= getProperty('paper.x') and mouseX <= getProperty('paper.x') - 20 + getProperty('paper.width') and
         mouseY >= getProperty('paper.y') and mouseY <= getProperty('paper.y') + getProperty('paper.height') - 20) then
            lastMousePosX = mouseX
            lastMousePosY = mouseY
            runHaxeCode(
                [[
                    var newCircle = new FlxSprite().makeGraphic(15,15,0x00000000);
                    FlxSpriteUtil.drawCircle(newCircle,-1,-1,5,0xFF0000FF);
                    newCircle.setPosition(]]..(mouseX - 5)..','..(mouseY - 5)..[[);
                    newCircle.cameras = [game.camOther];
                    game.insert(game.members.indexOf(game.getLuaObject('paperText'))+1,newCircle);
                    newCircle.updateHitbox();
                    setVar('paperCircle'+]]..circlesCount..[[,newCircle);
                ]]
            )

            circlesCount = circlesCount + 1;
        end
    end
    --setProperty('paperText.x',getProperty('paper.x')/3)
    setProperty('paperText.y',getProperty('paper.y') + (getProperty('paper.height')/2) - 50)
    --setProperty('paperTime.x',getProperty('paper.x'))
    setProperty('paperTime.y',getProperty('paper.y'))
    if paperTime ~= -1 then
        if paperTime > 0 then
            setProperty('paperTime.text',math.floor(paperTime*10)/10)
            paperTime = paperTime - el
        else
            cancelTween('paperYEnter')
            runTimer('paperGoUp',1)

            setProperty('paperText.visible',false)
        
            removeCircles(true)
            canDraw = false
            paperTime = -1
        end
    end
    setProperty('mousePoint.x',mouseX)
    setProperty('mousePoint.y',mouseY)

    local songPos = getSongPosition()/bpm;
    --setProperty('paperSpotlight.x',curWidth/2 - 310 + (10 * math.cos(songPos/10)))
    setProperty('paperSpotlight.x',-70 + (10 * math.cos(songPos/10)))
    setProperty('paperSpotlight.offset.x',0)
    setProperty('paperSpotlight.offset.y',0)
    setProperty('paperSpotlight.y',-60 + (10 * math.sin(songPos/5)));
end