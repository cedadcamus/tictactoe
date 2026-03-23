package main

import "base:runtime"
import "camus"
import "core:log"
import sdl "vendor:sdl3"

game_scene: camus.Scene
line_color: sdl.Color : sdl.Color{255, 255, 255, 255}

vertical_lines: [8]f32
horizontal_lines: [8]f32

player_cursor_rect: sdl.FRect

user_pos := [2]u8{0, 0}
slots: [3][3]u8
turn: u8 = 1
winner_start_end: [4]u8
winner_color: sdl.Color
win_background := sdl.Color{0, 0, 0, 191}
win_background_rect := sdl.FRect{0, 0, 0, 0}
player_color: sdl.Color

game_wins_text: ^camus.UIText
game_restart_button: ^camus.UIButton

game_init :: proc() {
	camus.current_scene = &game_scene

	player_color.a = 255
	player_color.g = 0

	game_wins_text = camus.ui_create_text(&game_scene)
	game_wins_text.text = "WINS"
	game_wins_text.font_name = "Doto"
	game_wins_text.font_size = 64
	game_wins_text.visible = false

	game_restart_button = camus.ui_create_button(&game_scene)
	game_restart_button.click = game_restart
	game_restart_button.color.r = 128
	game_restart_button.color.g = 128
	game_restart_button.color.b = 128
	game_restart_button.color.a = 255
	game_restart_button.padding[0] = 5
	game_restart_button.padding[1] = 5
	game_restart_button.padding[2] = 5
	game_restart_button.padding[3] = 5
	game_restart_button.border_width[0] = 5
	game_restart_button.border_width[1] = 5
	game_restart_button.border_width[2] = 5
	game_restart_button.border_width[3] = 5
	game_restart_button.visible = false

	game_restart_button.text.text = "Restart"
	game_restart_button.text.color.r = 255
	game_restart_button.text.color.g = 255
	game_restart_button.text.color.b = 255
	game_restart_button.text.color.a = 255
	game_restart_button.text.font_name = "Jersey"
	game_restart_button.text.font_size = 24

	camus.ui_init(&game_scene)

	game_window_size_event()
}

window_3rd: [2]f32
window_4th: [2]f32
window_6th: [2]f32
window_24th: [2]f32
// 1/4 + 1/24 = 14/48
window_14_48th: [2]f32
// 1/8 + 1/24 = 8/48
window_8_48th: [2]f32

game_window_size_event :: proc() {
	window_3rd[0] = camus.window_size_f[0] / 3
	window_3rd[1] = camus.window_size_f[1] / 3

	window_4th[0] = camus.window_size_f[0] / 4
	window_4th[1] = camus.window_size_f[1] / 4

	window_6th[0] = camus.window_size_f[0] / 6
	window_6th[1] = camus.window_size_f[1] / 6

	window_14_48th[0] = (camus.window_size_f[0] / 48) * 14
	window_14_48th[1] = (camus.window_size_f[1] / 48) * 14

	window_24th[0] = camus.window_size_f[0] / 24
	window_24th[1] = camus.window_size_f[1] / 24

	window_8_48th[0] = (camus.window_size_f[0] / 48) * 8
	window_8_48th[1] = (camus.window_size_f[1] / 48) * 8

	vertical_lines[0] = window_3rd[0]
	vertical_lines[1] = 0
	vertical_lines[2] = window_3rd[0]
	vertical_lines[3] = camus.window_size_f[1]
	vertical_lines[4] = window_3rd[0] * 2
	vertical_lines[5] = 0
	vertical_lines[6] = window_3rd[0] * 2
	vertical_lines[7] = camus.window_size_f[1]

	horizontal_lines[0] = 0
	horizontal_lines[1] = window_3rd[1]
	horizontal_lines[2] = camus.window_size_f[0]
	horizontal_lines[3] = window_3rd[1]
	horizontal_lines[4] = 0
	horizontal_lines[5] = window_3rd[1] * 2
	horizontal_lines[6] = camus.window_size_f[0]
	horizontal_lines[7] = window_3rd[1] * 2

	player_cursor_rect.w = window_4th[0]
	player_cursor_rect.h = window_4th[1]

	win_background_rect.w = camus.window_size_f[0]
	win_background_rect.h = camus.window_size_f[1]

	camus.ui_set_text_pos(
		game_wins_text,
		(camus.window_size_f[0] / 2) - (game_wins_text.rect.w / 2),
		camus.window_size_f[1] / 2,
	)

	camus.ui_set_button_pos(
		game_restart_button,
		(camus.window_size_f[0] / 2) - (game_restart_button.rect.w / 2),
		game_wins_text.rect.y + game_wins_text.rect.h + 20,
	)
}

