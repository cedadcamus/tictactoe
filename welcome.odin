package main

import "camus"
import sdl "vendor:sdl3"
import "vendor:sdl3/ttf"
import "core:log"
import "base:runtime"

welcome_title: ^camus.UIText
welcome_start_button: camus.UIButton

welcome_init :: proc() {
    camus.ui_add_font("Jersey", "Jersey10-Regular.ttf", 16)
    camus.ui_add_font("Doto", "Doto-VariableFont_ROND,wght.ttf", 32)
    
    welcome_title = camus.ui_create_text()
    welcome_title.text = "Tic Tac Toe"
    welcome_title.color.r = 0
    welcome_title.color.g = 255
    welcome_title.color.b = 255
    welcome_title.color.a = 255
    welcome_title.font_name = "Doto"
    welcome_title.font_size = 32
}

welcome_ready :: proc() {
    window_size: [2]i32 = {0, 0}
    sdl.GetWindowSize(camus.window, &window_size[0], &window_size[1])
    welcome_title.rect.x = (f32(window_size[0]) / 2) - (welcome_title.rect.w / 2)
    welcome_title.rect.y = 50
}

welcome_tick :: proc(delta_time: f64) {
    //
}

welcome_destroy :: proc() {
    sdl.DestroyTexture(welcome_title.texture)
}
