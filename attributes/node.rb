#
# Cookbook Name:: selenium-grid
# Attribute:: node
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

include_attribute 'selenium-grid::default'
include_attribute 'selenium-grid::hub'

default['selenium-grid']['node']['port'] = 5555

default['chromedriver']['url'] = 'http://chromedriver.storage.googleapis.com'
default['chromedriver']['version'] = '2.8'
default['chromedriver']['zip'] = 'chromedriver_linux64.zip'
default['chromedriver']['exe'] = 'chromedriver'

default['firefox']['version'] = '28.0'
