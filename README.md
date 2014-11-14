PHP5-FPM Cookbook
=====
<br />
Adding pools can be done by way of LWRP provider or by modifying JSON directly in the attributes file or overriding the attributes through other methods, environments, roles, etc.  Usage of the receipes beyond ::install is optional and not needed if using the LWRP provider.

When using the JSON option with recipes, if you do not wish to use a configuration value in the JSON attributes, you can simply set it to NOT_SET and it will not be included in the configuration file.  Additionally, you can add more configuration values if they are missing, future proofing the template generation with JSON.

>#### Supported Platforms
>Debian(6.x+), Ubuntu(10.04+)
>CentOS(6.x+), RedHat, Fedora(20+)
>#### Tested Against
>Debian 6.x and above
>Ubuntu 10.04 and above
>CenOS 6.x and above
>Fedora 20
>#### Planned Improvements
>0.3.3 - Auto Calculate Workers/Clients/ETC - Division of Resources

No additional cookboks are required.
<br />
<br />
<br />
#Attributes
_____
### php5-fpm::default
<br />
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["install_php_modules"]</tt></td>
    <td>Boolean</td>
    <td>Install Additional PHP Modules</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["update_system"]</tt></td>
    <td>Boolean</td>
    <td>Update repository information</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["upgrade_system"]</tt></td>
    <td>Boolean</td>
    <td>Perform upgrades to OS</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["create_users"]</tt></td>
    <td>Boolean</td>
    <td>Configure Users</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["users"]</tt></td>
    <td>JSON</td>
    <td>Users/Directories to Add</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["config"]</tt></td>
    <td>JSON</td>
    <td>PHP-FPM.conf Configuration Values</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["pools"]</tt></td>
    <td>JSON</td>
    <td>pool.conf Configuration Values</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["ubuntu1004_config"]</tt></td>
    <td>JSON</td>
    <td>PHP-FPM.conf Configuration Values Ubuntu 10.04 Only</td>
    <td><tt>Attributes File</tt></td>
  </tr>
  <tr>
    <td><tt>["php_fpm"]["ubuntu1004_pools"]</tt></td>
    <td>JSON</td>
    <td>pool.conf Configuration Values Ubuntu 10.04 Only</td>
    <td><tt>Attributes File</tt></td>
  </tr>
</table>
<br />
<br />
<br />
# Resource/Provider
______
## php5_fpm_pool
<br />
### Actions

- :create
- :modify
- :delete
<br />
<br />
### Attribute Parameters

```
#Overwrite for file replacement
attribute :overwrite, :kind_of => [ TrueClass, FalseClass ], :default => false

#Base Pool Configuration
attribute :pool_name, :name_attribute => true, :kind_of => String, :required => true
attribute :pool_user, :kind_of => String, :required => false, :default => 'www-data'
attribute :pool_group, :kind_of => String, :required => false, :default => 'www-data'
attribute :listen_address, :kind_of => String, :required => false, :default => '127.0.0.1', :regex => Resolv::IPv4::Regex
attribute :listen_port, :kind_of => Integer, :required => false, :default => 9000
attribute :listen_allowed_clients, :kind_of => String, :required=> false, :default => nil
attribute :listen_owner, :kind_of => String, :required=> false, :default => nil
attribute :listen_group, :kind_of => String, :required=> false, :default => nil
attribute :listen_mode, :kind_of => String, :required=> false, :default => nil

#PM Configuration
attribute :pm, :kind_of => String, :required => false, :default => 'dynamic'
attribute :pm_max_children, :kind_of => Integer, :required => false, :default => 10
attribute :pm_start_servers, :kind_of => Integer, :required => false, :default => 4
attribute :pm_min_spare_servers, :kind_of => Integer, :required => false, :default => 2
attribute :pm_max_spare_servers, :kind_of => Integer, :required => false, :default => 6
attribute :pm_process_idle_timeout, :kind_of => String, :required => false, :default => '10s'
attribute :pm_max_requests, :kind_of => Integer, :required => false, :default => 0
attribute :pm_status_path, :kind_of => String, :required => false, :default => '/status'

#Ping Status
attribute :ping_path, :kind_of => String, :required => false, :default => '/ping'
attribute :ping_response, :kind_of => String, :required => false, :default => '/pong'

#Logging
attribute :access_format, :kind_of => String, :required => false, :default => '%R - %u %t \"%m %r\" %s'
attribute :request_slowlog_timeout, :kind_of => Integer, :required => false, :default => 0
attribute :request_terminate_timeout, :kind_of => Integer, :required => false, :default => 0
attribute :access_log, :kind_of => String, :required => false, :default => nil
attribute :slow_log, :kind_of => String, :required => false, :default => nil

#Misc
attribute :catch_workers_output, :kind_of => String, :required => false, :equal_to => ['yes', 'no'], :default => 'no'
attribute :security_limit_extensions, :kind_of => String, :required => false, :default => '.php'
attribute :rlimit_files, :kind_of => Integer, :required => false, :default => nil
attribute :rlimit_core, :kind_of => Integer, :required => false, :default => nil

#PHP INI
attribute :php_ini_flags, :kind_of => Hash, :required => false, :default => nil
attribute :php_ini_values, :kind_of => Hash, :required => false, :default => nil
attribute :php_ini_admin_flags, :kind_of => Hash, :required => false, :default => nil
attribute :php_ini_admin_values, :kind_of => Hash, :required => false, :default => nil

#ENV Variables
attribute :env_variables, :kind_of => Hash, :required => false, :default => nil
```
<br />
<br />
### Example

