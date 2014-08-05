#
# Cookbook Name:: selenium-grid
# Recipe:: node
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'
include_recipe 'git'
include_recipe 'php'

node.override['selenium-grid']['grid']['hub']['url'] = '33.33.33.10'

#
# Install packages
#
%w(firefox vnc-server).each do |pkg|
  package pkg do
    action :install
  end
end

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
# Chromedriver
#
remote_file "#{node['selenium']['dir']}/#{node['chromedriver']['zip']}" do
    owner 'root'
    group 'root'
    mode 0755
    source "#{node['chromedriver']['url']}/#{node['chromedriver']['version']}/#{node['chromedriver']['zip']}"
    action :create
end

execute "unzip" do
  cwd "#{node['selenium']['dir']}"
  command "unzip -o #{node['chromedriver']['zip']}"
  action :run
end

#
# config
#
template "#{node['selenium']['dir']}/#{node['selenium']['config']}.json" do
  source "config.json.erb"
  owner 'root'
  variables({
    :hub_url => node['grid']['hub']['url'],
    :node_url => node['grid']['node']['url']
    })
end

include_recipe 'runit::default'

runit_service 'selenium-node'

service 'selenium-node' do
  supports       :status => true, :restart => true, :reload => true
  reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/selenium-node"
end
