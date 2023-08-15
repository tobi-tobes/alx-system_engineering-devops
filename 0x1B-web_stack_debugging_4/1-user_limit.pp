# Fixes limit issue for user holberton

exec { 'raise limit':
  command => "sed -i 's|holberton\shard\snofile\s5|holberton\shard\snofile\s4096|g' /etc/security/limits.conf",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

exec { 'raise limit':
  command => "sed -i 's|holberton\ssoft\snofile\s4|holberton\ssoft\snofile\s4096|g' /etc/security/limits.conf",
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}

exec { 'restart system':
  command => 'sysctl -p',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}