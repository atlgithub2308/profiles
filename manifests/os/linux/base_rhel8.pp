class profiles::os::linux::base_rhel8 {
  include ntp
  include java::install
# include sssd 
# include pam
# include motd
# include snmp

}
