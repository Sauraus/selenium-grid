#
# Cookbook Name:: selenium-grid
# Recipe:: default
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

#
# Install Selenium server
#
directory node['selenium-grid']['dir'] do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

remote_file "#{node['selenium-grid']['dir']}/#{node['selenium-grid']['jar']}" do
  source "#{node['selenium-grid']['url']}/#{node['selenium-grid']['jar']}"
  owner 'root'
  group 'root'
  mode 0755
  action :create_if_missing
end

#
# Start required services
#
include_recipe 'runit::default'

runit_service 'selenium-hub'

service 'selenium-hub' do
  supports       :status => true, :restart => true, :reload => true
  reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/selenium-hub"
end
