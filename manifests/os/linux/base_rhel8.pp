class profiles::os::linux::base_rhel8 {
  include chrony
  include java::install
  include amazon-ssm-agent
# include sssd 
# include pam
# include motd
# include snmp

}