game_tick :: proc(delta_time: f64) {
	camus.set_color(line_color)
	camus.draw_line(vertical_lines[0], vertical_lines[1], vertical_lines[2], vertical_lines[3])
	camus.draw_line(vertical_lines[4], vertical_lines[5], vertical_lines[6], vertical_lines[7])

	camus.draw_line(
		horizontal_lines[0],
		horizontal_lines[1],
		horizontal_lines[2],
		horizontal_lines[3],
	)
	camus.draw_line(
		horizontal_lines[4],
		horizontal_lines[5],
		horizontal_lines[6],
		horizontal_lines[7],
	)

	player_cursor_rect.x = window_24th[0] + (window_3rd[0] * f32(user_pos[0]))
	player_cursor_rect.y = window_24th[1] + (window_3rd[1] * f32(user_pos[1]))
	player_color.r = 0
	player_color.b = 255
	if turn == 2 {
		player_color.r = 255
		player_color.b = 0
	}
	camus.draw_rect(player_color, &player_cursor_rect)

	camus.set_color(line_color)
	for x: i32 = 0; x < 3; x += 1 {
		for y: i32 = 0; y < 3; y += 1 {
			switch slots[x][y] {
			case 1:
				camus.draw_line(
					window_24th[0] + (window_3rd[0] * f32(x)),
					window_24th[1] + (window_3rd[1] * f32(y)),
					window_14_48th[0] + (window_3rd[0] * f32(x)),
					window_14_48th[1] + (window_3rd[1] * f32(y)),
				)

				camus.draw_line(
					window_14_48th[0] + (window_3rd[0] * f32(x)),
					window_24th[1] + (window_3rd[1] * f32(y)),
					window_24th[0] + (window_3rd[0] * f32(x)),
					window_14_48th[1] + (window_3rd[1] * f32(y)),
				)
			case 2:
				camus.draw_circle(
					i32(window_8_48th[0]) + (i32(window_3rd[0]) * x),
					i32(window_8_48th[1]) + (i32(window_3rd[1]) * y),
					camus.window_size[1] / 8,
				)
			}
		}
	}

	if winner == 0 {
		return
	}

	if winner < 3 {
		camus.draw_line_color(
			winner_color,
			window_6th[0] + (window_3rd[0] * f32(winner_start_end[0])),
			window_6th[1] + (window_3rd[1] * f32(winner_start_end[1])),
			window_6th[0] + (window_3rd[0] * f32(winner_start_end[2])),
			window_6th[1] + (window_3rd[1] * f32(winner_start_end[3])),
		)
	}
	camus.draw_fill_rect(win_background, &win_background_rect)
	if winner < 3 {
		camus.set_color(player_color)

		if winner == 1 {
			camus.draw_line(
				window_24th[0] + window_3rd[0],
				window_24th[1] + window_4th[1] * 0.75,
				window_14_48th[0] + window_3rd[0],
				window_14_48th[1] + window_4th[1] * 0.75,
			)

			camus.draw_line(
				window_14_48th[0] + window_3rd[0],
				window_24th[1] + window_4th[1] * 0.75,
				window_24th[0] + window_3rd[0],
				window_14_48th[1] + window_4th[1] * 0.75,
			)
		} else {
			camus.draw_circle(
				i32(window_8_48th[0]) + i32(window_3rd[0]),
				i32(window_8_48th[1]) + i32(window_4th[1] * 0.75),
				camus.window_size[1] / 8,
			)
		}

	}

}

