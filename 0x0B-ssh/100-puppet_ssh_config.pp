# sets up your SSH configuration file to connect to server without a password
file { '~/.ssh/ssh_config':
  ensure => present,
}

file_line { 'Host':
  path => '~/.ssh/ssh_config',
  line => 'Host 54.160.124.170',
}

file_line { 'Declare identity file':
  path => '~/.ssh/ssh_config',
  line => '     IdentityFile ~/.ssh/school',
}

file_line { 'Turn off password authentication':
  path => '~/.ssh/ssh_config',
  line => '     BatchMode yes',
}