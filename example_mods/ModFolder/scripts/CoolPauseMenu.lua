-- you can also change/edit the names
option = {
    'Resume',
    'Restart',
    'Exit'
}
--optionLength = 3;
function onPause()
    openCustomSubstate('NEW_pause_menu',true);
    return Function_Stop;
end

function onCustomSubstateCreatePost(name)
    if name == 'NEW_pause_menu' then
        makeLuaText('arrow','>',0,0,0);
        setTextSize('arrow',100);
        setTextBorder('arrow',3,'000000');
        setObjectCamera('arrow','other');
        addLuaText('arrow',true);

        --makeLuaText('arrow2','<',0,0,0);
        --setTextSize('arrow2',100);
        --setTextBorder('arrow2',3,'000000');
        --setObjectCamera('arrow2','other');
        --addLuaText('arrow2',true);

        for i = 1,#option do
            makeLuaText('option_'..i,option[i],0,0,0 + i * 150);
            setTextSize('option_'..i,100);
            setTextBorder('option_'..i,3,'000000');
            setObjectCamera('option_'..i,'other');
            addLuaText('option_'..i,true);
            setProperty('option_'..i..'.x',(screenWidth - getTextWidth('option_'..i)) - 700)
        end
        makeLuaSprite('BG','pausebg',0,0);
        setObjectCamera('BG','other');
        addLuaSprite('BG');
        
        makeLuaSprite('BGmoving','pause_score',0,0);
        setObjectCamera('BGmoving','other');
        addLuaSprite('BGmoving');

        makeLuaSprite('blackBox','',0,0);
        makeGraphic('blackBox',screenWidth,screenHeight,'000000');
        setObjectCamera('blackBox','other');
        addLuaSprite('blackBox');
        setProperty('blackBox.alpha',0.5)

        setProperty('arrow.x',-80 + getProperty('option_'..optionSelected..'.x'));
        setProperty('arrow.y',getProperty('option_'..(optionSelected)..'.y'));

        --setProperty('arrow2.x',(screenWidth + 25) - getProperty('option_'..optionSelected..'.x'));
        --setProperty('arrow2.y',getProperty('option_'..(optionSelected)..'.y'));
    end
end

local openOptions = false
function onCustomSubstateUpdatePost(name)
    if name == 'NEW_pause_menu' then

        --if keyboardJustPressed('R') then
        --    restartSong(false);
        --end
        setProperty('BGmoving.x',getProperty('BGmoving.x') - 1);
        setProperty('BGmoving.y',getProperty('BGmoving.y') - screenHeight/screenWidth);
        if getProperty('BGmoving.x') <= -screenWidth + 1 then
            setProperty('BGmoving.x',0);
        end

        if getProperty('BGmoving.y') <= -screenHeight + 1 then
            setProperty('BGmoving.y',0);
        end

        if keyboardJustPressed('ENTER') and optionSelected == 1 then
            closeCustomSubstate();
        elseif keyboardJustPressed('ENTER') and optionSelected == 2 then
            restartSong(false);
        elseif keyboardJustPressed('ENTER') and optionSelected == 3 then
            exitSong(false);
        end

        if keyboardJustPressed('ENTER') then
            playSound('cancelMenu');
        end

        if keyboardJustPressed('UP') then
            chooseOption(-1)
            playSound('scrollMenu');
        elseif keyboardJustPressed('DOWN') then
            chooseOption(1)
            playSound('scrollMenu');
        end
    end
end

optionSelected = 1
function chooseOption(choose)
    optionSelected = optionSelected + choose;

    if optionSelected >= #option + 1 then
        optionSelected = 1;
    elseif optionSelected <= 0 then
        optionSelected = #option;
    end

    doTweenX('arrowX','arrow',-80 + getProperty('option_'..optionSelected..'.x'),0.25,'circOut');
    doTweenY('arrowY','arrow',getProperty('option_'..(optionSelected)..'.y'),0.25,'circOut');

    --doTweenX('arrow2X','arrow2',(screenWidth + 25) - getProperty('option_'..optionSelected..'.x'),0.25,'circOut');
    --doTweenY('arrow2Y','arrow2',getProperty('option_'..(optionSelected)..'.y'),0.25,'circOut');
end

function onCustomSubstateDestroy(name)
    if name == 'NEW_pause_menu' then
        for i = 1,#option do
            removeLuaText('option_'..i,false);
        end
        removeLuaText('songName',false);
        removeLuaText('arrow',false);
        --removeLuaText('arrow2',false);
        removeLuaSprite('blackBox',false);
        removeLuaSprite('BGmoving',false);
        removeLuaSprite('BG',false);
    end
end