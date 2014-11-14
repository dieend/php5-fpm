#
# Cookbook Name:: php5-fpm
# Recipe:: configure_pools
#
# Copyright 2014, Stajkowski
#
# All rights reserved - Do Not Redistribute
#
#     _       _       _       _       _       _       _    
#   _( )__  _( )__  _( )__  _( )__  _( )__  _( )__  _( )__ 
# _|     _||     _||     _||     _||     _||     _||     _|
#(_ P _ ((_ H _ ((_ P _ ((_ - _ ((_ F _ ((_ P _ ((_ M _ (_ 
#  |_( )__||_( )__||_( )__||_( )__||_( )__||_( )__||_( )__|

#Loop through pools and generate configuration
node[:php_fpm][:pools].each do |pool,configuration|

	#Create Pool Configuration
	template "#{node[:php_fpm][:pools_path]}/#{pool}.conf" do
		source "pool.erb"
		variables({
			:pool_name => pool,
			:config => configuration
		})
		action :create
		notifies :restart, "service[#{node[:php_fpm][:package]}]", :delayed
	end

end