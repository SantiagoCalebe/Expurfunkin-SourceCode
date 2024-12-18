function onCreatePost()
    setProperty("healthBar.flipX", true)
    setProperty("healthBarBG.flipX", true)
    setProperty("iconP1.flipX", true)
    setProperty("iconP2.flipX", true)
end

function onUpdatePost()
    setProperty('iconP1.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP1.scale.x') + 50) / 2 - 26 + 6)
    setProperty('iconP2.x', getProperty('healthBar.x') + (getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP2.scale.x') - 0) / 2 - 26 * 4 - 6)
end