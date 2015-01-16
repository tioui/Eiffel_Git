note
	description: "Options to use when a clone is performed."
	author: "Louis Marchand"
	date: "2015, january 3"
	revision: "0.1"
	ToDo: "Signature"

class
	GIT_CLONE_OPTIONS

inherit
	ANY
		redefine
			default_create
		end
	MEMORY_STRUCTURE
		export
			{NONE} all
			{GIT_REPOSITORY} item
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		local
			l_error:INTEGER
		do
			make
			l_error := {GIT_EXTERNAL}.git_clone_init_options(item,{GIT_EXTERNAL}.GIT_CLONE_OPTIONS_VERSION)
			create error
			create progress_action
			create checkout_options.make_from_clone_option ({GIT_EXTERNAL}.git_clone_options_get_checkout_opts(item))
			checkout_options.set_parent_clone_options (Current)
			checkout_options.enable_safe_with_create
			is_callback_initialize := False
			error.set_code (l_error)
		ensure then
			No_Error_Implies_Valid: error.is_ok implies is_valid
		end

feature -- Access

	is_bare:BOOLEAN
			-- The clone will create a bare repository
		do
			Result := {GIT_EXTERNAL}.git_clone_options_get_bare(item)
		end

	enable_bare
			-- Enable `is_bare'
		do
			{GIT_EXTERNAL}.git_clone_options_set_bare(item, True)
		end

	disable_bare
			-- Disable `is_bare'
		do
			{GIT_EXTERNAL}.git_clone_options_set_bare(item, False)
		end

	must_ignore_certificate_errors:BOOLEAN
			-- If `True' validating the remote host's certificate will be ignored.
		do
			Result := {GIT_EXTERNAL}.git_clone_options_get_ignore_cert_errors(item)
		end

	enable_ignore_certificate_errors
			-- Enable `must_ignore_certificate_errors'
		do
			{GIT_EXTERNAL}.git_clone_options_set_ignore_cert_errors(item, True)
		end

	disable_ignore_certificate_errors
			-- Disable `must_ignore_certificate_errors'
		do
			{GIT_EXTERNAL}.git_clone_options_set_ignore_cert_errors(item, False)
		end

	remote_name:detachable READABLE_STRING_GENERAL assign set_remote_name
			-- The name to be given to the remote that will be created.
			-- If `Void', using 'origin'.
		require
			Current_Is_Valid: is_valid
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_clone_options_get_remote_name(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_remote_name(a_remote_name:detachable READABLE_STRING_GENERAL)
			-- Assign `a_remote_name' to `remote_name'
		require
			Current_Is_Valid: is_valid
		local
			l_c_string:C_STRING
		do
			if attached a_remote_name then
				create l_c_string.make (a_remote_name)
				{GIT_EXTERNAL}.git_clone_options_set_remote_name(item, l_c_string.item)
				internal_remote_name := l_c_string
			else
				{GIT_EXTERNAL}.git_clone_options_set_remote_name(item, create {POINTER})
				internal_remote_name := Void
			end
		ensure
			Is_Assign: a_remote_name ~ remote_name
		end

	checkout_branch:detachable READABLE_STRING_GENERAL assign set_checkout_branch
			-- The name of the branch to checkout. `Void' means use the
			-- remote's default branch.
		require
			Current_Is_Valid: is_valid
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_clone_options_get_checkout_branch(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_checkout_branch(a_checkout_branch:detachable READABLE_STRING_GENERAL)
			-- Assign `a_checkout_branch' to `checkout_branch'
		require
			Current_Is_Valid: is_valid
		local
			l_c_string:C_STRING
		do
			if attached a_checkout_branch then
				create l_c_string.make (a_checkout_branch)
				{GIT_EXTERNAL}.git_clone_options_set_checkout_branch(item, l_c_string.item)
				internal_checkout_branch := l_c_string
			else
				{GIT_EXTERNAL}.git_clone_options_set_checkout_branch(item, create {POINTER})
				internal_checkout_branch := Void
			end
		ensure
			Is_Assign: a_checkout_branch ~ checkout_branch
		end

	must_auto_detect_local_transport:BOOLEAN
			-- Auto-detect (default); will bypass the git-aware transport
			-- for local paths, but use a normal fetch for `file://` urls.
		require
			Current_Is_Valid: is_valid
		do
			Result  := {GIT_EXTERNAL}.git_clone_options_get_local(item) = {GIT_EXTERNAL}.GIT_CLONE_LOCAL_AUTO
		end

	enable_auto_detect_local_transport
			-- Enable `must_auto_detect_local_transport'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_clone_options_set_local(item, {GIT_EXTERNAL}.GIT_CLONE_LOCAL_AUTO)
		ensure
			Is_Set: must_auto_detect_local_transport
		end

	must_bypass_local_transport:BOOLEAN
			-- Bypass the git-aware transport even for a `file://` url.
		require
			Current_Is_Valid: is_valid
		do
			Result  := {GIT_EXTERNAL}.git_clone_options_get_local(item) = {GIT_EXTERNAL}.GIT_CLONE_LOCAL
		end

	enable_bypass_local_transport
			-- Unable `must_bypass_local_transport'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_clone_options_set_local(item, {GIT_EXTERNAL}.GIT_CLONE_LOCAL)
		ensure
			Is_Set: must_bypass_local_transport
		end

	must_not_bypass_local_transport:BOOLEAN
			-- Do no bypass the git-aware transport
		require
			Current_Is_Valid: is_valid
		do
			Result  := {GIT_EXTERNAL}.git_clone_options_get_local(item) = {GIT_EXTERNAL}.GIT_CLONE_NO_LOCAL
		end

	enable_not_bypass_local_transport
			-- Unable `must_not_bypass_local_transport'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_clone_options_set_local(item, {GIT_EXTERNAL}.GIT_CLONE_NO_LOCAL)
		ensure
			Is_Set: must_not_bypass_local_transport
		end

	must_bypass_local_transport_no_hardlink:BOOLEAN
			-- Bypass the git-aware transport, but do not try to use hardlinks
		require
			Current_Is_Valid: is_valid
		do
			Result  := {GIT_EXTERNAL}.git_clone_options_get_local(item) = {GIT_EXTERNAL}.GIT_CLONE_LOCAL_NO_LINKS
		end

	enable_bypass_local_transport_no_hardlink
			-- Unable `must_bypass_local_transport_no_hardlink'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_clone_options_set_local(item, {GIT_EXTERNAL}.GIT_CLONE_LOCAL_NO_LINKS)
		ensure
			Is_Set: must_bypass_local_transport_no_hardlink
		end

	is_valid:BOOLEAN
			-- Is `Current' in a valid (usable) state
		do
			Result := not item.is_default_pointer
		end

	error:GIT_ERROR
			-- The last error that has append in the internal library when managing `Current'

	checkout_options:GIT_CHECKOUT_OPTIONS
			-- The option for the checkout used in the clone process

	progress_action:ACTION_SEQUENCE[TUPLE[statistics:GIT_TRANSFERT_PROGRESS]]
			-- Actions performed when progress informations are available.

feature {GIT_REPOSITORY} -- Implementation

	start_callback
			-- Must be used to activate the `progress_action' feature (before a clone)
			-- After the clone, the procedure `stop_callback' must be called.
		do
			if not progress_action.is_empty then
				{GIT_EXTERNAL}.git_fetch_start (Current, item)
				is_callback_initialize := True
			end
			checkout_options.start_callback
		end

	stop_callback
			-- Desactivate the `progress_action' feature.
			-- Must be used after the clone. If it is not, a memory leak could
			-- happend.
		do
			if is_callback_initialize then
				{GIT_EXTERNAL}.git_fetch_stop (item)
				is_callback_initialize := False
			end
			checkout_options.stop_callback
		end

	is_callback_initialize:BOOLEAN
			-- Is `progress_action' feature initialized.

feature {NONE} -- implementation

	progress(a_statistics_pointer:POINTER)
			-- Received the transfert (fetch) information `a_statistics_pointer' from
			-- the C callback function.
		do
			if not a_statistics_pointer.is_default_pointer then
				progress_action.call ([create {GIT_TRANSFERT_PROGRESS}.make_by_pointer (a_statistics_pointer)])
			end
		end

	structure_size:INTEGER
			-- <Precursor>
		do
			Result := {GIT_EXTERNAL}.sizeof_git_clone_options
		end

	internal_remote_name:detachable C_STRING
			-- To protect the C string assign to `remote_name' internal struture
			-- from being collected.

	internal_checkout_branch:detachable C_STRING
			-- To protect the C string assign to `checkout_branch' internal struture
			-- from being collected.



end
