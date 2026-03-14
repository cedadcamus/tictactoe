package main

import "camus"
import sdl "vendor:sdl3"
import "vendor:sdl3/ttf"
import "core:log"
import "base:runtime"

welcome_text_surface: ^sdl.Surface
welcome_text_texture: ^sdl.Texture
welcome_text_rect: sdl.FRect


welcome_init :: proc() {
    welcome_font = ttf.OpenFont("Doto-VariableFont_ROND,wght.ttf", 32)
	if welcome_font == nil {
		camus.is_running = false
		log.log(runtime.Logger_Level.Error, sdl.GetError())
	}
    
    color: sdl.Color
    color.r = 0
    color.g = 255
    color.b = 255
    color.a = 255
    welcome_text_surface = ttf.RenderText_Blended(welcome_font, "Tic Tac Toe", 0, color)
    welcome_text_texture = sdl.CreateTextureFromSurface(camus.renderer, welcome_text_surface)
    sdl.GetTextureSize(welcome_text_texture, &welcome_text_rect.w, &welcome_text_rect.h)
    window_size: [2]i32 = {0, 0}
    sdl.GetWindowSize(camus.window, &window_size[0], &window_size[1])
    welcome_text_rect.x = (f32(window_size[0]) / 2) - (welcome_text_rect.w / 2)
    welcome_text_rect.y = 50
}

welcome_tick :: proc(delta_time: f64) {
    sdl.RenderTexture(camus.renderer, welcome_text_texture, nil, &welcome_text_rect)
}

welcome_destroy :: proc() {
    ttf.CloseFont(welcome_font)
    sdl.DestroySurface(welcome_text_surface)
    sdl.DestroyTexture(welcome_text_texture)
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
