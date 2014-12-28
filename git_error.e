note
	description: "Summary description for {GIT_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
		do
			make_with_code({GIT_EXTERNAL}.GIT_OK)
		end

	make_with_code(a_code:INTEGER)
		do
			make
			set_code(a_code)
		end

feature -- Query

	out:STRING_8
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
