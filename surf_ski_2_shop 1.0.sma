#include <amxmodx>
#include <amxmisc>
#include <fun>
#include <cstrike>
#include <fakemeta>

#define PLUGIN "Surf_ski_2 Shop"
#define VERSION "1.0"
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

public plugin_init() 
{
    register_plugin( "Surf_ski_2 Shop", "v1.0", "JoX !" )
    register_concmd("say /shop","SurfShop") // Say Commang
    register_concmd("say_team /shop","SurfShop") // TSAY Command
}
public SurfShop(id)
{
    if(is_user_alive(id))
    {
        new menu= menu_create("Surf_ski_2 Shop Menu","menu_handler")
        menu_additem(menu,"HE Grenade (1000$)")
        menu_additem(menu,"HP (5000$)")
        menu_additem(menu,"Benelli M3 Super90 (Pumpara :D) (7000$)")
        menu_additem(menu,"Benelli M3 XM1014 (Pumpara :D) (7000$)")
        menu_additem(menu,"Gun Room (10000$)")
        menu_additem(menu,"Mario Room (12000$)")

        menu_display(id,menu)
    }
}
public menu_handler(id,menu,item)
{
    if(item==MENU_EXIT)
    {
        menu_destroy(menu)         // Closing Menu
        return PLUGIN_CONTINUE        
    }
    new cena
    switch(item)
    { 
        case 0: 
        {
            cena=1000
            if(cs_get_user_money(id)<cena)
            {
                client_print(id,print_chat,"Nemas dovoljno para da bi kupio ovaj item!")
            
            }
            else
            {
                give_item(id, "weapon_hegrenade")
                cs_set_user_money(id, cs_get_user_money(id) - cena)
                client_print(id, print_chat,"Kupio si HE Grenade!")
            }
        }    
        case 1: 
        {
            cena=5000
            if(cs_get_user_money(id)<cena)
            {
                client_print(id,print_chat,"Nemas dovoljno para da bi kupio ovaj item!")
            
            }
            else
            {
                new hp = get_user_health(id)
                set_user_health(id,hp+200);
                cs_set_user_money(id, cs_get_user_money(id) - cena)
                client_print(id, print_chat,"Kupio si 200 HP!")
            }
        }
        case 2: 
        {
            cena=7000
            if(cs_get_user_money(id)<cena)
            {
                client_print(id,print_chat,"Nemas dovoljno para da bi kupio ovaj item!")
            
            }
            else
            {
                give_item(id, "weapon_m3")
                cs_set_user_money(id, cs_get_user_money(id) - cena)
                client_print(id, print_chat,"Kupio si Benelli M3 Super90 (Pumparu :D)!")
            }      
        }
        case 3: 
        {
            cena=7000
            if(cs_get_user_money(id)<cena)
            {
                client_print(id,print_chat,"Nemas dovoljno para da bi kupio ovaj item!")
            
            }
            else
            {
                give_item(id, "weapon_xm1014")
                cs_set_user_money(id, cs_get_user_money(id) - cena)
                client_print(id, print_chat,"Kupio si Benelli  XM1014 (Pumparu :D)!")
            }      
        }
        case 4: 
        {
            cena=10000
            if(cs_get_user_money(id)<cena)
            {
                client_print(id,print_chat,"Nemas dovoljno para da bi kupio ovaj item!")
            
            }
            else
            {
                set_user_origin(id, Gun_Room[ random_num( 0, charsmax( Gun_Room ) ) ] );
                client_print(id, print_chat,"Teleportovao si se u Gun Room!")
                cs_set_user_money(id, cs_get_user_money(id) - cena)
            }
        }
        case 5: 
        {
            cena=12000
            if(cs_get_user_money(id)<cena)
            {
                client_print(id,print_chat,"Nemas dovoljno para da bi kupio ovaj item!")
            
            }
            else
            {
                set_user_origin(id, Mario_Room[random_num(0,charsmax(Mario_Room))]);
                client_print(id, print_chat,"Teleportovao si se u Mario Room!")
                cs_set_user_money(id, cs_get_user_money(id) - cena)
                 }
            
             }
    return PLUGIN_CONTINUE
}