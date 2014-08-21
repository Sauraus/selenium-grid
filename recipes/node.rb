#
# Cookbook Name:: selenium-grid
# Recipe:: node
#
# Copyright 2014, Antek Baranski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'selenium-grid'
include_recipe 'java'

# Install the X11 package group
execute "x11installation" do
  command "yum groupinstall -y 'X Window System'"
  creates "/usr/bin/startx"
end

# Add internet browsers
execute "browserinstallation" do
  if node['platform_version'].to_i >= 6
    command "yum groupinstall -y 'Internet Browser'"
  else
    command "yum groupinstall -y 'Graphical Internet'"
  end
  creates "/usr/bin/firefox"
end

%w(unzip tigervnc-server xterm twm liberation-mono-fonts dbus).each do |pkg|
  package pkg do
    action :install
  end
end

execute 'Setup dbus-uuidgen' do
  command 'dbus-uuidgen > /var/lib/dbus/machine-id'
end

service "vncserver" do
  supports :status => true, :restart => true, :stop => true
  action :enable
end

execute "Stage selenium's password" do
  command "echo \"q1w2e3r4\" > #{Chef::Config[:file_cache_path]}/selenium-vnc"
end

execute "Stage selenium's password step 2" do
  command "echo \"q1w2e3r4\" >> #{Chef::Config[:file_cache_path]}/selenium-vnc"
end

execute "Populate selenium's initial VNC password" do
  command "su -l -c \"vncpasswd <#{Chef::Config[:file_cache_path]}/selenium-vnc >/dev/null 2>/dev/null\" selenium"
end

execute "Remove selenium's staged password" do
  command "rm #{Chef::Config[:file_cache_path]}/selenium-vnc"
end

# Create the autostart file
template "/etc/sysconfig/vncservers" do
  source "vncservers.erb"
  notifies :restart, resources(:service => 'vncserver')
end

template "#{node['selenium-grid']['dir']}/nodeconfig.json" do
  source "nodeconfig.json.erb"
  owner node['selenium-grid']['user']
  group node['selenium-grid']['group']
  mode 00644
  action :create
end

remote_file "#{node['selenium-grid']['dir']}/#{node['chromedriver']['zip']}" do
  source "#{node['chromedriver']['url']}/#{node['chromedriver']['version']}/#{node['chromedriver']['zip']}"
  owner node['selenium-grid']['user']
  group node['selenium-grid']['group']
  mode 00644
  action :create
end

execute "unzip" do
  cwd "#{node['selenium-grid']['dir']}"
  command "unzip -o #{node['chromedriver']['zip']}"
  action :run
end

include_recipe 'runit::default'

runit_service 'selenium-node' do
  default_logger true
end

service 'selenium-node' do
  supports :status => true, :restart => true, :reload => true
  reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/selenium-node"
end
