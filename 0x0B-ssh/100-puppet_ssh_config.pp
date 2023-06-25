# sets up your SSH configuration file to connect to server without a password
file { '~/.ssh/config':
  ensure => present,
}

file_line { 'Host':
  path => '~/.ssh/config',
  line => 'Host *',
}

file_line { 'Declare identity file':
  path => '~/.ssh/config',
  line => '    IdentityFile ~/.ssh/school',
}

file_line { 'Turn off password authentication':
  path   => '~/.ssh/config',
  line   => '    BatchMode yes',
}