package main

import "camus"
import sdl "vendor:sdl3"

game_tick :: proc(delta_time: f64) {
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
					camus.draw_circle(line_color, center, 480 / 8)
			}
		}
	}
	
	if winner != 0 {
		line_start: [2]f32 
		line_start[0] = (640 / 3 / 2) + (640 / 3 * f32(winner_start_end[0]))
		line_start[1] = (480 / 3 / 2) + (480 / 3 * f32(winner_start_end[1]))
		line_end: [2]f32 
		line_end[0] = (640 / 3 / 2) + (640 / 3 * f32(winner_start_end[2]))
		line_end[1] = (480 / 3 / 2) + (480 / 3 * f32(winner_start_end[3]))
		camus.draw_line(winner_color, line_start, line_end)
	}
}