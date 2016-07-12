#
# Cookbook Name:: pry_me_out
# Recipe:: setup
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

chef_gem "pry-remote"
require "pry-remote"

if platform_family?("windows")
  file "C:\\chef-pry.bat" do
    content <<-BINSTUB.gsub(/^ {6}/, "")
      @ECHO OFF
      SETLOCAL
      SET "GEM_HOME=#{Gem.paths.home}"
      SET "GEM_PATH=#{Gem.paths.path.join(";")}"
      SET "GEM_CACHE=#{Gem.paths.home}\\cache"
      SET RUBYOPT=
      SET GEMRC=
      "#{RbConfig::CONFIG["bindir"].gsub("/", "\\")}\\ruby.exe" "#{Gem.bindir.gsub("/", "\\")}\\pry-remote" %*
    BINSTUB
  end.run_action(:create)
else
  file "/usr/bin/chef-pry" do
    content <<-BINSTUB.gsub(/^ {6}/, "")
      #!/usr/bin/env sh
      GEM_HOME="#{Gem.paths.home}"; export GEM_HOME;
      GEM_PATH="#{Gem.paths.path.join(":")}"; export GEM_PATH;
      GEM_CACHE="#{Gem.paths.home}/cache"; export GEM_CACHE;
      unset RUBYOPT GEMRC;
      exec "#{RbConfig::CONFIG["bindir"]}/ruby" "#{Gem.bindir}/pry-remote" "$@";
    BINSTUB
    mode 0555
  end.run_action(:create)
end
