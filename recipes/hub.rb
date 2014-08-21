#
# Cookbook Name:: selenium-grid
# Recipe:: hub
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

template "#{node['selenium-grid']['dir']}/hubconfig.json" do
  source "hubconfig.json.erb"
  owner node['selenium-grid']['user']
  group node['selenium-grid']['group']
  mode 00644
  action :create
end

include_recipe 'runit::default'

runit_service 'selenium-hub' do
  default_logger true
end

service 'selenium-hub' do
  supports       :status => true, :restart => true, :reload => true
  reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/selenium-hub"
end
