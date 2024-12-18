import Main;

import openfl.utils.Assets;
import openfl.text.TextFormat;

import flixel.FlxG;
import flixel.util.FlxStringUtil;

import backend.Paths;
import states.PlayState;

var fpsVar = Main.fpsVar;
var oldUpdateText = fpsVar.updateText;

function onCreatePost() {
    fpsVar.defaultTextFormat = new TextFormat(Paths.font("mariones.ttf"), 10, 0xFFFFFFFF);
    fpsVar.updateText = function() {
        fpsVar.text = "FPS: " + fpsVar.currentFPS + "\nMemory: " + FlxStringUtil.formatBytes(fpsVar.memoryMegas);
        fpsVar.textColor = 0xFFa11b1b;
        
        var memoryMB = fpsVar.memoryMegas / 1000000;
        if(memoryMB > 3000 || fpsVar.currentFPS < FlxG.drawFramerate * 0.5)
            fpsVar.textColor = 0xFFe30000;
    }
}

function onDestroy() {
    fpsVar.defaultTextFormat = new openfl.text.TextFormat("_sans", 14, 0xFFFFFFFF);
    fpsVar.updateText = oldUpdateText;
}