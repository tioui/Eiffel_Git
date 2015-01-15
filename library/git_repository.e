note
	description: "A Git repository."
	author: "Louis Marchand"
	date: "2014, december 26"
	revision: "0.1"

class
	GIT_REPOSITORY

inherit
	DISPOSABLE
		redefine
			default_create
		end

create
	make_and_initialize,
	make_and_open,
	make_from_clone

feature {NONE} -- Initialization

	make_and_initialize(a_folder_name:READABLE_STRING_GENERAL; a_options:GIT_INITIALIZATION_OPTIONS)
			-- Create `Current' and Initialize a new empty git repository located at `a_folder_name'
			-- folder using `a_options' as initialization options (similar to the
			-- `git init` command).
		require
			Folder_Name_Not_Empty: not a_folder_name.is_empty
		local
			l_c_path:C_STRING
			l_error:INTEGER
			l_indirect_repository:POINTER
		do
			default_create
			create l_c_path.make (a_folder_name)
			l_indirect_repository := l_indirect_repository.memory_calloc (1, {GIT_EXTERNAL}.sizeof_pointer)
			l_error := {GIT_EXTERNAL}.git_repository_init_ext(l_indirect_repository, l_c_path.item, a_options.item)
			item := {GIT_EXTERNAL}.deferencing_git_repository_pointer (l_indirect_repository)
			error.set_code (l_error)
		ensure
			Success_Initialized: error.is_ok implies is_open
		end

	make_and_open(a_folder_name:READABLE_STRING_GENERAL; a_options:GIT_OPEN_OPTIONS)
			-- Open an existing git repository located at `a_folder_nae' using
			-- `a_options' to configure the open command.
		require
			Folder_Name_Not_Empty: not a_folder_name.is_empty
		local
			l_c_path:C_STRING
			l_error:INTEGER
			l_path_list:READABLE_STRING_GENERAL
			l_path_separator:STRING
			l_c_list:C_STRING
			l_indirect_repository:POINTER
		do
			default_create
			create l_path_separator.make_filled ({GIT_EXTERNAL}.GIT_PATH_LIST_SEPARATOR, 1)
			l_path_list := ""
			across a_options.ceiling_dirs as la_dir loop
				if attached l_path_list then
					l_path_list := l_path_list + l_path_separator + la_dir.item
				else
					l_path_list := la_dir.item
				end
			end
			create l_c_path.make (a_folder_name)
			create l_c_list.make (l_path_list)
			l_indirect_repository := l_indirect_repository.memory_calloc (1, {GIT_EXTERNAL}.sizeof_pointer)
			l_error := {GIT_EXTERNAL}.git_repository_open_ext(l_indirect_repository, l_c_path.item, a_options.code, l_c_list.item)
			item := {GIT_EXTERNAL}.deferencing_git_repository_pointer (l_indirect_repository)
			error.set_code (l_error)
		ensure
			Success_Opened: error.is_ok implies is_open
		end

	make_from_clone(a_url, a_path:READABLE_STRING_GENERAL;a_options:GIT_CLONE_OPTIONS)
			-- Cloning a remote repository from `a_url' to the local directory `a_path' using
			-- the clone options `a_options' and open the local repository.
		local
			l_c_url, l_c_path:C_STRING
			l_error : INTEGER
			l_indirect_repository:POINTER
		do
			default_create
			create l_c_path.make (a_path)
			create l_c_url.make (a_url)
			a_options.start_callback
			l_indirect_repository := l_indirect_repository.memory_calloc (1, {GIT_EXTERNAL}.sizeof_pointer)
			l_error := {GIT_EXTERNAL}.git_clone(l_indirect_repository, l_c_url.item, l_c_path.item, a_options.item)
			item := {GIT_EXTERNAL}.deferencing_git_repository_pointer (l_indirect_repository)
			a_options.stop_callback
			error.set_code (l_error)
		ensure
			Success_Opened: error.is_ok implies is_open
		end

	default_create
			-- Standard initialization of `Current'
		do
			create error
		end