game_keyboard_event :: proc(event: sdl.KeyboardEvent) {
	#partial switch event.type {
	case sdl.EventType.KEY_UP:
		switch event.key {
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
			mark_position()
		}
	}
}

mark_position :: proc() {
	if winner != 0 || slots[user_pos[0]][user_pos[1]] != 0 {
		return
	}
	slots[user_pos[0]][user_pos[1]] = turn
	check_victory()
	if winner == 0 {
		if turn == 1 {
			turn = 2
		} else {
			turn = 1
		}
	} else {
		if winner < 3 {
			game_wins_text.text = "WINS"
			camus.ui_set_text_color(
				game_wins_text,
				player_color.r,
				player_color.g,
				player_color.b,
				255,
			)
		} else {
			game_wins_text.text = "TIE"
			camus.ui_set_text_color(game_wins_text, 0, 255, 0, 255)
		}

		game_wins_text.visible = true
		game_restart_button.visible = true
	}
}

game_mouse_motion_event :: proc(event: sdl.MouseMotionEvent) {
	if winner != 0 {
		return
	}
	user_pos[0] = u8(event.x / window_3rd[0])
	user_pos[1] = u8(event.y / window_3rd[1])
}

game_mouse_button_event :: proc(event: sdl.MouseButtonEvent) {
	if event.button == 1 && event.down {
		mark_position()
	}
}

check_victory :: proc() {
	marked_slots: u8 = 0
	for x: u8 = 0; x < 3; x += 1 {
		for y: u8 = 0; y < 3; y += 1 {
			// if that slot has been marked
			if slots[x][y] != 0 {
				marked_slots += 1
				// check horizontally
				if x == 0 {
					if slots[x][y] == slots[x + 1][y] && slots[x][y] == slots[x + 2][y] {
						winner = slots[x][y]
						winner_start_end[0] = x
						winner_start_end[1] = y
						winner_start_end[2] = x + 2
						winner_start_end[3] = y
						set_winner_color()
						return
					}
				}
				// check vertically
				if y == 0 {
					if slots[x][y] == slots[x][y + 1] && slots[x][y] == slots[x][y + 2] {
						winner = slots[x][y]
						winner_start_end[0] = x
						winner_start_end[1] = y
						winner_start_end[2] = x
						winner_start_end[3] = y + 2
						set_winner_color()
						return
					}
				}
				// check diagonals
				if x == 0 && y == 0 {
					if slots[x][y] == slots[x + 1][y + 1] && slots[x][y] == slots[x + 2][y + 2] {
						winner = slots[x][y]
						winner_start_end[0] = x
						winner_start_end[1] = y
						winner_start_end[2] = x + 2
						winner_start_end[3] = y + 2
						set_winner_color()
						return
					}
				}
				if x == 2 && y == 0 {
					if slots[x][y] == slots[x - 1][y + 1] && slots[x][y] == slots[x - 2][y + 2] {
						winner = slots[x][y]
						winner_start_end[0] = x
						winner_start_end[1] = y
						winner_start_end[2] = x - 2
						winner_start_end[3] = y + 2
						set_winner_color()
						return
					}
				}
			}
		}
	}
	if marked_slots == 9 && winner == 0 {
		winner = 3
	}
}

set_winner_color :: proc() {
	if winner == 1 {
		winner_color = sdl.Color{0, 0, 255, 255}
	} else {
		winner_color = sdl.Color{255, 0, 0, 255}
	}
}


game_destroy :: proc() {
}

game_restart :: proc(button: ^camus.UIButton) {
	camus.ui_button_hide(game_restart_button)
	game_wins_text.visible = false
	winner = 0
	user_pos[0] = 0
	user_pos[1] = 0
	for x := 0; x < 3; x += 1 {
		for y := 0; y < 3; y += 1 {
			slots[x][y] = 0
		}
	}
}
