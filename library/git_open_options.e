note
	description: "Options to used when opening a {GIT_REPOSITORY} with `make_and_open'."
	author: "Louis Marchand"
	date: "2015, January 3"
	revision: "0.1"

class
	GIT_OPEN_OPTIONS

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			code := 0
			create {LINKED_LIST[READABLE_STRING_GENERAL]} ceiling_dirs.make
		end

feature -- Access

	code:NATURAL
			-- The internal code representing the options

	is_searching_parent:BOOLEAN
			-- Only open the repository if it can be immediately found in the given path.
			-- Default is True
		do
			Result := code.bit_and({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_NO_SEARCH) = 0
		end

	enable_searching_parent
			-- Set `is_searching_parent' to True.
		do
			code := code.bit_and({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_NO_SEARCH.bit_not)
		end

	disable_searching_parent
			-- Set `is_searching_parent' to False.
		do
			code := code.bit_or({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_NO_SEARCH)
		end

	is_search_crossing_filesystem:BOOLEAN
			-- Open will continue searching across filesystem boundaries
			-- Default is False
		do
			Result := code.bit_and({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_CROSS_FS) /= 0
		end

	enable_search_crossing_filesystem
			-- Set `is_search_crossing_filesystem' to True.
		do
			code := code.bit_or({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_CROSS_FS)
		end

	disable_search_crossing_filesystem
			-- Set `is_search_crossing_filesystem' to False.
		do
			code := code.bit_and({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_CROSS_FS.bit_not)
		end

	is_opening_as_bare:BOOLEAN
			-- Open repository as a bare repo regardless of core.bare config
			-- Default is False
		do
			Result := code.bit_and({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_BARE) /= 0
		end

	enable_opening_as_bare
			-- Set `is_opening_as_bare' to True.
		do
			code := code.bit_or({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_BARE)
		end

	disable_opening_as_bare
			-- Set `is_opening_as_bare' to False.
		do
			code := code.bit_and({GIT_EXTERNAL}.GIT_REPOSITORY_OPEN_BARE.bit_not)
		end

	ceiling_dirs:LIST[READABLE_STRING_GENERAL]
			-- The list of directory name that make the search stop when
			-- `is_searching_parent' is set.

end
