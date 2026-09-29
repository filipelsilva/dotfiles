let
  north = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHXvGOeHOePW0AugBOO6P6bdwTdMvAbY8YtaM/4EoBjo north";
  T490 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBjqkOHYodMjourMLlNaCJLCE6f8rzkguRd16YTUU164 T490";
  N100 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDO1MtviYyp8XTpV1i8PwiRkKu/4hmUQ9zWZM5UsLFG2 N100";

  hosts = [
    north
    T490
    N100
  ];
in
{
  "wg-privatekey-north.age".publicKeys = [ north ];
  "wg-privatekey-N100.age".publicKeys = [ N100 ];
  "wg-privatekey-T490.age".publicKeys = [ T490 ];

  "cloudflare-dns-api-token.age".publicKeys = hosts;
  "ttyd-password.age".publicKeys = hosts;
}
