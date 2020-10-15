VGUI_HUD = include "vgui/vgui_hud.lua"
VGUI_MEETING = include "vgui/vgui_meeting.lua"
VGUI_EJECT = include "vgui/vgui_eject.lua"
VGUI_BLINK = include "vgui/vgui_blink.lua"
VGUI_VENT = include "vgui/vgui_vent.lua"

GM.Blink = (duration = 1, delay, pre) =>
	vgui.CreateFromTable(VGUI_BLINK)\Blink duration, delay, pre

GM.HUDShowVents = (vents) =>
	if IsValid @Hud
		if IsValid @Hud.Vents
			@Hud.Vents\Remove!

		@Hud.Vents = with vgui.CreateFromTable(VGUI_VENT)
			\ShowVents vents

GM.HUDReset = =>
	if IsValid @Hud
		@Hud\Remove!

	@Hud = vgui.CreateFromTable VGUI_HUD
	@Hud\SetPaintedManually true

if GAMEMODE and IsValid GAMEMODE.Hud
	GAMEMODE\HUDReset!

hook.Add "Initialize", "Init Hud", ->
	GAMEMODE\HUDReset!

hook.Add "HUDPaintBackground", "NMW AU Hud", ->
	if IsValid GAMEMODE.Hud
		cam.Start2D!
		GAMEMODE.Hud\PaintManual!
		cam.End2D!