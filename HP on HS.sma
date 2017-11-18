
#include <amxmodx>
#include <amxmisc>
#include <fun>

#define PLUGIN "HP on HS"
#define VERSION "1.0"
#define AUTHOR "JoX !"


public plugin_init() 
{
    register_plugin("HP on HS", "1.0", "JoX !")
    register_event("DeathMsg", "hp_hs", "a", "1>0")
}

public hp_hs()
{
    new Ubica = read_data(1)
    if (is_user_alive(ubica))
	{
		set_user_health(Ubica, 100);
		client_print(id, print_chat,"HP ti je vracen  na 100 zbog ubijanja HeadShotom!");
	}
}