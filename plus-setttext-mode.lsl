// Script Created by Hailey Enfield
// Site: https://links.hails.cc/
// Github: https://github.com/Hailey-Ross/hails.rgb
// PLEASE LEAVE ALL CREDITS/COMMENTS INTACT
float STEP = 0.05;
float TICK = 0.10;

vector rgb = <0.0, 1.0, 0.0>; // start green
integer phase = 0;            // 0:R up, 1:G down, 2:B up, 3:R down, 4:G up, 5:B down

string settext;

// Light settings
float L_INTENSITY = 1.0;
float L_RADIUS    = 10.0;
float L_FALLOFF   = 0.75;

// How often to re-check Description (every N timer ticks)
integer DESC_REFRESH_TICKS = 20; // 20 * 0.10s = every 2 seconds
integer descCounter = 0;

default
{
    on_rez(integer start_param) { llResetScript(); }

    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }

    state_entry()
    {
        settext = llGetObjectDesc();
        llSleep(llFrand(5.0));
        llSetTimerEvent(TICK);

        llSetText(settext, rgb, 1.0);
        llSetPrimitiveParams([
            PRIM_POINT_LIGHT, TRUE, rgb, L_INTENSITY, L_RADIUS, L_FALLOFF
        ]);
    }

    timer()
    {
        // Transition (clamped, smooth, same pattern)
        if (phase == 0) { rgb.x += STEP; if (rgb.x >= 1.0) { rgb.x = 1.0; phase = 1; } }
        else if (phase == 1) { rgb.y -= STEP; if (rgb.y <= 0.0) { rgb.y = 0.0; phase = 2; } }
        else if (phase == 2) { rgb.z += STEP; if (rgb.z >= 1.0) { rgb.z = 1.0; phase = 3; } }
        else if (phase == 3) { rgb.x -= STEP; if (rgb.x <= 0.0) { rgb.x = 0.0; phase = 4; } }
        else if (phase == 4) { rgb.y += STEP; if (rgb.y >= 1.0) { rgb.y = 1.0; phase = 5; } }
        else { rgb.z -= STEP; if (rgb.z <= 0.0) { rgb.z = 0.0; phase = 0; } }

        // Occasionally refresh Description (since there's no CHANGED_DESCRIPTION)
        descCounter++;
        if (descCounter >= DESC_REFRESH_TICKS)
        {
            descCounter = 0;

            string newText = llGetObjectDesc();
            if (newText != settext)
                settext = newText;
        }

        llSetText(settext, rgb, 1.0);
    }
}
