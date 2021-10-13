class profiles::os::linux::base_rhel8 {
  include chrony
  include java
  include archive
  include ssh
  
# include amazonssmagent
# include sssd 
# include pam
# include motd
# include snmp

}
