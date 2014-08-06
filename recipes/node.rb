#
# Cookbook Name:: selenium-grid
# Recipe:: node
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'
include_recipe 'php'

#
# Install packages
#
%w(firefox vnc-server unzip).each do |pkg|
  package pkg do
    action :install
  end
end

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
    owner 'root'
    group 'root'
    mode 0755
    source "#{node['selenium-grid']['url']}/#{node['selenium-grid']['jar']}"
    action :create_if_missing
end

#
# Chromedriver
#
remote_file "#{node['selenium-grid']['dir']}/#{node['chromedriver']['zip']}" do
    owner 'root'
    group 'root'
    mode 0755
    source "#{node['chromedriver']['url']}/#{node['chromedriver']['version']}/#{node['chromedriver']['zip']}"
    action :create
end

execute "unzip" do
  cwd "#{node['selenium-grid']['dir']}"
  command "unzip -o #{node['chromedriver']['zip']}"
  action :run
end

#
# config
#
template "#{node['selenium-grid']['dir']}/config.json" do
  source "config.json.erb"
  owner 'root'
end

include_recipe 'runit::default'

runit_service 'selenium-node'

service 'selenium-node' do
  supports       :status => true, :restart => true, :reload => true
  reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/selenium-node"
end
