if (!active) return; // Don't draw if menu inactive.

// Font settings.
draw_set_font(global.font_main);
draw_set_valign(fa_center);
draw_set_halign(fa_middle);

// Calls State Machine.
state();
