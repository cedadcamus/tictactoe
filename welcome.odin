package main

import "base:runtime"
import "camus"
import "core:log"
import sdl "vendor:sdl3"
import "vendor:sdl3/ttf"

welcome_title: ^camus.UIText
welcome_start_button: ^camus.UIButton
welcome_scene: ^camus.Scene

welcome_init :: proc() {
	camus.ui_add_font("Jersey", "Jersey10-Regular.ttf", 16)
	camus.ui_add_font("Doto", "Doto-VariableFont_ROND,wght.ttf", 32)

	welcome_scene = new(camus.Scene)
	camus.current_scene = welcome_scene

	welcome_title = camus.ui_create_text(welcome_scene)
	welcome_title.text = "Tic Tac Toe"
	welcome_title.color.r = 0
	welcome_title.color.g = 255
	welcome_title.color.b = 255
	welcome_title.color.a = 255
	welcome_title.font_name = "Doto"
	welcome_title.font_size = 32

	welcome_start_button = camus.ui_create_button(welcome_scene)
	welcome_start_button.click = welcome_start
	welcome_start_button.color.r = 128
	welcome_start_button.color.g = 128
	welcome_start_button.color.b = 128
	welcome_start_button.color.a = 255
	welcome_start_button.padding[0] = 5
	welcome_start_button.padding[1] = 5
	welcome_start_button.padding[2] = 5
	welcome_start_button.padding[3] = 5
	welcome_start_button.border_width[0] = 5
	welcome_start_button.border_width[1] = 5
	welcome_start_button.border_width[2] = 5
	welcome_start_button.border_width[3] = 5

	welcome_start_button.text.text = "Start"
	welcome_start_button.text.color.r = 255
	welcome_start_button.text.color.g = 255
	welcome_start_button.text.color.b = 255
	welcome_start_button.text.color.a = 255
	welcome_start_button.text.font_name = "Jersey"
	welcome_start_button.text.font_size = 24
}

welcome_ready :: proc() {
	camus.ui_set_text_pos(
		welcome_title,
		(f32(camus.window_size[0]) / 2) - (welcome_title.rect.w / 2),
		50,
	)

	camus.ui_set_button_pos(
		welcome_start_button,
		(f32(camus.window_size[0]) / 2) - (welcome_start_button.text.rect.w / 2),
		f32(camus.window_size[1]) / 2,
	)
}

welcome_tick :: proc(delta_time: f64) {
}

welcome_destroy :: proc() {
}

welcome_start :: proc(button: ^camus.UIButton) {
	game_init()
	camus.ui_destroy(welcome_scene)
	game_state = GameState.GAME
}
