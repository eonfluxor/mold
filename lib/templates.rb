require './lib/utils.rb'

##############
## MANAGING TEMPLATES

def clone_templates!
	templates_path = templates_path!
	delete_dir! templates_path
	puts "cloning molds from: #{TEMPLATES_REPO}"
	Git.clone(TEMPLATES_REPO, template_direcory!)
end


def initialize_templates! force=false
	if  !templates_path_exist? || force
		clone_templates!
	else
		puts "using `molds` at: #{templates_path!}"
	end
end


def templates_path_exist?
	exists? templates_path!
end

def template_direcory!
	"molds"
end

def templates_path!
	File.join(Dir.pwd, template_direcory!)
end

def template_path! template
	
	template = template.downcase
	template_path = templates_list![template]

	raise "invalid template name `#{template}`" unless template_path

	template_path 
end

def templates_list!
	result = {}
	templates_path =   templates_path!
	files = usable_files_at(templates_path)
	files.each do |file|
		file_path = File.join(templates_path,file)
		file = file.downcase
		result[file] = file_path
	end
	result
end