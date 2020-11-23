/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : tQ1
*    Author : 
*    Game : Call of Duty: Black Ops
*    Description : Starts Multiplayer code execution!
*    Date : 8/21/2020 6:59:10 AM
*
*/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
        player thread _start_menu();//Menu Begins here
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
        if(isDefined(self.playerSpawned))
            continue;
        self.playerSpawned = true;

        self freezeControls(false);
    }
}

