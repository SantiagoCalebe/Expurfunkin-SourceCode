function onCreate()
	makeLuaSprite("twitter","modstuff/slaugther/twitter", -1000, -500);
	addLuaSprite("twitter", false);
    setLuaSpriteScrollFactor("twitter", 0.2,0.2);
	scaleObject('twitter', 10, 10);

    makeAnimatedLuaSprite('fireLeft','modstuff/slaugther/Starman_BG_Fire_Assets', -500, 0)
    addAnimationByPrefix('fireLeft','anim','fire anim effects',24,true)
    scaleObject('fireLeft', 2, 2);
    setScrollFactor('fireLeft',0.6,0.6)
	setObjectCamera('fireleft', 'camOther');
    addLuaSprite('fireLeft',false)

	close(true);
end