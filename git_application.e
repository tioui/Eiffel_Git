note
	description: "Summary description for {GIT_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GIT_APPLICATION

inherit
	DISPOSABLE

feature {NONE} -- Initialization

	make
			-- Initialize the git system for the application
		local
			l_error:INTEGER
		do
			l_error := {GIT_EXTERNAL}.git_threads_init
			create error.make_with_code(l_error)
			is_git_initialized := True
		end

feature {NONE} -- Implementation

	error:GIT_ERROR
			-- The last error that has append in the internal library when managing `Current'

	is_git_initialized:BOOLEAN
			-- The git library has been initialized

	dispose
			-- <Precursor>
		do
			{GIT_EXTERNAL}.git_threads_shutdown
		end

invariant
	Git_Is_Initialized: is_git_initialized

end
