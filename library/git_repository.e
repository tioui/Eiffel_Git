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
			create l_c_path.make (directory.path.absolute_path.name)
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
			l_error:INTEGER
			l_c_string:C_STRING
		do
			create l_c_string.make (a_namespace)
			l_error := {GIT_EXTERNAL}.git_repository_set_namespace(item, l_c_string.item)
			error.set_code (l_error)
		ensure
			Is_Set: error.is_ok implies namespace ~ a_namespace
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