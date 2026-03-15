package main

import "camus"
import sdl "vendor:sdl3"
import "vendor:sdl3/ttf"
import "core:log"
import "base:runtime"

welcome_title: camus.UIText


welcome_init :: proc() {
    camus.ui_add_font("Doto", "Doto-VariableFont_ROND,wght.ttf", 32)
    
    camus.ui_init_text(&welcome_title, 0, 255, 255, 255, "Tic Tac Toe", "Doto", 32)
    
    window_size: [2]i32 = {0, 0}
    sdl.GetWindowSize(camus.window, &window_size[0], &window_size[1])
    welcome_title.rect.x = (f32(window_size[0]) / 2) - (welcome_title.rect.w / 2)
    welcome_title.rect.y = 50
    
}

welcome_tick :: proc(delta_time: f64) {
    sdl.RenderTexture(camus.renderer, welcome_title.texture, nil, &welcome_title.rect)
}

welcome_destroy :: proc() {
    sdl.DestroyTexture(welcome_title.texture)
}

/*
Solid

    transparency by colorkey (0 pixel)
    very fast but low quality
    8-bit palettized RGB surface
    Functions
        TTF_RenderText_Solid(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color): PSDL_Surface
        TTF_RenderText_Solid_Wrapped(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color; wrapLength: cint): PSDL_Surface
        TTF_RenderGlyph_Solid(font: PTTF_Font; ch: cuint32; fg: TSDL_Color): PSDL_Surface

Shaded

    antialiasing
    slower than solid rendering, but high quality
    8-bit palettized RGB surface
    Functions
        TTF_RenderText_Shaded(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color; bg: TSDL_Color): PSDL_Surface
        TTF_RenderText_Shaded_Wrapped(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color; bg: TSDL_Color; wrap_width: cint): PSDL_Surface
        TTF_RenderGlyph_Shaded(font: PTTF_Font; ch: cuint32; fg: TSDL_Color; bg: TSDL_Color): PSDL_Surface

Blended

    transparency (alpha channel)
    antialiasing
    slow but very high quality
    32-bit unpalettized (RGBA) surface
    Functions
        TTF_RenderText_Blended(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color): PSDL_Surface
        TTF_RenderText_Blended_Wrapped(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color; wrap_width: cint): PSDL_Surface
        TTF_RenderGlyph_Blended(font: PTTF_Font; ch: cuint32; fg: TSDL_Color): PSDL_Surface

LCD

    sub-pixel rendering
    slow but very high quality
    32-bit unpalettized (RGBA) surface
    Functions
        TTF_RenderText_LCD(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color; bg: TSDL_Color): PSDL_Surface
        TTF_RenderText_LCD_Wrapped(font: PTTF_Font; text: PAnsiChar; length: csize_t; fg: TSDL_Color; bg: TSDL_Color; wrap_width: cint): PSDL_Surface
        TTF_RenderGlyph_LCD(font: PTTF_Font; ch: cuint32; fg: TSDL_Color; bg: TSDL_Color): PSDL_Surface


*/
