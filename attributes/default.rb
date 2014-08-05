#
# Cookbook Name:: selenium-grid
# Attribute:: default
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

override['supervisor']['inet_port'] = '9001'
override['supervisor']['version'] = '3.0a12'

default['selenium']['dir'] = '/opt/local/selenium_grid'
default['selenium']['url'] = 'http://selenium.googlecode.com/files'
default['selenium']['jar'] =  'selenium-server-standalone-2.39.0.jar'
default['selenium']['config'] = 'config'

default['chromedriver']['url'] = 'http://chromedriver.storage.googleapis.com'
default['chromedriver']['version'] = '2.8'
default['chromedriver']['zip'] = 'chromedriver_linux64.zip'
default['chromedriver']['exe'] = 'chromedriver'

default['grid']['hub']['url'] = 'localhost'
default['grid']['node']['url'] = 'localhost'

default['java'].tap do |java|
  java['jdk_version'] = 7
end
