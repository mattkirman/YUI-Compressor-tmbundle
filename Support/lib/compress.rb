#!/usr/bin/env ruby

require ENV['TM_SUPPORT_PATH'] + '/lib/ui'
require ENV['TM_SUPPORT_PATH'] + '/lib/progress'


# Our wrapper for the TextMate critical alert dialog. As this is only called when
# we have suffered from a critical/fatal error we must then exit the program.
def criticalError(message)
	TextMate::UI.alert(:critical, "YUI Compressor Bundle", message)
	exit
end


# Check to make sure that we have actually selected some files
if ENV["TM_SELECTED_FILES"] == nil then
	criticalError("Please select some files to compress.")
end

# Check that the compiler location is set
if ENV["TM_YUI_COMPRESSOR_LOCATION"] == nil then
	criticalError("Unable to find a path for the YUI Compressor in 'Preferences...'.

Please refer to 'Help' in the bundle for more information.")
else
	compressor = ENV["TM_YUI_COMPRESSOR_LOCATION"]
	
	# Check to make sure that we've set an absolute path to the compiler
	if compressor == '/absolute/path/to/yui-compressor.jar' || compressor[0,1] == '~' then
		criticalError("Please set the absolute path to your copy of the YUI Compressor in 'Preferences...'.")
	end
end


# Enough with the error checking, let's gone and do some compressing
selected_files_string = ENV["TM_SELECTED_FILES"]
# Strip the start and end quotes, then split the string into files
selected_files = selected_files_string[1..-2].split("' '")
if selected_files.length == 0 then
	criticalError("Please select some files to compile.")
end


# Create a standard progress dialog
TextMate.call_with_progress(:title => 'YUI Compressor', :summary => 'Starting up...') do |dialog|
	i = 0
	result = false
	
	# For every selected file we need to compress it
	selected_files.each do |file|
		i += 1
		
		short_file_name = file
		if file.length > 47 then	
			short_file_name = " #{file[0,20]}...#{file[-20,20]}"
		end
		
		# Move the progress bar along a bit
		dialog.parameters = {	'summary' => "Compressing file #{i} of #{selected_files.length}...",
								'details' => short_file_name
							}
							
		# Are we looking at a JavaScript or CSS file?
		if file =~ /.js$/ || file =~ /.css$/ then
			# We now need to ascertain where on earth we're going to save the compressed file
			output_file = file.gsub(/.(js|css)$/, '.min\0')
			
			# Create the call to the Compressor
			cmd = "java -jar \"#{compressor}\" --nomunge -o \"#{output_file}\" \"#{file}\""
			result = system(cmd)
			
			# If the compressor ran successfully then we ought to tell the user...
			if result == true then
				# Let the user now that we've compressed their files successfully and where
				# the compressed file is.
				print "Your file '#{file}' was compressed to:
          '#{output_file}'

"
			end
		end
	end	
end