#
# Cookbook Name:: selenium-grid
# Attribute:: default
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

default['selenium-grid']['dir'] = '/opt/local/selenium_grid'
default['selenium-grid']['version']['major'] = '2.42'
default['selenium-grid']['version']['minor'] = '2'
default['selenium-grid']['jar'] =  "selenium-server-standalone-#{node['selenium-grid']['version']['major']}.#{node['selenium-grid']['version']['minor']}.jar"
default['selenium-grid']['url'] = "http://selenium-release.storage.googleapis.com/#{node['selenium-grid']['version']['major']}/#{node['selenium-grid']['jar']}"
default['selenium-grid']['user'] = 'selenium'
default['selenium-grid']['group'] = 'selenium'

default['java']['jdk_version'] = 7
