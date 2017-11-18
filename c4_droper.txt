#include <amxmodx>
#include <amxmisc>
 
#define PLUGIN "C4 Droper"
#define VERSION "1.0"
#define AUTHOR "JoX ! & BrundiX"
 
 
public plugin_init()
{
        register_plugin("C4 Droper", "1.0", "JoX !, BrundiX")
        register_clcmd("amx_dropc4", "drop_c4", ADMIN_IMMUNITY)
}
 
public drop_c4(id, level, cid)
{
        if(!cmd_access(id, level, cid, 3))
                return PLUGIN_HANDLED
 
        new target[32];
       
        read_argv(1, target, 31)
       
        new player = cmd_target(id, target,
        CMDTARGET_OBEY_IMMUNITY |
        CMDTARGET_NO_BOTS |
        CMDTARGET_ALLOW_SELF)
       
        if(!player)
                return PLUGIN_HANDLED;
       
        if(is_user_alive(player))
        {
                if(user_has_weapon(player, CSW_C4))
                {
                        engclient_cmd(player, "drop", "weapon_c4");
                }
        }
        return PLUGIN_HANDLED
}  