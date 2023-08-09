# Fixes typo in /var/www/html/wp-setting.php file

exec { 'fix typo':
  command => "sed -i 's/.phpp/.php/g' /var/www/html/wp-setting.php",
  path    => [ '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' ],
}