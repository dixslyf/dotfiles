/* Copyright 2021 weteor
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include QMK_KEYBOARD_H

enum layers
{
    _ALPHA_QWERTY = 0,
    _ALPHA_COLEMAK,
    _SYM,
    _NAV,
    _NUM,
    _CFG,
};

bool process_mods_always_on_l0(uint16_t keycode, keyrecord_t *record) {
    static uint32_t saved_default_layer_state = 0;
    static bool     mod_active_prev           = false;

    // Get the state of modifiers except for shift,
    // since we don't want to go back to layer 0 when
    // shift is the only modifier active.
    uint8_t mods         = get_mods() & ~MOD_MASK_SHIFT;
    uint8_t oneshot_mods = get_oneshot_mods() & ~MOD_MASK_SHIFT;

    // No modifiers active.
    if (!mods && !oneshot_mods) {
        // This key was the release of the last modifier,
        // so we restore the default layer state.
        if (mod_active_prev) {
            default_layer_set(saved_default_layer_state);
            mod_active_prev = false;
        }
        return true;
    }

    // At least one modifier (excluding shift) is active.

    // This key is not the first modifier to become active,
    // so nothing to do.
    if (mod_active_prev) {
        return true;
    }

    // This key is the first modifier to become active,
    // so set the default layer to layer 0.
    saved_default_layer_state = default_layer_state;
    set_single_default_layer(0);
    mod_active_prev = true;
    return true;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    return process_mods_always_on_l0(keycode, record);
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    
    [_ALPHA_QWERTY] = LAYOUT_split_3x5_3(
        KC_Q,         KC_W,    KC_E,    KC_R,    KC_T,                                                KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,  
        KC_A,         KC_S,    KC_D,    KC_F,    KC_G,                                                KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN,
        LSFT_T(KC_Z), KC_X,    KC_C,    KC_V,    KC_B,                                                KC_N,    KC_M,    KC_COMM, KC_DOT,  RSFT_T(KC_SLSH),
            
                        LCTL_T(KC_ESC), LT(_NUM,KC_SPC), LT(_NAV, KC_TAB),     LT(_SYM, KC_BSPC), KC_ENT, LALT_T(KC_DEL)         
    ),
    [_ALPHA_COLEMAK] = LAYOUT_split_3x5_3(
        KC_Q,         KC_W,    KC_F,    KC_P,    KC_G,                                                KC_J,    KC_L,    KC_U,    KC_Y,    KC_QUOT,
        KC_A,         KC_R,    KC_S,    KC_T,    KC_D,                                                KC_H,    KC_N,    KC_E,    KC_I,    KC_O,
        LSFT_T(KC_Z), KC_X,    KC_C,    KC_V,    KC_B,                                                KC_K,    KC_M,    KC_COMM, KC_DOT,  RSFT_T(KC_SCLN),
                        LCTL_T(KC_ENT), LT(_NUM,KC_SPC), LT(_NAV, KC_TAB),     LT(_SYM, KC_BSPC), KC_ENT, LALT_T(KC_DEL)         
    ),
    [_SYM] = LAYOUT_split_3x5_3(
        KC_GRV , KC_CIRC,   KC_AT,  KC_DLR, KC_TILD,                                KC_AMPR, KC_EXLM, KC_PIPE, KC_UNDS, KC_HASH,
        KC_SLSH, KC_LBRC, KC_LCBR, KC_LPRN,  KC_EQL,                                KC_ASTR, KC_RPRN, KC_RCBR, KC_RBRC, KC_BSLS, 
        _______, KC_QUES, KC_PLUS, KC_PERC, XXXXXXX,                                XXXXXXX, XXXXXXX, KC_MINS, XXXXXXX, _______,
                                        XXXXXXX, MO(_CFG), XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX         
    ),
    [_NAV] = LAYOUT_split_3x5_3(
        XXXXXXX, KC_VOLD, KC_MUTE, KC_VOLU, XXXXXXX,                                XXXXXXX, KC_PGDN,   KC_UP, KC_PGUP,  KC_DEL,
        KC_MPRV, KC_MPLY, KC_MSTP, KC_MNXT, XXXXXXX,                                KC_HOME, KC_LEFT, KC_DOWN, KC_RGHT,  KC_END,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                                XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                                        XXXXXXX, XXXXXXX, XXXXXXX,      XXXXXXX, MO(_CFG), XXXXXXX         
    ),
    [_NUM] = LAYOUT_split_3x5_3(
        XXXXXXX,  KC_F9, KC_F10, KC_F11, KC_F12,                                    KC_PPLS,  KC_P7,  KC_P8,  KC_P9, KC_PSLS,
        XXXXXXX,  KC_F5,  KC_F6,  KC_F7,  KC_F8,                                    KC_P0,  KC_P4,  KC_P5,  KC_P6, KC_PDOT,
        XXXXXXX,  KC_F1,  KC_F2,  KC_F3,  KC_F4,                                    KC_PMNS,  KC_P1,  KC_P2,  KC_P3, KC_PAST,
                                        XXXXXXX, XXXXXXX, XXXXXXX,      KC_PEQL, KC_PENT, XXXXXXX
    ),
    [_CFG] = LAYOUT_split_3x5_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                                XXXXXXX, XXXXXXX, XXXXXXX,DF(_ALPHA_QWERTY), DF(_ALPHA_COLEMAK),
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                                XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                                XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,
                                         XXXXXXX, XXXXXXX, XXXXXXX,     XXXXXXX, XXXXXXX, XXXXXXX
    ),
};
