package main

import "base:runtime"
import "camus"
import "core:log"
import sdl "vendor:sdl3"
import "vendor:sdl3/ttf"

line_color: sdl.Color : sdl.Color{255, 255, 255, 255}
user_pos := [2]u8{0, 0}
slots: [3][3]u8
turn: u8 = 1
winner: u8 = 0
winner_start_end: [4]u8
winner_color: sdl.Color
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
	camus.background_color = sdl.Color{0, 0, 0, 255}
	camus.window_size = []i32{640, 480}
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
	welcome_destroy()
}
