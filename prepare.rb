#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

def system!(*args)
  system(*args) || abort("\n== Command #{args} failed ==")
end

# This script is a way to update your development environment automatically.
# This script is idempotent, so that you can run it at any time and get an expectable outcome.
# Add necessary setup steps to this file.

puts '🔍 Checking main dependencies exists...'
system('gem list -i "^foreman$"') || system!('gem install foreman')

puts "\n\e[0;35m~ * ~ Preparing the backend ~ * ~\e[0m\n\n"
FileUtils.cd('backend')

system!('bin/setup')

puts "\n\e[0;35m~ * ~ Preparing the frontend ~ * ~\e[0m\n\n"
FileUtils.cd('../frontend')
system!('npm install')

puts "\n🚀  Now \e[0;35mforeman start\e[0m the app 🌝"
