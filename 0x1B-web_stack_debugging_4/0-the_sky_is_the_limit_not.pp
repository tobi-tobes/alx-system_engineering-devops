# Fixes limit issue for Nginx server

exec { 'raise limit':
  command => "sed -i 's/15/4096/g' /etc/default/nginx",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

exec { 'restart Nginx':
  command => 'service nginx restart',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  require => Exec['raise limit'],
}
