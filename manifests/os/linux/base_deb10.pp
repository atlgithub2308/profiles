class profiles::os::linux::base_deb10 {
  include chrony
  
  user { ['sysad1', 'sysad2']:
    ensure => present,
  }
  
  package { 'openssl':
    ensure => installed,
  }

  package { 'openssh-server':
    ensure  => installed,
    require => Package['openssl'],
  }
  
  service { 'sshd':
    ensure => running,
    enable => true,
  }
  
  if $::system_uptime.days < 10 {
    exec { 'reboot':
      command => 'shutdown --reboot',
      path    => 'usr/sbin'
    }    
  }
}
