package.loaded.buttonAPI = nil
API = require("buttonAPI")
local event = require("event")
local computer = require("computer")
local term = require("term")
local component = require("component")
local gpu = component.gpu
-- # local rs = component.redstone
local colors = require("colors")
local side = require("sides")
local Black = 0x000000
local Gray = 0x878787
local White = 0xFFFFFF
local Green = 0x00FF00

gpu.setResolution(80, 25)
local wmax, hmax = gpu.getResolution()
local bW = 20

local mode = 0
local active = false
local xpLiquid = 128000

function API.fillTable()
  API.setTable("Modo  Pacífico", test1, 7 , 26 , (hmax/2-1)-5 , hmax/2+1-5)  
  API.setTable("Modo  Killer", test2, 31 , 50 , hmax/2-1-5 , hmax/2+1-5)
  API.setTable("Modo  Granja", test3, 55 , 74 , hmax/2-1-5 , hmax/2+1-5)
  API.setTable("Empezar/Parar", test4, 55,74,19,21)
  API.changeActive("Empezar/Parar",true)
  API.updateScreen()
end

function setBar()
	local oldColor = gpu.setBackground(Gray)
	term.setCursor(31,19)
	term.write("                    ")
	term.setCursor(31,20)
	term.write("  ")
	term.setCursor(49,20)
	term.write("  ")
	term.setCursor(31,21)
	term.write("                    ")
	term.setCursor(33,20)
	gpu.setBackground(Green)
	local nBars = math.floor((xpLiquid/256000)*16)
	for i=1,nBars do term.write(" ") end
	gpu.setBackground(Black)
	local text = xpLiquid .. " / 256000 mB"
	term.setCursor((wmax-string.len(text))/2+1, 23)
	term.write(text)
	gpu.setBackground(oldColor)
end

function API.updateScreen()
	API.clear()
	if mode == 0 then
		API.changeActive("Modo  Pacífico",true)
		API.changeActive("Modo  Killer",false)
		API.changeActive("Modo  Granja",false)
	elseif mode == 1 then
		API.changeActive("Modo  Pacífico",false)
		API.changeActive("Modo  Killer",true)
		API.changeActive("Modo  Granja",false)
	else
		API.changeActive("Modo  Pacífico",false)
		API.changeActive("Modo  Killer",false)
		API.changeActive("Modo  Granja",true)
	end
	if active == false then API.changeActive("Empezar/Parar",true) else API.changeActive("Empezar/Parar",false) end
	API.screen()
	local text = "Control del spawner"
	gpu.setBackground(Gray)
	term.setCursor(1,1)
	term.clearLine()
--[[	term.setCursor(1,2)
	term.clearLine()
	term.setCursor(1,3)
	term.clearLine()--]]
	local oldFColor = gpu.setForeground(Black)
    term.setCursor((wmax-string.len(text))/2+1, 1)
    term.write(text)
    gpu.setForeground(oldFColor)
    term.setCursor(1,hmax)
    term.clearLine()
    gpu.setBackground(Black)
    text = "Activa el spawner"
    term.setCursor((wmax-string.len(text))/2+1-24, 11)
    term.write(text)
    text = "para generar mobs."
    term.setCursor((wmax-string.len(text))/2+1-24, 12)
    term.write(text)
    text = "Pero, no los mata"
    term.setCursor((wmax-string.len(text))/2+1-24, 13)
    term.write(text)
    text = "automaticamente."
    term.setCursor((wmax-string.len(text))/2+1-24, 14)
    term.write(text)
    text = "Activa el spawner"
    term.setCursor((wmax-string.len(text))/2+1, 11)
    term.write(text)
    text = "y el killer joy."
    term.setCursor((wmax-string.len(text))/2+1, 12)
    term.write(text)
    text = "Simula un jugador."
    term.setCursor((wmax-string.len(text))/2+1, 13)
    term.write(text)
    text = "Consume nutrientes."
    term.setCursor((wmax-string.len(text))/2+1, 14)
    term.write(text)
    text = "Activa el spawner"
    term.setCursor((wmax-string.len(text))/2+1+24, 11)
    term.write(text)
    text = "y el mob killer."
    term.setCursor((wmax-string.len(text))/2+1+24, 12)
    term.write(text)
    text = "No produce ningún"
    term.setCursor((wmax-string.len(text))/2+1+24, 13)
    term.write(text)
    text = "rare drop."
    term.setCursor((wmax-string.len(text))/2+1+24, 14)
    term.write(text)
    term.setCursor(7,20)
    term.write("Experiencia líquida:")
    --# 26
    setBar()
end

function getClick()
  local _, _, x, y = event.pull(1,touch)
  if x == nil or y == nil then
    local h, w = gpu.getResolution()
    local oldColor = gpu.setBackground(Gray)
    gpu.set(h, w, ".")
    gpu.set(h, w, " ")
    gpu.setBackground(oldColor)
  else
    API.checkxy(x,y)
  end
end
 
function test1()
  if active == false then
  	mode = 0
  	API.updateScreen()
  end
end
 
function test2()
  if active == false then
  	mode = 1
  	API.updateScreen()
  end
end
 
function test3()
  if active == false then
  	mode = 2
  	API.updateScreen()
  end
end
 
function test4()
  active = not active
  API.updateScreen()
end
 
term.setCursorBlink(false)
API.clearTable()
API.fillTable()
 
while true do
  getClick()
  if active == true then
  	API.updateScreen()
  end
end