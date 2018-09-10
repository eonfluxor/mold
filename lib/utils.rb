##############
## UTILS

def isDev?
	return ENVIRONMENT == :dev
end


##############
## FILE  HELPERS

def isReadable? file_path

	filename =  File.basename(file_path) 

	if filename.gsub(".","").length  == 0
		false
	elsif filename == ".git"
		false
	else
		true
	end

end

def usable_files_at file_path
	Dir.entries(file_path).select{|file| isReadable? file}
end

def isDirectory? file
	return File.directory?(file) if isReadable? file
	false
end


def isFile? file
	return File.file?(file) if isReadable? file
	false  
end

def exists? file
	(isDirectory? file) || (isFile? file)
end

def delete_dir! file_path
	FileUtils.remove_dir file_path,force=true if exists? file_path 
end

