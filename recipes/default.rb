#
# Cookbook Name:: selenium-grid
# Recipe:: default
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

include_recipe 'java'
include_recipe 'runit::default'

user node['selenium-grid']['user'] do
  action :create
end

group node['selenium-grid']['group'] do
  members node['selenium-grid']['user']
  action :create
end

directory node['selenium-grid']['dir'] do
  owner node['selenium-grid']['user']
  group node['selenium-grid']['group']
  mode 00755
  recursive true
  action :create
end

remote_file "#{node['selenium-grid']['dir']}/#{node['selenium-grid']['jar']}" do
  source node['selenium-grid']['url']
  owner node['selenium-grid']['user']
  group node['selenium-grid']['group']
  mode 0755
  action :create
end

