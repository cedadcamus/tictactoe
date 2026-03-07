package main

import "core:fmt"
import "camus"
import sdl "vendor:sdl3"

main :: proc() {
	camus.debug = true
	camus.init = init
	camus.tick = tick
	camus.background_color = camus.Color{0, 0, 0, 255}
	camus.run()
}

init :: proc () {
	//
}

tick :: proc() {
	camus.draw_line(camus.Color{255, 255, 255, 255}, camus.Vector2{0, 0}, camus.Vector2{640, 840})
}
