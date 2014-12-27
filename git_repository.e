note
	description: "Summary description for {GIT_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GIT_REPOSITORY

inherit
	DISPOSABLE
	MEMORY_STRUCTURE
		export
			{NONE} all
		end

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

	structure_size:INTEGER
			-- A Git Repository structure should only be allocate by the git2 library
		do
			Result := 0
		end

	dispose
			-- <Precursor>
		do
			if not internal_item.is_default_pointer then
				{GIT_EXTERNAL}.git_repository_free(internal_item)
			end
		end

end
