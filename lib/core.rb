require 'fileutils'


##############
## CREATING TEMPLATES


def create_template! templateName, newName

	raise "no template provided" unless  templateName and  newName
	raise "no new name provided" unless  templateName and  newName

	newPath = newName
	
	if newName.include?("/")
		newName = File.basename  newName
	else 
		newPath =  File.join(Dir.pwd,newName) unless  newName.include?("/")
	end

	puts "will use: `#{templateName}` for `#{newName}` at `#{newPath}`" 
	copy_template! templateName,newPath
	process_directory! newPath, newName

end

def copy_template! template, newName
	source = template_path!  template
	dest = newName

	if isDev?
		puts "removing exisitng"
		delete_dir! dest
	else
		raise "destination exists" if exists? dest
	end
	
	FileUtils.cp_r(source, dest)
end



##############
## CORE  ROUTINES

def process_directory! path, newName, level=""

	level = "PROCESS: #{level}-"
	puts "#{level} #{path}"

	files = usable_files_at path

	files.each do |file|
		

		sub_path = File.join(path,file)

		puts  "processing #{sub_path}"
		if isDirectory? sub_path
			puts  "directory  #{sub_path}"
			sub_path = rename_directory_or_file! sub_path, newName
			process_directory! sub_path, newName

		elsif isFile? sub_path	
			puts  "file  #{sub_path}"
			sub_path = rename_directory_or_file! sub_path, newName
			replace_string_in_file!  sub_path, newName
		end
	end
	
end

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

def content_of_file file

	file_content = File.read(file)
	if !file_content.valid_encoding?
		file_content = file_content.encode("UTF-16be", :invalid=>:replace, :replace=>"?").encode('UTF-8')
	end
	file_content

end

def replace_string_in_file! file, newname

	# newfilename = file.gsub(TEMPLATE_STRING,newname)
	puts ">>>>"
	puts "replacing `#{newname}` in `#{file}`"
	# File.rename("test.txt", "hope.txt")
	file_content = content_of_file file
	new_contents = file_content.gsub(TEMPLATE_STRING, newname)

	File.open(file, "w") {|file| file.puts new_contents }
end



