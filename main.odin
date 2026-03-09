package main

import "camus"
import "camus/vector2"
import sdl "vendor:sdl3"
import "base:runtime"
import "core:log"

line_color : camus.Color : camus.Color{255, 255, 255, 255}
user_pos := [2]u8 {0, 0}
slots: [3][3]u8
turn: u8 = 1

main :: proc() {
	camus.debug = true
	camus.init = init
	camus.tick = tick
	camus.keyboard_event = keyboard_event
	camus.background_color = camus.Color{0, 0, 0, 255}
	camus.window_size = []i32 {640, 480}
	camus.run()
}

init :: proc () {
	//
}

tick :: proc(delta_time: f64) {
	// vertical lines
	camus.draw_line(line_color, [2]f32 {640 / 3, 0}, [2]f32 {640 / 3, 480})
	camus.draw_line(line_color, [2]f32 {640 / 3 * 2, 0}, [2]f32 {640 / 3 * 2, 480})
	
	// horizontal lines
	camus.draw_line(line_color, [2]f32 {0, 480 / 3}, [2]f32 {640, 480 / 3})
	camus.draw_line(line_color, [2]f32 {0, 480 / 3 * 2}, [2]f32 {640, 480 / 3 * 2})
	
	// player cursor
	rect: sdl.FRect
	rect.x = (640 / (3 * 4) / 2) + (640 / 3 * f32(user_pos[0]))
	rect.y = (480 / (3 * 4) / 2) + (480 / 3 * f32(user_pos[1]))
	rect.w = 640 / 4
	rect.h = 480 / 4
	player_color := camus.Color{0, 0, 255, 255}
	if turn == 2 {
		player_color = camus.Color{255, 0, 0, 255}
	}
	camus.draw_rect(player_color, &rect)
	
	for x := 0; x < 3; x += 1 {
		for y := 0; y < 3; y += 1 {
			switch slots[x][y] {
				case 1:
					line_start: [2]f32 
					line_start[0] = (640 / (3 * 4) / 2) + (640 / 3 * f32(x))
					line_start[1] = (480 / (3 * 4) / 2) + (480 / 3 * f32(y))
					line_end: [2]f32 
					line_end[0] = (640 / (3 * 4) / 2) + (640 / 3 * f32(x)) + 640 / 4
					line_end[1] = (480 / (3 * 4) / 2) + (480 / 3 * f32(y)) + 480 / 4
					camus.draw_line(line_color, line_start, line_end)
					
					line_start[0] = (640 / (3 * 4) / 2) + (640 / 3 * f32(x)) + 640 / 4
					line_start[1] = (480 / (3 * 4) / 2) + (480 / 3 * f32(y))
					line_end[0] = (640 / (3 * 4) / 2) + (640 / 3 * f32(x)) 
					line_end[1] = (480 / (3 * 4) / 2) + (480 / 3 * f32(y)) + 480 / 4
					camus.draw_line(line_color, line_start, line_end)
				case 2:
					center: [2]i32
					center[0] = (640 / (3 * 4) / 2) + (640 / 3 * i32(x)) + 640 / 8
					center[1] = (480 / (3 * 4) / 2) + (480 / 3 * i32(y)) + 480 / 8
					camus.draw_circle(line_color, center, 480 / 7)
			}
		}
	}
}

keyboard_event :: proc(event: sdl.Event) {
	#partial switch event.type {
		case sdl.EventType.KEY_UP:
			switch event.key.key {
				case sdl.K_W, sdl.K_UP:
					if user_pos[1] > 0 {
						user_pos[1] -= 1
					}
				case sdl.K_A, sdl.K_LEFT:
					if user_pos[0] > 0 {
						user_pos[0] -= 1
					}
				case sdl.K_S, sdl.K_DOWN:
					if user_pos[1] < 2 {
						user_pos[1] += 1
					}
				case sdl.K_D, sdl.K_RIGHT:
					if user_pos[0] < 2 {
						user_pos[0] += 1
					}
				case sdl.K_RETURN, sdl.K_KP_ENTER:
					if slots[user_pos[0]][user_pos[1]] == 0 {
						slots[user_pos[0]][user_pos[1]] = turn
						if turn == 1 {
							turn = 2
						} else {
							turn = 1
						}
					}
			}
			
	}
}