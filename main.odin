package main

import "camus"
import "camus/vector2"

main :: proc() {
	camus.debug = true
	camus.init = init
	camus.tick = tick
	camus.background_color = camus.Color{0, 0, 0, 255}
	camus.window_size = vector2.Vector2Int{640, 480}
	camus.run()
}

init :: proc () {
	//
}

tick :: proc() {
	camus.draw_line(camus.Color{255, 255, 255, 255}, vector2.Vector2{0, 0}, vector2.Vector2{640, 840})
}
