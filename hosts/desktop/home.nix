{ config, pkgs, ... }:

let
  username = "steve";   
in
{
  home-manager.users.${username} = {
    # ── Persistent pw-loopback (starts with graphical session) ──
    systemd.user.services.pw-loopback = {
      description = "PipeWire Loopback for Web Audio Recording";
      wantedBy = [ "graphical-session.target" ];
      after = [ "pipewire.service" ];
      requires = [ "pipewire.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.pipewire}/bin/pw-loopback -C --capture-props='node.name=\"Web Audio Recorder\"' -P latency=64ms";
        Restart = "always";
        RestartSec = 2;
      };
    };

    # ── One-click desktop launcher ──
    xdg.desktopEntries.record-web = {
      name = "Record Web Audio";
      genericName = "Audio Recorder";
      exec = "${pkgs.writeShellScriptBin "record-web" ''
        systemctl --user restart pw-loopback
        sleep 1
        ${pkgs.audacity}/bin/audacity
      ''}/bin/record-web";
      icon = "audacity";
      categories = [ "Audio" "Recorder" ];
    };

    home.stateVersion = "25.11";
  };
}
