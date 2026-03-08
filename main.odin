package main

import "camus"
import "camus/vector2"
import sdl "vendor:sdl3"
import "base:runtime"
import "core:log"

line_color : camus.Color : camus.Color{255, 255, 255, 255}
user_pos: vector2.Vector2U8 = vector2.Vector2U8{0, 0}

main :: proc() {
	camus.debug = true
	camus.init = init
	camus.tick = tick
	camus.keyboard_event = keyboard_event
	camus.background_color = camus.Color{0, 0, 0, 255}
	camus.window_size = vector2.Vector2Int{640, 480}
	camus.run()
}

init :: proc () {
	//
}

tick :: proc(delta_time: f64) {
	// vertical lines
	camus.draw_line(line_color, vector2.Vector2{640 / 3, 0}, vector2.Vector2{640 / 3, 480})
	camus.draw_line(line_color, vector2.Vector2{640 / 3 * 2, 0}, vector2.Vector2{640 / 3 * 2, 480})
	
	// horizontal lines
	camus.draw_line(line_color, vector2.Vector2{0, 480 / 3}, vector2.Vector2{640, 480 / 3})
	camus.draw_line(line_color, vector2.Vector2{0, 480 / 3 * 2}, vector2.Vector2{640, 480 / 3 * 2})
	
	// player cursor
	rect: sdl.FRect
	rect.x = (640 / (3 * 4) / 2) + (640 / 3 * cast(f32) user_pos.x)
	rect.y = (480 / (3 * 4) / 2) + (480 / 3 * cast(f32) user_pos.y)
	rect.w = 640 / 4
	rect.h = 480 / 4
	camus.draw_rect(camus.Color{0, 0, 255, 255}, &rect)
}

keyboard_event :: proc(event: sdl.Event) {
	#partial switch event.type {
		case sdl.EventType.KEY_UP:
			switch event.key.key {
				case sdl.K_W, sdl.K_UP:
					if user_pos.y > 0 {
						user_pos.y -= 1
					}
				case sdl.K_A, sdl.K_LEFT:
					if user_pos.x > 0 {
						user_pos.x -= 1
					}
				case sdl.K_S, sdl.K_DOWN:
					if user_pos.y < 2 {
						user_pos.y += 1
					}
				case sdl.K_D, sdl.K_RIGHT:
					if user_pos.x < 2 {
						user_pos.x += 1
					}
			}
			
	}
}