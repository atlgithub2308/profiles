class profiles::os::linux::base_rhel8 {
  include chrony
  include java::install
  include archive
  include amazonssmagent::amazon_ssm_agent
# include sssd 
# include pam
# include motd
# include snmp

}
