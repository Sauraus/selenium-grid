#
# Cookbook Name:: selenium-grid
# Recipe:: node
#
# Copyright 2014, Daniel Anggrianto
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

include_recipe 'java'

%w(firefox vnc-server unzip).each do |pkg|
  package pkg do
    action :install
  end
end

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
