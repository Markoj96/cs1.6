#include <amxmisc>
#include <amxmodx>
#include <fun>
#include <cstrike>

#define PLUGIN "Reset Score"
#define VERSION "1.0"
#define AUTHOR "JoX !"


public plugin_init() 
{
    register_plugin("Reset Score", "1.0", "JoX !")
    
    //Commands / Komande
    register_clcmd("say /rs", "resetscore")
    register_clcmd("say_team /rs", "resetscore")
}

public resetscore (id)
{
        new price=800
        if(cs_get_user_money(id)<price)
    {
        client_print(id,print_chat,"Nemas dovoljno para da bi restartovao svoj score!")
        return PLUGIN_HANDLED        
    }
    else
    {
        set_user_frags(id, 0)
        cs_set_user_deaths(id, 0)
        set_user_frags(id, 0)
        cs_set_user_deaths(id, 0)
    
        cs_set_user_money(id, cs_get_user_money(id) - price)
        client_print(id, print_chat, "Uspesno si restartovao svoj score (-800$)");
        return PLUGIN_HANDLED
    }
}  