// Script Created by Hailey Enfield
// Site: https://links.hails.cc/
// Github: https://github.com/Hailey-Ross/hails.rgb
// PLEASE LEAVE ALL CREDITS/COMMENTS INTACT
float STEP = 0.05;
float TICK = 0.10;

vector rgb = <0.0, 1.0, 0.0>; // start green
integer phase = 4;            // 0:R up, 1:G down, 2:B up, 3:R down, 4:G up, 5:B down

string settext;

// How often to re-check Description (every X timer ticks)
integer DESC_REFRESH_TICKS = 100; // 100 * 0.10s = every 10 seconds
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
    }

    timer()
    {
        if (phase == 0) { rgb.x += STEP; if (rgb.x >= 1.0) { rgb.x = 1.0; phase = 1; } }
        else if (phase == 1) { rgb.y -= STEP; if (rgb.y <= 0.0) { rgb.y = 0.0; phase = 2; } }
        else if (phase == 2) { rgb.z += STEP; if (rgb.z >= 1.0) { rgb.z = 1.0; phase = 3; } }
        else if (phase == 3) { rgb.x -= STEP; if (rgb.x <= 0.0) { rgb.x = 0.0; phase = 4; } }
        else if (phase == 4) { rgb.y += STEP; if (rgb.y >= 1.0) { rgb.y = 1.0; phase = 5; } }
        else { rgb.z -= STEP; if (rgb.z <= 0.0) { rgb.z = 0.0; phase = 0; } }

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
