#
# Cookbook Name:: selenium-grid
# Attribute:: hub
#
# Copyright 2014, Antek Baranski
#

include_attribute 'selenium-grid::default'

default['selenium-grid']['hub']['host'] = 'localhost'
default['selenium-grid']['hub']['port'] = 4444
