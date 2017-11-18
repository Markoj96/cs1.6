#include <amxmodx>
#include <amxmisc>
#include <fakemeta>

#define PLUGIN "Surf VIP Admin"
#define VERSION "1.0"
#define AUTHOR "JoX !"

static const COLOR[] = "^x04"

new g_max_players;
new gmsgSayText;

public plugin_init()
{
    register_plugin("Surf VIP Admin", "1.0", "JoX !")
    register_event("MsgHUD","vip_message","be");
    
    register_clcmd("say /vip","vip_admin",0,"- Shows admins online.")
    register_clcmd("say", "commands")
    register_clcmd("say_team", "commands")
    
    gmsgSayText = get_user_msgid("SayText");
    g_max_players = get_maxplayers();
}

public vip_message(id)
{
    if(is_user_connected(id) && access(id, ADMIN_CHAT))
    {
        return PLUGIN_CONTINUE;
    }
    client_print(id, print_chat, "Say /vip da bi ste videli VIP prednosti")
    
    set_task(1.0,"vip_items",id);
    return PLUGIN_CONTINUE;
}

public vip_items(id)
{
    if(is_user_connected(id))
        return;
        
    new nick[32]
    get_user_name(id, nick, 31)
   
    new armor = get_user_armor(id)
    new hp = get_user_health(id)
   
    set_user_armor(id,armor+500);  // Stavlja igracu +500 Armora na njegov trenutni Armor
    set_user_health(id,hp+500); // Stavlja igracu +500 HP na njegov trenutni HP
    set_user_maxspeed(id, 3500.0);  // Povecava brzinu kretanja
    give_item(id, "weapon_hegrenade");
    give_item(id, "weapon_xm1014");
    give_item(id, "weapon_m3");
    server_cmd("sjp_givesj %s", nick) // Potreban Syn Surf Jetpack Plugin :)
}

public commands(id)
{
    new say[192]
    read_args(say,192)
    if(( contain(say, "/vip") != -1))
    {
        set_task(0.1, "print_vipadmins", id)
    }
    return PLUGIN_CONTINUE
}

public vip_admin(id,level,cid) 
{

    if (!cmd_access(id,level,cid,1))
    return PLUGIN_CONTINUE
    
    show_motd(id,"vip.txt","Surf VIP Admin by JoX !")
    return PLUGIN_CONTINUE   
}

public print_vipadmins(user) 
{
    new adminnames[33][32]
    new message[256]
    new id, count, x, len
    
    for(id = 1 ; id <= g_max_players ; id++)
        if(is_user_connected(id))
            if(get_user_flags(id) & ADMIN_CHAT)
                get_user_name(id, adminnames[count++], 31)

    len = format(message, 255, "%s Online VIP Admins: ",COLOR)
    if(count > 0) {
        for(x = 0 ; x < count ; x++) {
            len += format(message[len], 255-len, "%s%s ", adminnames[x], x < (count-1) ? ", ":"")
            if(len > 96 ) {
                print_message(user, message)
                len = format(message, 255, "%s ",COLOR)
            }
        }
        print_message(user, message)
    }
    else 
    {
        len += format(message[len], 255-len, "No online VIP Admins.")
        print_message(user, message)
    }
}

print_message(id, msg[])
{
    message_begin(MSG_ONE, gmsgSayText, {0,0,0}, id)
    write_byte(id)
    write_string(msg)
    message_end()
}

/*    FM Util        */

stock set_user_armor(index, armor)
{
    set_pev(index, pev_armorvalue, float(armor));
    return 1;
}

stock set_user_health(index, health)
{
    health > 0 ? set_pev(index, pev_health, float(health)) : dllfunc(DLLFunc_ClientKill, index);
    return 1;
}

stock give_item(index, const item[])
{
    if (!equal(item, "weapon_", 7) && !equal(item, "ammo_", 5) && !equal(item, "item_", 5) && !equal(item, "tf_weapon_", 10))
        return 0;

    new ent = engfunc(EngFunc_CreateEntity, engfunc(EngFunc_AllocString, item));
    
    if (!pev_valid(ent))
        return 0;

    new Float:origin[3];
    pev(index, pev_origin, origin);
    set_pev(ent, pev_origin, origin);
    set_pev(ent, pev_spawnflags, pev(ent, pev_spawnflags) | SF_NORESPAWN);
    dllfunc(DLLFunc_Spawn, ent);

    new save = pev(ent, pev_solid);
    dllfunc(DLLFunc_Touch, ent, index);
    if (pev(ent, pev_solid) != save)
        return ent;

    engfunc(EngFunc_RemoveEntity, ent);

    return -1;
}

stock set_user_maxspeed(index, Float:speed = -1.0)
{
    engfunc(EngFunc_SetClientMaxspeed, index, speed);
    set_pev(index, pev_maxspeed, speed);

    return 1;
}  