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
			l_options:GIT_CLONE_OPTIONS
		do
			Precursor {GIT_APPLICATION}
			if error.is_ok then
				create l_options
			--	l_options.progress_action.extend (agent fetch_progress)
			--	l_options.checkout_options.progress_action.extend (agent checkout_progress)
				create l_repo.make_from_clone("https://github.com/tioui/eiffel_game_lib.git", "/home/louis/allo/game", l_options)
				if not l_repo.error.is_ok then
					print("Error: " + l_repo.error.out + "%N")
				end
			end
		end

	fetch_progress(a_statistics:GIT_TRANSFERT_PROGRESS)
		do
			print("Fetch progress: ")
			print("Total_objects=" + a_statistics.total_object.out + " ")
			print("Indexed_objects=" + a_statistics.indexed_objects.out + " ")
			print("Received_objects=" + a_statistics.received_objects.out + " ")
			print("Received_bytes=" + a_statistics.received_bytes.out + "%N")
		end

	checkout_progress(path:READABLE_STRING_GENERAL; current_transfer, total_transfer:INTEGER_64)
		do
			print("Checkout progress: ")
			print("Path=" + path + " ")
			print("(" + current_transfer.out)
			print("/" + total_transfer.out + ")%N")
		end

end
