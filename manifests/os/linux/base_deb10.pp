class profiles::os::linux::base_deb10 {
  include ssh
  include chrony
  
  user { ['sysad1', 'sysad2']:
    ensure => present,
  }

}