```
php5_fpm_pool "example" do
	pool_user "www-data"
	pool_group "www-data"
	listen_address "127.0.0.1"
	listen_port 8000
	listen_allowed_clients "127.0.0.1"
	listen_owner "nobody"
	listen_group "nobody"
	listen_mode "0666"
    php_ini_flags (
                    { "display_errors" => "off", "log_errors" => "on"}
                  )
    php_ini_values (
                      { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.domain.com", "memory_limit" => "32M"}
                  )
	overwrite true
	action :create
	notifies :restart, "service[#{node[:php_fpm][:package]}]", :delayed
end
```

```
php5_fpm_pool "example" do
	pool_user "fpm_user"
	pool_group "fpm_group"
	listen_allowed_clients "127.0.0.1"
	pm_max_children 30
	pm_start_servers 10
	pm_min_spare_servers 5
	pm_max_spare_servers 10
	pm_process_idle_timeout "30s"
	pm_max_requests 1000
	pm_status_path "/mystatus"
	ping_path "/myping"
	ping_response "/myresponse"
    php_ini_flags (
                      { "display_errors" => "on", "log_errors" => "off"}
                  )
    php_ini_values (
                       { "sendmail_path" => "/usr/sbin/sendmail -t -i -f www@my.yourdomain.com", "memory_limit" => "16M"}
                   )
	action :modify
	notifies :restart, "service[#{node[:php_fpm][:package]}]", :delayed
end
```
<br />
<br />
<br />
# Recipe Usage

### php-fpm::install

Install PHP5-FPM. Include `php5-fpm::install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::install]"
  ]
}
```

### php5-fpm::create_user (optional)

This will create users and directories for use with pools. Include `php5-fpm::create_user` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::create_user]"
  ]
}
```

### php5-fpm::configure_pools (optional)

This will create pools based on JSON attributes.  Not needed if you are using the LWRP provider. Include `php5-fpm::configure_pools` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::configure_pools]"
  ]
}
```

### php5-fpm::configure_fpm (optional)

This will replace the php-fpm.conf file based on JSON attributes.  Not needed if you are using the LWRP provider. Include `php5-fpm::configure_fpm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::configure_fpm]"
  ]
}
```

### php5-fpm::example_pool (optional)

Example on how to use the LWRP provider.  This is not a required recipe but include `php5-fpm::example_pool` in your node's `run_list` if you wish to try the example:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[php5-fpm::example_pool]"
  ]
}
```
<br />
<br />
<br />
# License and Authors
___
Authors: Brian Stajkowski

Copyright 2014 Brian Stajkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.