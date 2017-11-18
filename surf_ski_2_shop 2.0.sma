#include <amxmodx>  
#include <fun> 
#include <cstrike> 
#include <fakemeta>

#define PLUGIN "Surf_ski_2 Shop"
#define VERSION "2.0"
#define AUTHOR "JoX !"

static const Mario_Room[][ 3 ] = 
{ 
    { 3610, 1053, -2317 }, 
    { 3612,  629, -2317 }, 
    { 3403, 1079, -2273 }, 
    { 3081, 1091, -2317 }, 
    { 3391,  641, -2317 }, 
    { 3056,  578, -2317 }, 
    { 3116,  285, -2275 }, 
    { 3343,  245, -2317 } 
};

static const Gun_Room[][ 3 ] = 
{ 
    { -689, -949, -138 }, 
    { -590, -958, -138 }, 
    { -485, -947, -138 }, 
    { -396, -961, -138 }, 
    { -324, -960, -138 }, 
    { -688, -840, -138 }, 
    { -594, -844, -138 }, 
    { -486, -866, -138 }, 
    { -398, -852, -138 }, 
    { -331, -845, -138 }, 
    { -383, -697, -138 }, 
    { -317, -683, -138 } 
};

new const Item_Names[][] = 
{
    "HE Grenade",
    "HP",
    "Benelli M3 Super90 & XM1014 (Pumpara :D)",
    "Gun Room",
    "Mario Room"
};

new const Cvar_Price[sizeof(Item_Names)][] =
{
    "surf_he_cost",
    "surf_hp_cost",
    "surf_benelli1_cost",
    "surf_gunroom_cost",
    "surf_marioroom_cost"
};

new const Item_Price[sizeof(Cvar_Price)][] = 
{
    1000,
    5000,
    7000,
    10000,
    12000
};

new g_msgSayText;

new cvar_pointer[sizeof(Cvar_Price)];

public plugin_init()  
{ 
    register_plugin( "Surf_ski_2 Shop", "v1.0", "JoX !" )
    
    register_clcmd("say /shop", "SurfShop")
    register_clcmd("say_team /shop", "SurfShop")
    
    for(new i = 0; i < sizeof(Cvar_Price); i++)
        cvar_pointer[i] = register_cvar(Cvar_Price[i], Item_Price[i]);
    
    g_msgSayText = get_user_msgid( "SayText" );
}

public SurfShop(id) 
{ 
    if(is_user_alive(id)) 
    {
        new Menu_Items[64];
        formatex(Menu_Items, charsmax(Menu_Items), "SS2 Shop Menu")
        new Menu = menu_create(Menu_Items, "SS2Menu_Handle")
        new CallBack = menu_makecallback("SS2Menu_Callback");

        for(new i = 0;i<sizeof Item_Names;i++)
        {
            formatex(Menu_Items, charsmax(Menu_Items),"%s [%d$]", Item_Names[i], get_pcvar_num(cvar_pointer[i]));
            menu_additem(Menu, Menu_Items, _, _, CallBack);
        }
        menu_display(id, Menu) 
    } 
}

public SS2Menu_CallBack(id, menu, item)
{
    if(get_pcvar_num(cvar_pointer[item]) > cs_get_user_money(id))
        return ITEM_DISABLED;
        
    return ITEM_ENABLED;
}

public SS2Menu_Handle(id,menu,item) 
{ 
    if(item==MENU_EXIT) 
    { 
        menu_destroy(menu) 
        return PLUGIN_HANDLED         
    } 
    
    cs_set_user_money(id, cs_get_user_money(id) - get_pcvar_num(cvar_pointer[item]));
    ChatColor(id, "Kupio si item: !4%s!", Item_Names[item]);
    
    switch(item) 
    {  
        case 0:  
            give_item(id, "weapon_hegrenade")       
        case 1: 
            set_user_health(id,get_user_health(id) +200);
        case 2:  
        { 
            give_item(id, "weapon_m3") 
            give_item(id, "weapon_xm1014") 
        } 
        case 3:  
            set_user_origin(id, Gun_Room[ random_num( 0, charsmax( Gun_Room ) ) ] );  
        case 4:
            set_user_origin(id, Mario_Room[random_num(0,charsmax(Mario_Room))]); 
    }
    menu_destroy(menu);
    
    return PLUGIN_CONTINUE 
}

stock ChatColor(const id, const input[], any:...)
{
    new count = 1, players[32]
    static msg[191]
    vformat(msg, 190, input, 3)
    
    replace_all(msg, 190, "!g", "^4") // Green Color
    replace_all(msg, 190, "!y", "^1") // Default Color
    replace_all(msg, 190, "!t", "^3") // Team Color
    
    if (id) players[0] = id; else get_players(players, count, "ch")
    {
        for (new i = 0; i < count; i++)
        {
            if (is_user_connected(players[i]))
            {
                message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, players[i])
                write_byte(players[i]);
                write_string(msg);
                message_end();
            }
        }
    }
}  