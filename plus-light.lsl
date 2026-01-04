// Script Created by Hailey Enfield
// Site: https://links.hails.cc/
// Github: https://github.com/Hailey-Ross/hails.rgb
// PLEASE LEAVE ALL CREDITS/COMMENTS INTACT
float STEP = 0.05;
float TICK = 0.10;

vector rgb = <0.0, 1.0, 0.0>; // start green
integer phase = 0;            // 0:R up, 1:G down, 2:B up, 3:R down, 4:G up, 5:B down

// Light settings (tweak these!)
float L_INTENSITY = 0.6;  // 0.0 - 1.0
float L_RADIUS    = 3.0; // meters
float L_FALLOFF   = 0.75; // 0.0 - 2.0-ish

default
{
    on_rez(integer p) { llResetScript(); }

    changed(integer c)
    {
        if (c & CHANGED_OWNER) llResetScript();
    }

    state_entry()
    {
        llSleep(llFrand(5.0));
        llSetTimerEvent(TICK);
    }

    timer()
    {
        if (phase == 0) { rgb.x += STEP; if (rgb.x >= 1.0) { rgb.x = 1.0; phase = 1; } }
        else if (phase == 1) { rgb.y -= STEP; if (rgb.y <= 0.0) { rgb.y = 0.0; phase = 2; } }
        else if (phase == 2) { rgb.z += STEP; if (rgb.z >= 1.0) { rgb.z = 1.0; phase = 3; } }
        else if (phase == 3) { rgb.x -= STEP; if (rgb.x <= 0.0) { rgb.x = 0.0; phase = 4; } }
        else if (phase == 4) { rgb.y += STEP; if (rgb.y >= 1.0) { rgb.y = 1.0; phase = 5; } }
        else { rgb.z -= STEP; if (rgb.z <= 0.0) { rgb.z = 0.0; phase = 0; } }

        // Update surface color + point light color to match
        llSetPrimitiveParams([
            PRIM_COLOR, ALL_SIDES, rgb, 1.0,
            PRIM_POINT_LIGHT, TRUE, rgb, L_INTENSITY, L_RADIUS, L_FALLOFF
        ]);
    }
}
