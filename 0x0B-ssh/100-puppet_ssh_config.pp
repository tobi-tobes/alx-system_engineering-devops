# sets up your SSH configuration file to connect to server without a password
$my_ssh_config = "/home/.ssh/config"

file { '/home/.ssh/config':
  path   => $my_ssh_config,
  ensure => present,
}

file_line { 'Host':
  path => $my_ssh_config,
  line => 'Host 54.160.124.170',
}

file_line { 'Declare identity file':
  path => $my_ssh_config,
  line => '     IdentityFile ~/.ssh/school',
}

file_line { 'Turn off password authentication':
  path => $my_ssh_config,
  line => '     BatchMode yes',
}