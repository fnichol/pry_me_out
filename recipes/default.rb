#
# Cookbook Name:: pry_me_out
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

ruby_block "uh-oh" do
  block do
    ip = node[:ipaddress]
    binding.remote_pry
  end
end

log "Heyo, I'm logging things now"
