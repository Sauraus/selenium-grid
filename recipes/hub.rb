#
# Cookbook Name:: selenium-grid
# Recipe:: default
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'
include_recipe 'runit'

#
# Install Selenium server
#
directory node['selenium']['dir'] do
    owner 'root'
    group 'root'
    mode 00755
    recursive true
    action :create
end

remote_file "#{node['selenium']['dir']}/#{node['selenium']['jar']}" do
    owner 'root'
    group 'root'
    mode 0755
    source "#{node['selenium']['url']}/#{node['selenium']['jar']}"
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
