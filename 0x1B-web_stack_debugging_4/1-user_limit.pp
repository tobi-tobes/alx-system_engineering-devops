# Fixes limit issue for user holberton

exec { 'raise hard limit':
  command => "sed -i 's|holberton\shard\snofile\s5|holberton\shard\snofile\s4096|g' /etc/security/limits.conf",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

exec { 'raise soft limit':
  command => "sed -i 's|holberton\ssoft\snofile\s4|holberton\ssoft\snofile\s4096|g' /etc/security/limits.conf",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  require => Exec['raise hard limit'],
}

exec { 'restart system':
  command => 'sysctl -p',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  require => Exec['raise soft limit'],
}
