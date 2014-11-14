
#Global options, install php modules and users(optional)
default["php_fpm"]["install_php_modules"] = "true"
default["php_fpm"]["update_system"] = "false"
default["php_fpm"]["upgrade_system"] = "false"

default["php_fpm"]["create_users"] = true
default["php_fpm"]["users"] = 
'{ "users": 
	{ 
		"fpm_user": { "dir": "/base_path", "system": "true", "group": "fpm_group" }
	}
}'

#Select Platform Configuration
case node[:platform]
when "ubuntu", "debian"
	default["php_fpm"]["package"] = "php5-fpm"
	default["php_fpm"]["base_path"] = "/etc/php5/fpm"
	default["php_fpm"]["conf_file"] = node[:platform_version].include?("10.04") ? "php5-fpm.conf" : "php-fpm.conf"
	default["php_fpm"]["pools_path"] = node[:platform_version].include?("10.04") ? "#{node[:php_fpm][:base_path]}/fpm.d" : "#{node[:php_fpm][:base_path]}/pool.d"
	default["php_fpm"]["pools_include"] = "include=#{node[:php_fpm][:pools_path]}/*.conf"
	default["php_fpm"]["php_modules"] = [ 'php5-common', 
											'php5-mysql', 
											'php5-curl', 
											'php5-gd'
										] #Option to add more or remove, override if needed or disable

when "centos", "redhat", "fedora"
	default["php_fpm"]["package"] = "php-fpm"
	default["php_fpm"]["base_path"] = "/etc"
	default["php_fpm"]["conf_file"] = "php-fpm.conf"
	default["php_fpm"]["pools_path"] = "#{node[:php_fpm][:base_path]}/php-fpm.d"
	default["php_fpm"]["pools_include"] = "include=#{node[:php_fpm][:pools_path]}/*.conf"
	default["php_fpm"]["php_modules"] = [ 'php-common', 
											'php-mysql', 
											'php-curl', 
											'php-gd'
											] #Option to add more or remove, override if needed or disable
end

default[:php_fpm][:fpm][:pid] = "/var/run/php5-fpm.pid"
default[:php_fpm][:fpm][:error_log] = "/var/log/php5-fpm.log"
default[:php_fpm][:fpm][:syslog][:facility] = "daemon"
default[:php_fpm][:fpm][:syslog][:ident] = "php-fpm"
default[:php_fpm][:fpm][:log_level] = "notice"
default[:php_fpm][:fpm][:emergency_restart_threshold] = 0
default[:php_fpm][:fpm][:emergency_restart_interval] = 0
default[:php_fpm][:fpm][:process_control_timeout] = 0
default[:php_fpm][:fpm][:process_max] = 0
default[:php_fpm][:fpm][:process_priority] = nil
default[:php_fpm][:fpm][:daemonize] = "yes"
default[:php_fpm][:fpm][:rlimit_files] = nil
default[:php_fpm][:fpm][:events_mechanism] = nil
	

#Set pool configuration, default pool		
default["php_fpm"]["pools"] = 
'{ 	"www":
	{
		"user": "fpm_user",
		"group": "fpm_group",
		"listen": "127.0.0.1:9001",
		"pm": "dynamic",
		"pm.max_children": "10",
		"pm.start_servers": "4",
		"pm.min_spare_servers": "2",
		"pm.max_spare_servers": "6",
		"pm.process_idle_timeout": "10s",
		"pm.max_requests": "0",
		"pm.status_path": "/status",
		"ping.path": "/ping",
		"ping.response": "/pong",
		"access.format": "%R - %u %t \"%m %r\" %s",
		"request_slowlog_timeout": "0",
		"request_terminate_timeout": "0",
		"chdir": "/",
		"catch_workers_output": "no",
		"security.limit_extensions": ".php",
		"access.log": "NOT_SET",
		"slowlog": "NOT_SET",
		"rlimit_files": "NOT_SET",
		"rlimit_core": "NOT_SET",
		"chroot": "NOT_SET"
	}
}'

#### FOR UBUNTU 10.04 ONLY

#Set php-fpm.conf Ubuntu 10.04 configuration
default["php_fpm"]["ubuntu1004_config"] = 
'{ 	"config":
	{
		"pid": "/var/run/php5-fpm.pid",
		"error_log": "/var/log/php5-fpm.log",
		"log_level": "notice",
		"emergency_restart_threshold": "0",
		"emergency_restart_interval": "0",
		"process_control_timeout": "0",
		"daemonize": "yes",
		"rlimit_files": "NOT_SET",
		"rlimit_core": "NOT_SET",
		"events.mechanism": "NOT_SET"
	}
}'

#Set pool configuration, default pool		
default["php_fpm"]["ubuntu1004_pools"] = 
'{ 	"www":
	{
		"user": "fpm_user",
		"group": "fpm_group",
		"listen": "127.0.0.1:9001",
		"pm": "dynamic",
		"pm.max_children": "10",
		"pm.start_servers": "4",
		"pm.min_spare_servers": "2",
		"pm.max_spare_servers": "6",
		"pm.max_requests": "0",
		"pm.status_path": "/status",
		"ping.path": "/ping",
		"ping.response": "/pong",
		"request_slowlog_timeout": "0",
		"request_terminate_timeout": "0",
		"chdir": "/",
		"catch_workers_output": "no",
		"access.log": "NOT_SET",
		"slowlog": "NOT_SET",
		"rlimit_files": "NOT_SET",
		"rlimit_core": "NOT_SET",
		"chroot": "NOT_SET"
	}
}'

#### OS OVERRIDES
default["php_fpm"]["centos_pid"] = "/var/run/php-fpm/php-fpm.pid"