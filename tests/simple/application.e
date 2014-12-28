note
	description : "Test appication for the Eiffel_Git library"
	date        : "2014, December 27"
	revision    : "0.1"

class
	APPLICATION

inherit
	ARGUMENTS
	GIT_APPLICATION
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_repo:GIT_REPOSITORY
			l_options:GIT_INITIALIZATION_OPTIONS
		do
			Precursor {GIT_APPLICATION}
			if error.is_ok then
				create l_repo.make_with_folder_name ("/home/louis/allo/bleh")
				create l_options
				l_options.set_make_working_path
				l_options.set_reinitialize
				l_repo.initialize (l_options)
				if not l_repo.error.is_ok then
					print("Error: " + l_repo.error.out + "%N")
				end
			end
		end

end
