note
	description: "A Git repository."
	author: "Louis Marchand"
	date: "2014, december 26"
	revision: "0.1"

class
	GIT_REPOSITORY

inherit
	DISPOSABLE

create
	make_with_folder_path,
	make_with_folder_name

feature {NONE} -- Initialization

	make_with_folder_path(a_folder_path:PATH)
			-- Initialization for `Current' using `a_folder_path' to specify the location
		do
			make_with_folder_name(a_folder_path.name)
		end

	make_with_folder_name(a_folder_name:READABLE_STRING_GENERAL)
			-- Initialization for `Current' using `a_folder_name' to specify the location
		do
			create directory.make_with_name (a_folder_name)
			create error
		end

feature -- Access

	initialize(a_options:GIT_INITIALIZATION_OPTIONS)
			-- Create a new empty git repository using `a_options' as
			-- initialization options.
		require
			Initialize_Is_Not_Open: not is_open
		local
			l_c_path:C_STRING
			l_error:INTEGER
		do
			create l_c_path.make (folder_path.absolute_path.name)
			l_error := {GIT_EXTERNAL}.git_repository_init_ext($item, l_c_path.item, a_options.item)
			error.set_code (l_error)
		ensure
			Initialize_Is_Openned: error.is_ok implies is_open
		end

	close
			-- Close the repository
		require
			Close_Is_Open: is_open
		do
			{GIT_EXTERNAL}.git_repository_free(item)
			create item
		ensure
			Close_Is_Close: not is_open
		end

	is_open:BOOLEAN
			-- Is `Current' openned for manipulation
		do
			Result := not item.is_default_pointer
		end

	folder_name:READABLE_STRING_GENERAL
			-- The text name of the location containing `Current'
		do
			Result := directory.path.name
		end

	folder_path:PATH
			-- The {PATH} of the location containing `Current'
		do
			create Result.make_from_separate (directory.path)
		end

	error:GIT_ERROR
			-- The last error that has append in the internal library when managing `Current'

feature {NONE} -- Implementation

	directory:DIRECTORY
			-- The location of `Current'

	item:POINTER
			-- The internal C pointer of `Current'

	dispose
			-- <Precursor>
		do
			if is_open then
				close
			end
		end

end
