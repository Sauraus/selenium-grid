#
# Cookbook Name:: selenium-grid
# Attribute:: default
#
# Copyright 2014, Daniel Anggrianto
#
# All rights reserved - Do Not Redistribute
#

default['selenium-grid']['dir'] = '/opt/local/selenium_grid'
default['selenium-grid']['url'] = 'http://selenium.googlecode.com/files'
default['selenium-grid']['jar'] =  'selenium-server-standalone-2.39.0.jar'
default['selenium-grid']['user'] = 'selenium'
default['selenium-grid']['group'] = 'selenium'

default['java']['jdk_version'] = 7

