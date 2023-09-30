float hailRed = 0;
float hailGrn = 1;
float hailBlu = 0;
float hailtimer = 0.1;
string color = "hailsRedUp";

default
{
     on_rez(integer start_param)
    {
         llResetScript();
    }
     changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }
     state_entry()
    {
         llSleep(llFrand(5));
         llSetTimerEvent(hailtimer);
    }
     timer()
    {
            if(color == "hailsRedUp"){
                if(hailRed <= 1){
                    hailRed += 0.05;
                }else{
                    color = "hailsGrnDown";
                }
            }else if(color == "hailsRedDown"){
                 if(hailRed >= 0){
                    hailRed -= 0.05;
                }else{
                    color = "hailsGrnUp";
                }  
            }else if(color == "hailsGrnUp"){
                if(hailGrn <= 1){
                    hailGrn += 0.05;
                }else{
                    color = "hailsBluDown";
                }   
            }else if(color == "hailsGrnDown"){
               if(hailGrn>=0){
                    hailGrn -= 0.05;
                }else{
                    color = "hailsBluUp";
                }   
            }else if(color == "hailsBluUp"){
                 if(hailBlu<=1){
                    hailBlu += 0.05;
                }else{
                    color = "hailsRedDown";
                }   
            }else if(color == "hailsBluDown"){
                if(hailBlu>=0){
                    hailBlu -= 0.05;
                }else{
                    color = "hailsRedUp";
                }   
            }
        llSetPrimitiveParams([PRIM_COLOR, ALL_SIDES, <hailRed, hailGrn, hailBlu>, 1.0]); 
    }
}
    
