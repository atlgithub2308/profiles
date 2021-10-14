class profiles::os::linux::base_deb10 {

  #2.10 Ensure ntp installed & running
  #######################################   

  include chrony

  #1.1 Ensure users exist sysad1 & sysad2
  #######################################

  #user { ['sysad1', 'sysad2']:
  #  ensure => present,
  #}

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

  #2.10 dns Ensure nameserver exist in resolv.conf
  ################################################

  file_line { 'nameserver entry':
    ensure => present,
    path   => '/etc/resolv.conf',
    line   => 'nameserver 169.254.169.254',
  }

  #2.16_1 cron Ensure cron job entry
  ################################################

  cron { 'pe_patch fact generation':
    command => '/opt/puppetlabs/pe_patch/pe_patch_fact_generation.sh',
    user    => 'root',
    minute  => 6,
  }

  #2.16_2 cron Ensure cron job entry
  ################################################

  service { 'cron':
    ensure => running,
    enable => true,
  }

  #3.5 Ensure server uptime < 30 days
  ####################################### 

  if $::system_uptime['days'] > 5 {
    exec { 'reboot':
      command => 'shutdown --reboot now',
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
