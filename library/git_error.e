note
	description: "Error manager for the Eiffel_Git library."
	author: "Louis Marchand"
	date: "2014, december 26"
	revision: "0.1"

class
	GIT_ERROR

inherit
	ANY
		redefine
			default_create, out
		end
	MEMORY_STRUCTURE
		export
			{NONE} all
		redefine
			default_create, out
		end
create
	default_create,
	make_with_code

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		do
			make_with_code({GIT_EXTERNAL}.GIT_OK)
		end

	make_with_code(a_code:INTEGER)
			-- Initialization of `Current' using `a_code' as error `code'
		do
			make
			set_code(a_code)
		end

feature -- Query

	out:STRING_8
			-- <Precursor>
		do
			if {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_NONE then
				if is_ok then
					Result := "No error"
				elseif is_generic then
					Result := "Generic error"
				elseif is_object_not_found then
					Result := "Requested object could not be found"
				elseif is_object_exists then
					Result := "Object exists preventing operation"
				elseif is_ambiguous then
					Result := "More than one object matches"
				elseif is_buffer_too_short then
					Result := "Output buffer too short to hold data"
				elseif is_user_defined then
					Result := "Error in user callback function"
				elseif is_bare_repository then
					Result := "Operation not allowed on bare repository"
				elseif is_unborn_branch then
					Result := "HEAD refers to branch with no commits"
				elseif is_merge_in_progress then
					Result := "Merge in progress prevented operation"
				elseif is_cannot_fast_forward then
					Result := "Reference was not fast-forwardable"
				elseif is_spec_not_valid then
					Result := "Name/ref spec was not in a valid format"
				elseif is_locked then
					Result := "Lock file prevented operation"
				elseif is_merge_conflict then
					Result := "Merge conflicts prevented operation"
				elseif is_reference_modified then
					Result := "Reference value does not match expected"
				elseif is_internal then
					Result := "Internal error (should never happend)"
				elseif is_iteration_over then
					Result := "Signals end of iteration with iterator"
				else
					Result := "Unmanaged error"
				end
			else
				Result := (create {C_STRING}.make_by_pointer ({GIT_EXTERNAL}.git_error_get_message(item))).string
			end

		end

	is_ok:BOOLEAN
			-- `Current' represent no error
		do
			Result := code = {GIT_EXTERNAL}.GIT_OK
		end

	is_generic:BOOLEAN
			-- `Current' represent a generic error
		do
			Result := code = {GIT_EXTERNAL}.GIT_ERROR
		end

	is_object_not_found:BOOLEAN
			-- Requested object could not be found
		do
			Result := code = {GIT_EXTERNAL}.GIT_ENOTFOUND
		end

	is_object_exists:BOOLEAN
			-- Object exists preventing operation
		do
			Result := code = {GIT_EXTERNAL}.GIT_EEXISTS
		end

	is_ambiguous:BOOLEAN
			-- More than one object matches
		do
			Result := code = {GIT_EXTERNAL}.GIT_EAMBIGUOUS
		end

	is_buffer_too_short:BOOLEAN
			-- Output buffer too short to hold data
		do
			Result := code = {GIT_EXTERNAL}.GIT_EBUFS
		end

	is_user_defined:BOOLEAN
			-- `Current' represent an error returned from a user callback
		do
			Result := code = {GIT_EXTERNAL}.GIT_EUSER
		end

	is_bare_repository:BOOLEAN
			-- Operation not allowed on bare repository
		do
			Result := code = {GIT_EXTERNAL}.GIT_EBAREREPO
		end

	is_unborn_branch:BOOLEAN
			-- HEAD refers to branch with no commits
		do
			Result := code = {GIT_EXTERNAL}.GIT_EUNBORNBRANCH
		end

	is_merge_in_progress:BOOLEAN
			-- Merge in progress prevented operation
		do
			Result := code = {GIT_EXTERNAL}.GIT_EUNMERGED
		end

	is_cannot_fast_forward:BOOLEAN
			-- Reference was not fast-forwardable
		do
			Result := code = {GIT_EXTERNAL}.GIT_ENONFASTFORWARD
		end

	is_spec_not_valid:BOOLEAN
			-- Name/ref spec was not in a valid format
		do
			Result := code = {GIT_EXTERNAL}.GIT_EINVALIDSPEC
		end

	is_locked:BOOLEAN
			-- Lock file prevented operation
		do
			Result := code = {GIT_EXTERNAL}.GIT_ELOCKED
		end

	is_merge_conflict:BOOLEAN
			-- Merge conflicts prevented operation
		do
			Result := code = {GIT_EXTERNAL}.GIT_EMERGECONFLICT
		end

	is_reference_modified:BOOLEAN
			-- Reference value does not match expected
		do
			Result := code = {GIT_EXTERNAL}.GIT_EMODIFIED
		end

	is_internal:BOOLEAN
			-- Internal error (should never happend)
		do
			Result := code = {GIT_EXTERNAL}.GIT_PASSTHROUGH
		end

	is_iteration_over:BOOLEAN
			-- Signals end of iteration with iterator
		do
			Result := code = {GIT_EXTERNAL}.GIT_ITEROVER
		end

	is_no_memory:BOOLEAN
			-- Not enough memory to perform operation
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_NOMEMORY
		end

	is_operating_system_error:BOOLEAN
			-- The operating system does not support used operation
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_OS
		end

	is_commands_invalid:BOOLEAN
			-- The used commands are invalid
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_INVALID
		end

	is_reference_invalid:BOOLEAN
			-- There was an error in the reference (name or spec)
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_REFERENCE
		end

	is_zlib_error:BOOLEAN
			-- An error happend in the Zlib library
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_ZLIB
		end

	is_repository_problem:BOOLEAN
			-- An error occured in the repository
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_REPOSITORY
		end

	is_configuration_invalid:BOOLEAN
			-- The Git configuration is not valid
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_CONFIG
		end

	is_regular_expression_not_valid:BOOLEAN
			-- The used regular expression is not valid
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_REGEX
		end

	is_object_database_error:BOOLEAN
			-- There was an error in the repository object database (ODB)
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_ODB
		end

	is_index_not_valid:BOOLEAN
			-- There was an error while using an index
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_INDEX
		end

	is_object_not_valid:BOOLEAN
			-- There was an error while using an object
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_OBJECT
		end

	is_network_error:BOOLEAN
			-- There was an error while using the network
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_NET
		end

	is_tag_not_valid:BOOLEAN
			-- There was an error while using a tag
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_TAG
		end

	is_tree_error:BOOLEAN
			-- There was an error while using the repository tree
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_TREE
		end

	is_indexer_error:BOOLEAN
			-- There was an error while using the indexer
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_INDEXER
		end

	is_ssl_error:BOOLEAN
			-- There was an error in the SSL library
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_SSL
		end

	is_submodule_not_valid:BOOLEAN
			-- There was an error in a git submodule
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_SUBMODULE
		end

	is_thread_error:BOOLEAN
			-- There was an error in the internal thread manipulation
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_THREAD
		end

	is_stash_changes_not_valid:BOOLEAN
			-- There was an error in a stash changes
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_STASH
		end

	is_checkout_error:BOOLEAN
			-- There was an error when using a checkout
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_CHECKOUT
		end

	is_fetch_head_error:BOOLEAN
			-- There was an error while fetching head
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_FETCHHEAD
		end

	is_merge_error:BOOLEAN
			-- There was an error while merging
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_MERGE
		end

	is_ssh_error:BOOLEAN
			-- There was an error in the SSH library
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_SSH
		end

	is_filter_error:BOOLEAN
			-- There was an error in the filtering command
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_FILTER
		end

	is_revert_error:BOOLEAN
			-- There was an error while reverting
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_REVERT
		end

	is_callback_error:BOOLEAN
			-- There was an error in a C callback
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_CALLBACK
		end

	is_cherry_pick_error:BOOLEAN
			-- There was an error while cherry-picking
		do
			Result := {GIT_EXTERNAL}.git_error_get_klass(item) = {GIT_EXTERNAL}.GITERR_CHERRYPICK
		end

feature -- Access

	code:INTEGER assign set_code
			-- The internal identifier of `Current'

	set_code(a_code:INTEGER)
			-- Assign `Current's internal `code' to `a_code'
		local
			l_error:INTEGER
		do
			code := a_code
			l_error := {GIT_EXTERNAL}.giterr_detach(item)
		end

	structure_size:INTEGER
			-- <Precursor>
		do
			Result := {GIT_EXTERNAL}.sizeof_git_error
		end
end
