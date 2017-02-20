#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Webserver Installation
include_recipe 'webserver::install'

# WebServer Hardening
include_recipe 'webserver::hardening'
