class profiles::os::linux::base_deb10 {
  include chrony
  
  user { ['sysad1', 'sysad2']:
    ensure => present,
  }
  
  package { 'openssl':
    ensure => installed,
  }

  package { 'openssh':
    ensure  => installed,
    require => Package['openssl'],
  }
  
  service { 'sshd':
    ensure => running,
    enable => true,
  }
}
