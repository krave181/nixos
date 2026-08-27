{ config, pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = let
      # Re-declare variables for easy reuse inside the configuration
      mod = "Mod4";
      leftscreen = "DP-3";
      rightscreen = "DP-2";
    
     static = "1-Static";
     terms = "2-Terminals";
     chats = "3-Chats";
     games = "4-Games";
     files = "5-Files";
     mail = "6-Mail/RSS";
     news = "7-News";
     ws8 = "8";
     ws9 = "9";
     ws10 = "10";
     ws11 = "11-Monitoring";

     bgcolor    = "#000000";
     in-bgcolor = "#363636";
     text       = "#ffffff";
     u-bgcolor  = "#ff0000";
     indicator  = "#a8a3c1";
     in-text    = "#969696";
  
    in {
      modifier = mod;

      fonts = {
        names = [ "IBM Plex Mono" ];
        size = 12.0;
      };

      # Autostart applications
     startup = [
       { command = "dex --autostart --environment i3"; notification = false; }
       { command = "xss-lock --transfer-sleep-lock --i3lock --nofork"; notification = false; }
       { command = "nm-applet"; notification = false; }
       { command = "xrandr --output ${leftscreen} --mode 2560x1440 --rate 59.95 --rotate left --pos 0x0 --output ${rightscreen} --mode 2560x1440 --rate 120.00 --primary --pos 1440x0"; notification = false; always = true; }
      ];

     # Window colors
      colors = {
       focused = { border = bgcolor; background = bgcolor; text = text; indicator = indicator; childBorder = bgcolor; };
       unfocused = { border = in-bgcolor; background = in-bgcolor; text = in-text; indicator = in-bgcolor; childBorder = in-bgcolor; };
       focusedInactive = { border = in-bgcolor; background = in-bgcolor; text = in-text; indicator = in-bgcolor; childBorder = in-bgcolor; };
       urgent = { border = u-bgcolor; background = u-bgcolor; text = text; indicator = u-bgcolor; childBorder = u-bgcolor; };
     };

      floating.modifier = mod;
    
      # Custom Keybindings
     keybindings = let 
       refresh_i3status = "killall -SIGUSR1 i3status";
     in {
        # Audio control
       "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && ${refresh_i3status}";
       "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && ${refresh_i3status}";
       "XF86AudioMute"        = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && ${refresh_i3status}";
       "XF86AudioMicMute"     = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && ${refresh_i3status}";

        # Core app shortcuts
       "${mod}+Return" = "exec i3-sensible-terminal";
       "${mod}+Shift+q" = "kill";
       "${mod}+d" = "exec --no-startup-id \"rofi -modi drun,run -show drun\"";

        # Navigation focus (Vim keys)
       "${mod}+j" = "focus left";
       "${mod}+k" = "focus down";
       "${mod}+l" = "focus up";
       "${mod}+semicolon" = "focus right";

        # Navigation focus (Arrow keys)
       "${mod}+Left" = "focus left";
       "${mod}+Down" = "focus down";
       "${mod}+Up" = "focus up";
       "${mod}+Right" = "focus right";

        # Window movement (Vim keys)
       "${mod}+Shift+j" = "move left";
       "${mod}+Shift+k" = "move down";
       "${mod}+Shift+l" = "move up";
       "${mod}+Shift+semicolon" = "move right";

      # Window movement (Arrow keys)  
       "${mod}+Shift+Left" = "move left";
       "${mod}+Shift+Down" = "move down";
       "${mod}+Shift+Up" = "move up";
       "${mod}+Shift+Right" = "move right";

        # Layout modifiers
       "${mod}+h" = "split h";
       "${mod}+v" = "split v";
       "${mod}+f" = "fullscreen toggle";
       "${mod}+s" = "layout stacking";
       "${mod}+w" = "layout tabbed";
       "${mod}+e" = "layout toggle split";
       "${mod}+Shift+space" = "floating toggle";
       "${mod}+space" = "focus mode_toggle";
       "${mod}+a" = "focus parent";

       # Workspace switches
       "${mod}+1" = "workspace number ${static}";
       "${mod}+2" = "workspace number ${terms}";
       "${mod}+3" = "workspace number ${chats}";
       "${mod}+4" = "workspace number ${games}";
       "${mod}+5" = "workspace number ${files}";
       "${mod}+6" = "workspace number ${mail}";
       "${mod}+7" = "workspace number ${news}";
       "${mod}+8" = "workspace number ${ws8}";
       "${mod}+9" = "workspace number ${ws9}";
       "${mod}+0" = "workspace number ${ws10}";

        # Container moves to workspace
       "${mod}+Shift+1" = "move container to workspace number ${static}";
       "${mod}+Shift+2" = "move container to workspace number ${terms}";
       "${mod}+Shift+3" = "move container to workspace number ${chats}";
       "${mod}+Shift+4" = "move container to workspace number ${games}";
       "${mod}+Shift+5" = "move container to workspace number ${files}";
       "${mod}+Shift+6" = "move container to workspace number ${mail}";
       "${mod}+Shift+7" = "move container to workspace number ${news}";
       "${mod}+Shift+8" = "move container to workspace number ${ws8}";
       "${mod}+Shift+9" = "move container to workspace number ${ws9}";
       "${mod}+Shift+0" = "move container to workspace number ${ws10}";

        # System hotkeys
       "${mod}+Shift+c" = "reload";
       "${mod}+Shift+r" = "restart";
     };

     # Window-to-workspace Assignments
     assigns = {
       "${static}" = [
         { class = "Opera"; instance = "Opera"; }
       ];
       "${terms}" = [
         { class = "Xfce4-terminal"; instance = "xfce4-terminal"; }
       ];
       "${chats}" = [
         { class = "discord"; instance = "discord"; }
         { class = "Hexchat"; instance = "hexchat"; }
       ];
       "${games}" = [
         { class = "steam"; instance = "steamwebhelper"; }
         { class = "Lutris"; instance = "lutris"; }
       ];
       "${mail}" = [
         { class = "thunderbird"; instance = "Mail"; }
         { class = "brave-browse"; instance = "Brave-browser"; }
       ];
       "${news}" = [
         { class = "Falkon"; instance = "Falkon Browser"; }
       ];
       "${files}" = [
         { class = ".gpodder-wrapped"; instance = ".gpodder-wrapped"; }
         { class = "Thunar"; instance = "Thunar"; }
       ];
       "${ws9}" = [
         { class = "elite launcher"; instance = "elite launcher"; }
       ];
       "${ws10}" = [
         { class = "steam_app_359320"; instance = "steam_app_359320"; }
         { class = "steam_app_0"; instance = "steam_app_0"; }
       ];
     };

      # Pinning workspaces to outputs
     workspaceOutputAssign = [
       { workspace = static; output = leftscreen; }
       { workspace = static; output = rightscreen; }
       { workspace = chats; output = rightscreen; }
       { workspace = games; output = rightscreen; }
       { workspace = files; output = rightscreen; }
       { workspace = mail; output = rightscreen; }
       { workspace = news; output = rightscreen; }
       { workspace = ws8; output = rightscreen; }
       { workspace = ws9; output = rightscreen; }
       { workspace = ws10; output = leftscreen; }
       { workspace = ws11; output = rightscreen; }
     ];
   };
  
    # Re-enable tiling drag outside configuration sub-attribute
   extraConfig = ''
      tiling_drag modifier titlebar
    '';
  };
}
