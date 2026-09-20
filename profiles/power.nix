{ config, ... }:
{
  services = {
    tlp.enable = true;
    thermald.enable = true;
    auto-cpufreq.enable = !config.services.tlp.enable;
  };
}
