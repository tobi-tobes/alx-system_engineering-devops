# sets up your SSH configuration file to connect to server without a password
$my_ssh_config = "/etc/ssh/ssh_config"

file { '/etc/ssh/ssh_config':
  ensure => present,
}

file_line { 'Declare identity file':
  path => $my_ssh_config,
  line => '#   IdentityFile ~/.ssh/school',
}

file_line { 'Turn off password authentication':
  path  => $my_ssh_config,
  line  => '#   PasswordAuthentication no',
  match => '#\ \ \ PasswordAuthentication',
}