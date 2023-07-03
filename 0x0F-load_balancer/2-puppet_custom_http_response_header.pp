# Installs and configures Nginx Web Server
$host_name = $::hostname

exec { 'update':
  command => 'apt-get -y update',
  path    => '/usr/bin/',
}

package { 'nginx':
  ensure   => installed,
  provider => 'apt',
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!\n',
  require => Package['nginx'],
}

file_line { 'create a custom HTTP header response':
  path   => '/etc/nginx/sites-enabled/default',
  line   => '        add_header X-Served-By ${host_name};',
  after  => '^\s*server_name _;',
  notify => Service['nginx'],
}

file_line { 'create code 301 redirect':
  path   => '/etc/nginx/sites-enabled/default',
  line   => '        rewrite ^/redirect_me(.*)$ https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  after  => '^\s*location\s\/\s{',
  notify => Service['nginx'],
}