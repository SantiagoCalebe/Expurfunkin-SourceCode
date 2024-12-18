function onEvent(name, value1, value2)
    local var string = (value1)
    local var color = (value2)
    if name == "Lyrics2" then

        makeLuaText('captions', 'Lyrics go here', 1000, 150, 520)
        setTextString('captions',  '' .. string)
        setTextFont('captions', 'horroroidital.ttf')
        setTextColor('captions', value2)
        setTextSize('captions', 60);
        setProperty('captions.antialiasing', true);
        addLuaText('captions')
	setObjectCamera('captions', 'other');
        setTextAlignment('captions', 'center')
        --removeLuaText('captions', true)
        
    end
end

