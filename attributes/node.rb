#
# Cookbook Name:: selenium-grid
# Attribute:: node
#
# Copyright 2014, Antek Baranski
#

include_attribute 'selenium-grid::default'
include_attribute 'selenium-grid::hub'

default['selenium-grid']['node'].tap do |node|
  node['port'] = 5555
end

default['chromedriver']['url'] = 'http://chromedriver.storage.googleapis.com'
default['chromedriver']['version'] = '2.8'
default['chromedriver']['zip'] = 'chromedriver_linux64.zip'
default['chromedriver']['exe'] = 'chromedriver'