{ config, pkgs, lib, ... }:

let
  username = "steve"; # ← change to your actual user (whoami)
  recordWebScript = pkgs.writeShellScriptBin "record-web" ''
    # Ensure loopback is running
    systemctl restart pw-loopback
    sleep 1
    ${pkgs.audacity}/bin/audacity
  '';
in
{
  # ── PipeWire (ensure enabled) ──
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.rtkit.enable = true;

  # ── Packages: Merged into ONE definition ──
  environment.systemPackages = with pkgs; [
    audacity
    pavucontrol
    helvum     # optional: PipeWire patchbay
    lame       # MP3 export for Audacity
    recordWebScript  # ← our custom launcher script
  ];

  # ── System-wide PipeWire loopback (starts at boot) ──
  systemd.services.pw-loopback = {
    description = "PipeWire Loopback for Web Audio Recording";
    wantedBy = [ "multi-user.target" ];
    after = [ "pipewire.service" ];
    requires = [ "pipewire.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.pipewire}/bin/pw-loopback -C --capture-props='node.name=\"Web Audio Recorder\"' -P latency=64ms";
      Restart = "always";
      RestartSec = 2;
      User = username;  # ← use the `let` variable
    };
  };

  # ── Global .desktop entry (available to all users) ──
  environment.etc."xdg/autostart/record-web.desktop".text = ''
    [Desktop Entry]
    Name=Record Web Audio
    GenericName=Audio Recorder
    Exec=${recordWebScript}/bin/record-web
    Icon=audacity
    Type=Application
    Categories=Audio;Recorder;
    X-GNOME-Autostart-enabled=false
  '';
}
