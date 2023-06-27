# Installs and configures Nginx Web Server
exec { 'update':
  command => 'apt-get -y update',
  path    => '/usr/bin/',
}

package { 'nginx':
  ensure   => installed,
  provider => 'apt',
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}

file_line { 'create code 301 redirect':
  path  => '/etc/nginx/sites-enabled/default',
  line  => '\ \ \ \ location \/redirect_me { return 301 https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4\$request_uri; }',
  after => '^\s+server_name\s_;',
}