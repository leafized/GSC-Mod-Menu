_menu_structure()
{
    self createMenu("main", "Menu Base", "Exit");
    self addOption("main", 0, "Option 1", ::Test, "0");
    self addOption("main", 1, "Option 2", ::Test, "1");
    self addOption("main", 2, "Option 3", ::Test, "2");
    self addOption("main", 3, "Option 4", ::Test, "3");
    self addOption("main", 4, "Option 5", ::Test, "4");
    self addOption("main", 5, "Option 6", ::Test, "5");
    self addOption("main", 6, "Option 7", ::Test, "6");
    self addOption("main", 7, "Option 8", ::Test, "7");
    self addOption("main", 8, "Option 9", ::Test, "8");
    self addOption("main", 9, "Option 10", ::Test, "9");
    self addOption("main", 10, "Players", ::_draw_menu, "players");self createMenu("players", "Player Menu", "main" );
    for(i=0;i<level.players.size;i++)
    {
        p = level.players[i];
        self addOption("players", i, p.name, ::_draw_menu, p.name+"main");self createMenu(p.name+"main",p.name,"players");
        
        main = p.name+"main";
        self addOption(main, 0, "Test", ::TestPlayer, p.name);
    }
}

TestPlayer(name)
{
    self iprintln(name);
}