feature -- Access

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

	repository_folder_name:READABLE_STRING_GENERAL
			-- The text name of the location of the repository.
			-- If `Current' is a bare repository, it should be the
			-- same as `working_folder_name'. If `Current' is not
			-- a bare repository, it is normally a ".git" directory
			-- inside the `working_folder_name'
		require
			Repository_Is_Open: is_open
		do
			Result := (create{C_STRING}.make_by_pointer ({GIT_EXTERNAL}.git_repository_path(item))).string
		end

	working_folder_name:READABLE_STRING_GENERAL assign set_working_folder_name
			-- The text name of the location of the working directory.
		require
			Repository_Is_Open: is_open
			Working_Folder_Is_Not_Bare: not is_bare
		local
			l_name_ptr:POINTER
		do
			l_name_ptr := {GIT_EXTERNAL}.git_repository_workdir(item)
			if l_name_ptr.is_default_pointer then
				Result := ""
			else
				Result := (create {C_STRING}.make_by_pointer (l_name_ptr)).string
			end
		end

	set_working_folder_name(a_working_folder_name:READABLE_STRING_GENERAL)
			-- Assign the `working_folder_name' to `a_working_folder_name'.
			-- If `Current' was a bare repository, it is not a standard
			-- repository that can use working directory manipulation.
		require
			Repository_Is_Open: is_open
		local
			l_c_string: C_STRING
			l_error:INTEGER
		do
			create l_c_string.make (a_working_folder_name)
			l_error := {GIT_EXTERNAL}.git_repository_set_workdir(item, l_c_string.item, 0)
			error.set_code (l_error)
		end

	set_working_folder_name_updating_uplink(a_working_folder_name:READABLE_STRING_GENERAL)
			-- Assign the `working_folder_name' to `a_working_folder_name' and update
			-- the working directory gitlink and set the config `core.worktree`.
			-- If `Current' was a bare repository, it is not a standard
			-- repository that can use working directory manipulation.
		require
			Repository_Is_Open: is_open
		local
			l_c_string: C_STRING
			l_error:INTEGER
		do
			create l_c_string.make (a_working_folder_name)
			l_error := {GIT_EXTERNAL}.git_repository_set_workdir(item, l_c_string.item, 1)
			error.set_code (l_error)
		end

	is_bare:BOOLEAN
			-- True if `Current' is a bare repository
			-- A bare repository is a repository without working directories
		require
			Repository_Is_Open: is_open
		do
			Result := {GIT_EXTERNAL}.git_repository_is_bare(item)
		end

	is_empty:BOOLEAN
			-- True if `Current' is empty
			-- If the repository is corrupted, return False
			-- and set an `error'.
		require
			Repository_Is_Open: is_open
		local
			l_error:INTEGER
		do
			l_error := {GIT_EXTERNAL}.git_repository_is_empty(item)
			Result := l_error = 1
			if l_error < 0 then
				error.set_code (l_error)
			end
		end

	is_shallow_clone:BOOLEAN
			-- True if `Current' is a shallow clone
		require
			Repository_Is_Open: is_open
		do
			Result := {GIT_EXTERNAL}.git_repository_is_shallow(item)
		end

	is_state_no_operation:BOOLEAN
			-- True if the repository represented by `Current' is not doing
			-- any operation
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_NONE)
		end

	is_state_merging:BOOLEAN
			-- True if the repository represented by `Current' is currently merging
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_MERGE)
		end

	is_state_reverting:BOOLEAN
			-- True if the repository represented by `Current' is currently reverting
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_REVERT)
		end

	is_state_cherry_picking:BOOLEAN
			-- True if the repository represented by `Current' is currently cherry-picking
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_CHERRY_PICK)
		end

	is_state_bisecting:BOOLEAN
			-- True if the repository represented by `Current' is currently bisecting
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_BISECT)
		end

	is_state_rebasing:BOOLEAN
			-- True if the repository represented by `Current' is currently rebasing
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_REBASE)
		end

	is_state_interactive_rebasing:BOOLEAN
			-- True if the repository represented by `Current' is currently
			-- doing interactive rebasing
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_REBASE_INTERACTIVE)
		end

	is_state_merge_rebasing:BOOLEAN
			-- True if the repository represented by `Current' is currently
			-- doing merge rebasing
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_REBASE_MERGE)
		end

	is_state_applying_mailbox:BOOLEAN
			-- True if the repository represented by `Current' is currently
			-- applying patches from mailbox
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_APPLY_MAILBOX)
		end

	is_state_applying_mailbox_or_rebase:BOOLEAN
			-- True if the repository represented by `Current' is currently
			-- applying patches from mailbox or rebasing
		require
			Repository_Is_Open: is_open
		do
			Result := state_query({GIT_EXTERNAL}.GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE)
		end

	clear_state
			-- Remove all the metadata associated with an ongoing command like merge,
			-- revert, cherry-pick, etc.
		require
			Repository_Is_Open: is_open
		do
			error.set_code ({GIT_EXTERNAL}.git_repository_state_cleanup(item))
		ensure
			State_Is_Clear: error.is_ok implies is_state_no_operation
		end

	prepared_message:READABLE_STRING_GENERAL
			-- Some operations such as git revert/cherry-pick/merge
			-- with the -n option stop just short of creating a commit
			-- with the changes and save their prepared message.
			-- Use this to retreive this message. Don't forget to
			-- use the `remove_prepared_message' method after commiting.
		require
			Repository_Is_Open: is_open
		local
			l_buffer:MANAGED_POINTER
			l_error:INTEGER
			l_c_string:C_STRING
		do
			create l_buffer.make ({GIT_EXTERNAL}.sizeof_git_buf)
			l_error := {GIT_EXTERNAL}.git_repository_message(l_buffer.item, item)
			error.set_code (l_error)
			if l_error = 0 then
				create l_c_string.make_by_pointer_and_count (
						{GIT_EXTERNAL}.git_buf_get_ptr(l_buffer.item), {GIT_EXTERNAL}.git_buf_get_size(l_buffer.item))
				Result := l_c_string.string
			else
				Result := ""
			end
			{GIT_EXTERNAL}.git_buf_free(l_buffer.item)
		end

	remove_prepared_message
			-- Some operations such as git revert/cherry-pick/merge
			-- with the -n option stop just short of creating a commit
			-- with the changes and save their prepared message.
			-- Use this method to remove the message (for exemple, after commiting).
		require
			Repository_Is_Open: is_open
		do
			error.set_code ({GIT_EXTERNAL}.git_repository_message_remove(item))
		end

	namespace:READABLE_STRING_GENERAL assign set_namespace
			-- The namespace used by `Current'
		require
			Repository_Is_Open: is_open
		do
			Result := (create {C_STRING}.make_by_pointer (
							{GIT_EXTERNAL}.git_repository_get_namespace(item))).string
		end

	set_namespace(a_namespace:READABLE_STRING_GENERAL)
			-- Assign the `namespace' used by `Current' with the value of `a_namepace'.
		require
			Repository_Is_Open: is_open
		local
			l_c_string:C_STRING
		do
			create l_c_string.make (a_namespace)
			error.set_code ({GIT_EXTERNAL}.git_repository_set_namespace(item, l_c_string.item))
		ensure
			Is_Set: error.is_ok implies namespace ~ a_namespace
		end

	error:GIT_ERROR
			-- The last error that has append in the internal library when managing `Current'

feature {NONE} -- Implementation

	item:POINTER
			-- The internal C pointer of `Current'

	dispose
			-- <Precursor>
		do
			if is_open then
				close
			end
		end

	state_query(a_state_index:INTEGER):BOOLEAN
			-- True if the state of the repository represented by `Current'
			-- is currently represented by `a_state_index'
		require
			Repository_Is_Open: is_open
		local
			l_error:INTEGER
		do
			l_error := {GIT_EXTERNAL}.git_repository_state(item)
			if l_error < 0 then
				error.set_code (l_error)
				Result := False
			else
				Result := l_error ~ a_state_index
			end
		end

end
