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
				create l_options
				l_options.enable_make_working_path
				l_options.description := "Description du super repo... HÈHÈHÈ."
				create l_repo.make_and_initialize ("/home/louis/allo/bleh", l_options)
				if not l_repo.error.is_ok then
					print("Error: " + l_repo.error.out + "%N")
				end
			end
		end

end
