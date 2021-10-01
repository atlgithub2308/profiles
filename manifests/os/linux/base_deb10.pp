class profiles::os::linux::base_deb10 {
  
  #2.10 Ensure ntp installed & running
  #######################################   
  
  include chrony
  
  #1.1 Ensure users exist sysad1 & sysad2
  #######################################
  
  user { ['sysad1', 'sysad2']:
    ensure => present,
  }
  
  #1.5 Ensure ssh installed & running
  #######################################  
  
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
  
  #2.9 Ensure timezone is Asia/Singapore
  #######################################   
  
  if $::timezone != "+08" {
    exec { 'set timezone':
      command => 'timedatectl set-timezone Asia/Singapore',
      path    => '/usr/bin',
    }    
  }
  
  #3.5 Ensure server uptime < 30 days
  ####################################### 
  
  if $::system_uptime['days'] > 30 {
    exec { 'reboot':
      command => 'shutdown --reboot',
      path    => '/usr/sbin',
    }    
  }
  
  #4.1 Ensure cron.allow entry
  ####################################### 
  
  file_line { 'cron allow entry':
    ensure => present,
    path   => '/etc/cron.d/cron.allow',
    line   => 'sysad1',
  }    
  
}
