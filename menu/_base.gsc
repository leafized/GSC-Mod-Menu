/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : tQ1
*    Author : 
*    Game : Call of Duty: Black Ops
*    Description : 
*    Date : 8/22/2020 1:34:52 AM
*
*/
_start_menu()
{
    self.Menu = spawnStruct();
    self.Hud  = spawnStruct();
    self thread _monitor_keys();
    self _menu_structure();
    self.m_var["OPEN"] = false;
}

_monitor_keys()
{
    self endon("disconnect");
    self endon("stop_menu");
    while(1)//will be replaced with isValidStatus
    {
        if(!self.m_var["OPEN"])
        {
            if(self adsButtonPressed() && self meleeButtonPressed())
            {   //Will include isValidStatus check
                self.m_var["OPEN"] = true;
                self createHud();
                self _draw_menu();
                self _scroll_update();
                wait .2;
            }
        }
        if(self.m_var["OPEN"])
        {
            if(self usebuttonpressed())
            {
                a1 = self.Menu.Input[self.CurrentMenu][self.scroller];
                self thread [[self.Menu.Func[self.CurrentMenu][self.scroller]]](a1);
                wait .3;
            }
            if(self attackbuttonpressed())
            {
                self.scroller++;
                self _scroll_update();
                wait .16;
            }
            if(self adsbuttonpressed())
            {
                self.scroller--;
                self _scroll_update();
                wait .16;
            }
            if(self meleeButtonPressed())
            {
                if(self.Menu.parent[self.CurrentMenu]== "Exit")
                {
                    self destroy_text();
                    self.m_var["OPEN"] = false;
                    self.scroller = 0;
                }
                else
                {
                    self _draw_menu(self.Menu.parent[self.CurrentMenu]);
                }
                wait .2;
            }
        }
        wait .01;
    }
}
createHud()
{
    self.Hud.Title      = createText("default",2.5,"TOPLEFT","TOP",140,10,1,(1,1,1),1,(1,0,0), .8,"Menu Base");
    self.Hud.Background = createRectangle("TOPLEFT", "TOP",125,-100,450,1000,(0,0,0),.8,0,"white");
    self.Hud.Leftbar    = createRectangle("TOPLEFT", "TOP",121,-100,5,1000,(1,0,0),1,1,"white");
    self.Hud.Scrollbar  = createRectangle("TOPLEFT", "TOP",123, 45,450,20,(1,0,0),1,18,"white");
}

_draw_menu(menu)
{
    if(!isDefined(menu)) menu = "main";
    self.CurrentMenu = menu;
    self.scroller    = self GetMenuScroller(menu);
    if(isDefined(self.Hud.Text[0])){
        foreach(hud in self.Hud.Text) 
            hud destroy();
    }
    self thread _scroll_update();
    for(i=0;i<self.Menu.Text[self.CurrentMenu].size;i++)
    {
        self.Hud.Text[i] =  createText("default", 1.5, "TOPLEFT", "TOP", 140, 45 + (20 * i), i + 2, (1,1,1), 0, (0), 0, self.Menu.Text[self.CurrentMenu][i]);
        self.Hud.Text[i] Fadeovertime( .1 );
        self.Hud.Text[i].alpha = 1;
       self.Hud.Text[i].foreground = true;
       wait .03;
    }
}
GetMenuScroller( menu )
{
    if(!isDefined(self.Menu.Scroller[menu])) self.Menu.Scroller[menu] = 0;
    self iprintln(self.Menu.Scroller[menu]);
    return self.Menu.Scroller[menu];
}
SetMenuScroller( menu )
{
    self.Menu.Scroller[menu] = self.scroller;
}
destroy_text()
{
    self.Hud.Title destroy();
    self.Hud.Background destroy();
    self.Hud.Scrollbar destroy();
    self.Hud.LeftBar destroy();
    for(i=0;i<self.Hud.Text.size;i++)
    self.Hud.Text[i] destroy();
}
_scroll_update()
{
    if(self.scroller >= self.Menu.Text[self.CurrentMenu].size)
    {
        self.scroller = 0;
    }
    else if(self.scroller < 0)
    {
        self.scroller = self.Menu.Text[self.CurrentMenu].size - 1;
    }
    
    self SetMenuScroller( self.Menu.CurrentMenu );
    
    self.Hud.Scrollbar MoveOverTime(.1);
    self.Hud.Scrollbar.y = 45+ ( 20 * self.scroller );
}

CreateMenu(menu,title,parent)
{
    self.Menu.title[menu] = title;
    self.Menu.parent[menu] = parent;
}
addOption(menu,index,text,func,input)
{
    self.Menu.Text[menu][index] = text;
    self.Menu.Func[menu][index] = func;
    self.Menu.Input[menu][index] = input;
}

Test(argument)
{
    self iprintln("Testing + " + argument);
}