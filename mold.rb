require 'fileutils'
 require 'git'

TEMPLATES_REPO="git@github.com:hassanvfx/molds.git"
TEMPLATE_STRING="BOILER_PLATE_TEMPLATE"
ENV = :dev

#File.join(Dir.pwd,'some-dir','some-file-name')

def rename_directory_or_file! file_path, newname

	path = File.dirname(file_path)
	filename =  File.basename(file_path) 

	filename = filename.gsub(TEMPLATE_STRING,newname)
	new_path = File.join(path,filename)

	puts "########"
	puts "renaming to `#{new_path}`"
	
	FileUtils.mv file_path, new_path if file_path !=  new_path
	new_path
	
end

def replace_string_in_file! file, newname

	# newfilename = file.gsub(TEMPLATE_STRING,newname)
	puts ">>>>"
	puts "replacing `#{newname}` in `#{file}`"
	# File.rename("test.txt", "hope.txt")

	text = File.read(file)
	new_contents = text.gsub(TEMPLATE_STRING, newname)

 #  # To merely print the contents of the file, use:
 #  puts new_contents

 #  # To write changes to the file, use:
 File.open(file, "w") {|file| file.puts new_contents }
end

def isDirectory? file
	componets = file.split("/")
	if componets.last.gsub(".","").length  == 0
		false
	else
		File.directory?(file)
	end  
end


def isFile? file
	componets = file.split("/")
	if componets.last.gsub(".","").length == 0
		false
	else
		File.file?(file)
	end  
end

def exists? file
	(isDirectory? file) || (isFile? file)
end

def delete_dir! file_path
	FileUtils.remove_dir file_path,force=true if exists? file_path 
end


def process_directory! path, newName, level=""

	level = "PROCESS: #{level}-"
	puts "#{level} #{path}"

	Dir.entries(path).each do |file|
		
		sub_path = File.join(path,file)

		if isDirectory? sub_path
			
			sub_path = rename_directory_or_file! sub_path, newName
			process_directory! sub_path, newName

		elsif isFile? sub_path	
			sub_path = rename_directory_or_file! sub_path, newName
			replace_string_in_file!  sub_path, newName
		end
	end
	
end

def template_direcory!
	"molds"
end

def templates_path!
	File.join(Dir.pwd, template_direcory!)
end

def template_path! template
	
	template_sym = template.downcase.to_sym
	case template_sym
	when :framework
		"#{templates_path!}/MyFrameworkTemplateName"
	else
		raise "invalid template name #{template_sym}"
	end

end

def copy_template! template, newName
	source = template_path!  template
	dest = newName

	if ENV == :dev
		delete_dir! dest
	else
		raise "destination exists" if exists? dest
	end
	
	FileUtils.cp_r(source, dest)
end

def create_template! templateName, newName

	raise "no template provided" unless  templateName and  newName
	raise "no new name provided" unless  templateName and  newName

	newPath = newName
	newPath =  File.join(Dir.pwd,newName) unless  newName.include?("/")

	puts "will use: #{templateName} for #{newName}"
	copy_template! templateName,newPath
	process_directory! newPath, newName

end

def clone_templates!
	templates_path = templates_path!
	delete_dir! templates_path
	Git.clone(TEMPLATES_REPO, template_direcory!)
end

templateName = ARGV[0]
newName = ARGV[1]

clone_templates!




