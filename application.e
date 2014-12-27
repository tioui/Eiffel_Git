note
	description : "eiffel_git application root class"
	date        : "$Date$"
	revision    : "$Revision$"

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
		do
			Precursor {GIT_APPLICATION}
			if error.is_ok then
				print("No error.%N")
			else
				print("Error.%N")
			end
		end

end
