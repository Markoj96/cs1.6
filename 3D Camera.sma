#include <amxmodx>
#include <amxmisc>
#include <engine>

#define PLUGIN "3D Camera"
#define VERSION "1.1"
#define AUTHOR "JoX !"


public plugin_init() 
{
    register_plugin("3D Camera", "1.1", "JoX !")
    
    // Commands / Komande
    register_clcmd("say /3dcam", "3dcamera_view")
    register_clcmd("say_team /3dcam", "3dcamera_view")
    register_clcmd("say /normcam", "normcamera_view")
    register_clcmd("say_team /normcam", "normcamera_view")
    
}

public plugin_precache()
{
    precache_model("models/rpgrocket.mdl"); //engine modul vazda trazi ovo kod set_view 3rdpersona */
} 

public 3dcamera_view(id)
{
    if(CAMERA_3DPERSON[id])
    {
    client_print(id, print_chat,"Vec ti je 3D Camera namestena :)")
         }
         set_view(id, CAMERA_3RDPERSON)
         return PLUGIN_HANDLED
}

public normcamera_view(id)
{
    if(CAMERA_NONE[id])
    {
    client_print(id, print_chat,"Vec ti je Normal Camera namestena :)")
         }    
         set_view(id, CAMERA_NONE)
         return PLUGIN_HANDLED
}  