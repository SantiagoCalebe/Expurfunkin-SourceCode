function onEvent(n, v1, v2)
	if n == 'Show Song' then
		makeLuaText("song", v1, screenWidth, 0, 304.5)
		setTextAlignment('song','center')
		setTextSize("song", 42)
		setTextBorder("song", 3, "FF0000")
		setTextColor("song", "000000")
		setTextFont("song", "Super Mario Bros. 2.ttf")
		setObjectCamera("song",'other')
		setProperty('song.alpha',0)
		addLuaText("song")

		makeLuaText("credits", v2, screenWidth, 0, 374.5)
		setTextAlignment('credits','center')
		setTextSize("credits", 35)
		setTextBorder("credits", 2, "FF0000")
		setTextColor("credits", "000000")
		setTextFont("credits", "Super Mario Bros. 2.ttf")
		setObjectCamera("credits",'other')
		setProperty('credits.alpha',0)
		addLuaText("credits")

		makeLuaSprite("line1",'',566,361)
		makeGraphic("line1",640,5,'000000')
		setObjectCamera("line1",'other')
		screenCenter("line1",'566 361')
		setProperty('line1.alpha',0)

		makeLuaSprite("line2",'',561,359)
		makeGraphic("line2",650,8,'FF0000')
		setObjectCamera("line2",'other')
		screenCenter("line2",'561 359')
		setProperty('line2.alpha',0)
		addLuaSprite("line2",true)
		addLuaSprite("line1",true)

		doTweenAlpha("songA", "song", 1, 0.5, "cubeOut")
		doTweenAlpha("creditsA", "credits", 1, 0.5, "cubeOut")
		doTweenAlpha("line2A", "line2", 1, 0.5, "cubeOut")
		doTweenAlpha("line1A", "line1", 1, 0.5, "cubeOut")

		doTweenY("songY", "song", getProperty("song.y")+30, 0.5, "cubeOut")
		doTweenY("creditsY", "credits", getProperty("credits.y")+30, 0.5, "cubeOut")
		doTweenY("line2Y", "line2", getProperty("line2.y")+30, 0.5, "cubeOut")
		doTweenY("line1Y", "line1", getProperty("line1.y")+30, 0.5, "cubeOut")
		runTimer("bye",5)
	end
end
function onTimerCompleted(tag)
	if tag == 'bye' then
		doTweenAlpha("songA2", "song", 0, 0.5, "cubeOut")
		doTweenAlpha("creditsA2", "credits", 0, 0.5, "cubeOut")
		doTweenAlpha("line2A2", "line2", 0, 0.5, "cubeOut")
		doTweenAlpha("line1A2", "line1", 0, 0.5, "cubeOut")
	end
end
function onTweenCompleted(tag)
	if tag == 'songA2' then
		removeLuaText("song",true)
		removeLuaText("credits",true)
		removeLuaSprite("line2",true)
		removeLuaSprite("line1",true)
	end
end