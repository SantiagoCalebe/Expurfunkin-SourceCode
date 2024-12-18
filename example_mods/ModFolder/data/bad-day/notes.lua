function onCreatePost()
    setObjectCamera('healthBar', 'camGame')
    setObjectCamera('healthBarBG', 'camGame')
    setObjectCamera('iconP1', 'camGame')
    setObjectCamera('iconP2', 'camGame')

    setProperty('healthBar.x', 1000)
    setProperty('healthBar.y', 1100)
    setProperty('healthBarBG.x', getProperty('healthBar.x'))
    setProperty('healthBarBG.y', getProperty('healthBar.y'))

    setProperty('iconP1.x', getProperty('healthBar.x') - 100)
    setProperty('iconP1.y', getProperty('healthBar.y') - 20)
    setProperty('iconP2.x', getProperty('healthBar.x') + getProperty('healthBar.width') - 20)
    setProperty('iconP2.y', getProperty('healthBar.y') - 20)
end
