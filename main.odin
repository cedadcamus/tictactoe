package main

import "base:runtime"
import "camus"
import "core:log"
import sdl "vendor:sdl3"
import "vendor:sdl3/ttf"

winner: u8 = 0
game_state: GameState = GameState.WELCOME


GameState :: enum u8 {
	WELCOME,
	GAME,
}

main :: proc() {
	camus.debug = false
	camus.debug_fps = false
	camus.init = init
	camus.tick = tick
	camus.ready = ready
	camus.destroy = destroy
	camus.keyboard_event = keyboard_event
	camus.mouse_motion_event = mouse_motion_event
	camus.mouse_button_event = mouse_button_event
	camus.background_color = sdl.Color{0, 0, 0, 255}
	camus.window_size = []i32{640, 480}
	camus.window_size_event = window_size_event
	camus.run()
}

init :: proc() {
	welcome_init()
}

ready :: proc() {
	welcome_ready()
}

tick :: proc(delta_time: f64) {
	switch game_state {
	case GameState.WELCOME:
		welcome_tick(delta_time)
	case GameState.GAME:
		game_tick(delta_time)
	}
}

keyboard_event :: proc(event: sdl.KeyboardEvent) {
	#partial switch game_state {
	case GameState.GAME:
		game_keyboard_event(event)
	}
}

destroy :: proc() {
	switch game_state {
	case GameState.WELCOME:
		welcome_destroy()
	case GameState.GAME:
		game_destroy()
	}
}

window_size_event :: proc(event: sdl.WindowEvent) {
	#partial switch game_state {
	case GameState.GAME:
		game_window_size_event()
	}
}

mouse_motion_event :: proc(event: sdl.MouseMotionEvent) {
	#partial switch game_state {
	case GameState.GAME:
		game_mouse_motion_event(event)
	}
}

mouse_button_event :: proc(event: sdl.MouseButtonEvent) {
	#partial switch game_state {
	case GameState.GAME:
		game_mouse_button_event(event)
	}
}
