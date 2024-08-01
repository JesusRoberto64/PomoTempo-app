extends Control

func _input(event):
	#if event.is_action_released("ui_cancel"):
		#get_tree().quit()
	if event.is_action_released("screen_mode"):
		var display = DisplayServer
		if display.window_get_mode() == display.WINDOW_MODE_WINDOWED:
			display.window_set_mode(display.WINDOW_MODE_FULLSCREEN)
		else:
			display.window_set_mode(display.WINDOW_MODE_WINDOWED)
