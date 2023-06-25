# sets up your SSH configuration file to connect to server without a password
file { '/etc/ssh/ssh_config':
  ensure => present,
}

file_line { 'Declare identity file':
  path => '/etc/ssh/ssh_config',
  line => '#   IdentityFile ~/.ssh/school',
}

file_line { 'Turn off password authentication':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => '#   BatchMode yes',
  match  => '^#\ \ \ BatchMode',
}