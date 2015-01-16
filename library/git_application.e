note
	description: "[
					Global management for the Eiffel_Git library.
					The root class of the program must inherit from this
					class and launch the `make' feature in the root method.
				]"
	author: "Louis Marchand"
	date: "2014, december 26"
	revision: "0.1"

deferred class
	GIT_APPLICATION

inherit
	DISPOSABLE

feature {NONE} -- Initialization

	make
			-- Initialize the git system for the application
		do
			create error.make_with_code({GIT_EXTERNAL}.git_threads_init)
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
