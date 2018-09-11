#!/usr/bin/env ruby

require 'fileutils'
require './lib/constants.rb'
require './lib/utils.rb'
require './lib/core.rb'
require './lib/templates.rb'

##############
## MAIN

command = ARGV[0]
templateName = ARGV[0]
newName = ARGV[1]

case command
when "update"
	initialize_templates! true
when "list"
	initialize_templates! 
	puts templates_list!
when "help","",nil
	puts "Usage instructions"
	puts "-"*10
	puts "MOLD: `ruby mold.rb TEMPLATE_NAME newname`"
	puts "UPDATE: `ruby mold.rb update`"
	puts "LIST: `ruby mold.rb list`"
	puts "HELP: `ruby mold.rb help`"
else
	create_template!  templateName,newName
end





