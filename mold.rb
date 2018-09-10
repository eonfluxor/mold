require 'fileutils'
require 'git'
require './lib/utils.rb'
require './lib/core.rb'
require './lib/templates.rb'

TEMPLATES_REPO="git@github.com:eonfluxor/molds.git"
TEMPLATE_STRING="BOILER_PLATE_TEMPLATE"
ENVIRONMENT = :dev

##############
## MAIN

command = ARGV[0]
templateName = ARGV[0]
newName = ARGV[1]

case command
when "update"
	initialize_templates! true
when "list"
	puts templates_list!
when "help"
	puts "Usage instructions"
	puts "MOLD: `ruby mold.rb TEMPLATE_NAME newname`"
	puts "UPDATE: `ruby mold.rb update`"
	puts "LIST: `ruby mold.rb list`"
	puts "HELP: `ruby mold.rb help`"
else
	create_template!  templateName,newName
end





