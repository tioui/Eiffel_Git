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
		do
			Precursor {GIT_APPLICATION}
			if error.is_ok then
				create l_repo.make_and_open ("/home/louis/allo/bleh", create {GIT_OPEN_OPTIONS})
				if l_repo.error.is_ok then
					if l_repo.is_empty then
						print("The repositoy seems to be empty.%N")
					end
					if l_repo.is_bare then
						print("The repository at " + l_repo.repository_folder_name + " is bare.%N")
					else
						print("The working directory of the repository at " + l_repo.repository_folder_name + " is " + l_repo.working_folder_name + ".%N")
					end
				else
					print("Error: " + l_repo.error.out + "%N")
				end
			end
		end

end
