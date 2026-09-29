{ pkgs, ... }:
{
  users = {
    groups.git = {
      name = "git";
      members = [ "git" ];
    };
    users.git = {
      isSystemUser = true;
      group = "git";
      home = "/home/git";
      createHome = true;
      shell = "${pkgs.git}/bin/git-shell";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDO1MtviYyp8XTpV1i8PwiRkKu/4hmUQ9zWZM5UsLFG2 N100"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHXvGOeHOePW0AugBOO6P6bdwTdMvAbY8YtaM/4EoBjo north"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjqkOHYodMjourMLlNaCJLCE6f8rzkguRd16YTUU164 T490"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVYZ2IpPkbF3iXLP/iHcdad0e4AytHZjtLG/ZHTrrmf iPad"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFBS4VMQzOLdxYDSYuMb9FN7vbi2I7iUuyJ8Ei+piq3C pixel7a"
      ];
    };
  };

  services.openssh = {
    enable = true;
    extraConfig = ''
      Match user git
        AllowTcpForwarding no
        AllowAgentForwarding no
        PasswordAuthentication no
        PermitTTY no
        X11Forwarding no
    '';
  };
}
