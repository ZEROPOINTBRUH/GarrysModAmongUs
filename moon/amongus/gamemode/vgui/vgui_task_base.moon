base = {}

base.Init = =>
	@SetZPos 30002
	@SetSize ScrW!, ScrH!

MAT_ASSETS = {
	close: Material "au/gui/closebutton.png", "smooth"
}

base.Setup = (content) =>
	content\SetParent @
	content\Center!
	@NewAnimation 0, 0, 0, ->
		with @Add "DImageButton"
			\SetText ""
			\SetMaterial MAT_ASSETS.close
			\SetSize ScrH! * 0.09, ScrH! * 0.09

			x, y = content\GetPos!
			x -= ScrH! * 0.11
			\SetPos x, y

			.DoClick = ->
				@Close!

base.SetTaskName = (value) => @__taskName = value

base.OnMousePressed = =>
	@wasPressed = true

base.OnMouseReleased = =>
	if @wasPressed
		@Close!

base.OnCursorExited = =>
	@wasPressed = false

base.Popup = =>
	@MakePopup!

	@SetPos 0, ScrH!
	@MoveTo 0, 0, 0.2
	
	@SetAlpha 0
	@AlphaTo 255, 0.1, 0.01

	surface.PlaySound @__appearSound or "au/panel_genericappear.wav"

base.Submit = (autoClose = true) =>
	if (@__taskName)
		GAMEMODE\Net_SendSubmitTask @__taskName

		if autoClose
			@NewAnimation 0, 2, 0, ->
				@Close!

base.Close = =>
	if (@__taskName)
		GAMEMODE\Net_SendCloseTask @__taskName

	@AlphaTo 0, 0.1
	@MoveTo 0, ScrH!, 0.1, 0, -1, ->
		surface.PlaySound @__disappearSound or "au/panel_genericdisappear.wav"
		@Remove!

base.SetAppearSound = (value) => @__appearSound = value
base.SetDisappearSound = (value) => @__disappearSound = value

base.Paint = =>

vgui.Register "AmongUsTaskBase", base, "DPanel"