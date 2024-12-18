function onCreatePost()
	makeLuaSprite('healthBarOver', 'healthBarOver', getProperty('healthBar.x') - 4, getProperty('healthBar.y') - 4.9)
    setObjectCamera('healthBarOver', 'hud'); setScrollFactor('healthBarOver', 0.9, 0.9)
    setProperty('healthBarOver.angle', getProperty('healthBar.angle'))
    setObjectOrder('healthBarOver', getObjectOrder('healthBar') + 1)
    addLuaSprite('healthBarOver', true)
end

function onUpdatePost()
	setProperty('iconP1.x', getMidpointX('healthBar')+224)
	setProperty('iconP2.x', getMidpointX('healthBar')-374)
end