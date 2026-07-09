{ config, pkgs, ... }:

{
  # Enable Apache
  services.httpd.enable = true;
  services.httpd.adminAddr = "admin@localhost";

  # Enable php-fpm
  #services.httpd.enablePHP = true;
  services.phpfpm.enable = true;
  services.phpfpm.phpPackage = pkgs.php;

  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;

  services.phpfpm.pools.www = {
    user = "wwwrun";
    settings = {
      "pm" = "dynamic";
      "pm.max_children" = 5;
    };
  };
}
