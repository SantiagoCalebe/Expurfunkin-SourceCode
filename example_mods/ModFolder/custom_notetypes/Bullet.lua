local bullets = 3
function onCreate()
    precacheSound('pico_shoot')
    --makeLuaSprite('bulletAmmo','')
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'Bullet' then
            setPropertyFromGroup('unspawnNotes',notes,'texture','BulletMario_NOTE_assets')
        end
    end
end
function goodNoteHit(id,data,type,sus)
    if type == 'Bullet' then
        cameraShake('game',0.007,0.15)
        cameraShake('hud',0.007,0.15)
        playAnim('boyfriend','singUP-alt',true)
        setProperty('boyfriend.holdTimer',0)
        playSound('pico_shoot')
        flash()
    end
end

function noteMiss(id,data,type,sus)
    if type == 'Bullet' then
        playSound('FAILGUN')
    end
end

function flash()
    makeLuaSprite('flash', '', 0, 0);
        makeGraphic('flash',1280,720,'FF0000')
	      addLuaSprite('flash', true);
	      setLuaSpriteScrollFactor('flash',0,0)
	      setProperty('flash.scale.x',2)
	      setProperty('flash.scale.y',2)
	      setProperty('flash.alpha',0)
		setProperty('flash.alpha',1)
		doTweenAlpha('flTw','flash',0, 0.05 ,'linear')
		setObjectCamera('flash', 'other');
end