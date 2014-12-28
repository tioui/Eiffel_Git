note
	description: "Every options that can be used by the {GIT_REPOSITORY}.`initialize` methode"
	author: "Louis Marchand"
	date: "2014, december 27"
	revision: "0.1"

class
	GIT_INITIALIZATION_OPTIONS

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
		do
			make
			set_version({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_OPTIONS_VERSION)
			set_flags (0)
			set_working_path_name(Void)
			set_template_path_name(Void)
			set_description(Void)
			set_initial_head(Void)
			set_origin_url(Void)
			unset_bare
			unset_reinitialize
			set_dot_git
			unset_make_working_directory
			unset_make_working_path
			unset_external_template
			set_umask_mode
		end

feature -- Access

	version:NATURAL
			-- The version of the internal format of `Current'
		do
			Result := {GIT_EXTERNAL}.git_repository_init_options_get_version(item)
		end

	working_path_name:detachable READABLE_STRING_GENERAL assign set_working_path_name
			-- Path to the working dir or Void for default
			-- (i.e. repo_path parent on non-bare repos)
			-- IF THIS IS RELATIVE PATH, IT WILL BE EVALUATED RELATIVE TO THE REPO_PATH.
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_repository_init_options_get_workdir_path(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_working_path_name(a_working_path_name:detachable READABLE_STRING_GENERAL)
			-- Assign `a_working_path_name' to `working_path_name'
		local
			l_c_string:C_STRING
		do
			if attached a_working_path_name then
				create l_c_string.make (a_working_path_name)
				{GIT_EXTERNAL}.git_repository_init_options_set_workdir_path(item, l_c_string.item)
				internal_working_path_name := l_c_string
			else
				{GIT_EXTERNAL}.git_repository_init_options_set_workdir_path(item, create {POINTER})
				internal_working_path_name := Void
			end
		ensure
			Is_Assign: a_working_path_name ~ working_path_name
		end

	template_path_name:detachable READABLE_STRING_GENERAL assign set_template_path_name
			-- Path to use for the template directory. If this is NULL,
			-- the config or default directory options will be used instead.
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_repository_init_options_get_template_path(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_template_path_name(a_template_path_name:detachable READABLE_STRING_GENERAL)
			-- Assign `a_template_path_name' to `template_path_name'
		local
			l_c_string:C_STRING
		do
			if attached a_template_path_name then
				create l_c_string.make (a_template_path_name)
				{GIT_EXTERNAL}.git_repository_init_options_set_template_path(item, l_c_string.item)
				internal_template_path_name := l_c_string
			else
				{GIT_EXTERNAL}.git_repository_init_options_set_template_path(item, create {POINTER})
				internal_template_path_name := Void
			end
		ensure
			Is_Assign: a_template_path_name ~ template_path_name
		end

	description:detachable READABLE_STRING_GENERAL assign set_description
			-- If not Void, this will be used to initialize the "description"
			-- file in the repository, instead of using the template content.
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_repository_init_options_get_description(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_description(a_description:detachable READABLE_STRING_GENERAL)
			-- Assign `a_description' to `description'
		local
			l_c_string:C_STRING
		do
			if attached a_description then
				create l_c_string.make (a_description)
				{GIT_EXTERNAL}.git_repository_init_options_set_description(item, l_c_string.item)
				internal_description := l_c_string
			else
				{GIT_EXTERNAL}.git_repository_init_options_set_description(item, create {POINTER})
				internal_description := Void
			end
		ensure
			Is_Assign: a_description ~ description
		end

	initial_head:detachable READABLE_STRING_GENERAL assign set_initial_head
			-- The name of the head to point HEAD at. If Void, then this will be treated as
			-- "master" and the HEAD ref will be set to "refs/heads/master". If this begins
			-- with "refs/" it will be used verbatim; otherwise "refs/heads/" will be prefixed.
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_repository_init_options_get_initial_head(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_initial_head(a_initial_head:detachable READABLE_STRING_GENERAL)
			-- Assign `a_initial_head' to `initial_head'
		local
			l_c_string:C_STRING
		do
			if attached a_initial_head then
				create l_c_string.make (a_initial_head)
				{GIT_EXTERNAL}.git_repository_init_options_set_initial_head(item, l_c_string.item)
				internal_initial_head := l_c_string
			else
				{GIT_EXTERNAL}.git_repository_init_options_set_initial_head(item, create {POINTER})
				internal_initial_head := Void
			end
		ensure
			Is_Assign: a_initial_head ~ initial_head
		end

	origin_url:detachable READABLE_STRING_GENERAL assign set_origin_url
			-- If this is non-Void, then after the rest of the repository initialization
			-- is completed, an "origin" remote will be added pointing to this URL.
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_repository_init_options_get_origin_url(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_origin_url(a_origin_url:detachable READABLE_STRING_GENERAL)
			-- Assign `a_origin_url' to `origin_url'
		local
			l_c_string:C_STRING
		do
			if attached a_origin_url then
				create l_c_string.make (a_origin_url)
				{GIT_EXTERNAL}.git_repository_init_options_set_origin_url(item, l_c_string.item)
				internal_origin_url := l_c_string
			else
				{GIT_EXTERNAL}.git_repository_init_options_set_origin_url(item, create {POINTER})
				internal_origin_url := Void
			end
		ensure
			Is_Assign: a_origin_url ~ origin_url
		end

	is_bare:BOOLEAN
			-- If set, a bare repository with no working directory will be created
			-- Default value: False
		do
			Result := (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_BARE)) /= 0
		end

	set_bare
			-- Active `is_bare'
		do
			set_flags (flags.bit_or ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_BARE))
		ensure
			Is_Set: is_bare
		end

	unset_bare
			-- Desactive `is_bare'
		do
			set_flags (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_BARE.bit_not))
		ensure
			Is_Unset: not is_bare
		end

	can_reinitialize:BOOLEAN
			-- If not set, give an error if the repo_path
			-- appears to already be an git repository
			-- Default value: False
		do
			Result := (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_NO_REINIT)) = 0
		end

	set_reinitialize
			-- Active `can_reinitialize'
		do
			set_flags (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_NO_REINIT.bit_not))

		ensure
			Is_Set: can_reinitialize
		end

	unset_reinitialize
			-- Desactive `can_reinitialize'
		do
			set_flags (flags.bit_or ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_NO_REINIT))
		ensure
			Is_Unset: not can_reinitialize
		end

	use_dot_git:BOOLEAN
			-- Normally a ".git" will be appended to the repo path. Unset this to
			-- prevents that behavior.
			-- Default value: True
		do
			Result := (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_NO_DOTGIT_DIR)) = 0
		end

	set_dot_git
			-- Active `use_dot_git'
		do
			set_flags (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_NO_DOTGIT_DIR.bit_not))
		ensure
			Is_Set: use_dot_git
		end

	unset_dot_git
			-- Desactive `use_dot_git'
		do
			set_flags (flags.bit_or ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_NO_DOTGIT_DIR))
		ensure
			Is_Unset: not use_dot_git
		end

	must_make_working_directory:BOOLEAN
			-- Make the repo_path (and workdir_path) as needed
			-- Default value: False
		do
			Result := (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_MKDIR)) /= 0
		end

	set_make_working_directory
			-- Active `must_make_working_directory'
		do
			set_flags (flags.bit_or ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_MKDIR))
		ensure
			Is_Set: must_make_working_directory
		end

	unset_make_working_directory
			-- Desactive `must_make_working_directory'
		do
			set_flags (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_MKDIR.bit_not))
		ensure
			Is_Unset: not must_make_working_directory
		end

	must_make_working_path:BOOLEAN
			-- Recursively make the repo_path (and workdir_path) as needed
			-- Default value: False
		do
			Result := (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_MKPATH)) /= 0
		end

	set_make_working_path
			-- Active `must_make_working_path'
		do
			set_flags (flags.bit_or ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_MKPATH))
		ensure
			Is_Set: must_make_working_path
		end

	unset_make_working_path
			-- Desactive `must_make_working_path'
		do
			set_flags (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_MKPATH.bit_not))
		ensure
			Is_Unset: not must_make_working_path
		end

	use_external_template:BOOLEAN
			-- Enables external templates, looking the `template_path_name'
			-- if not Void, or the `init.templatedir` global config, or falling
			-- back on "/usr/share/git-core/templates" if it exists.
			-- Default value: False
		do
			Result := (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE)) /= 0
		end

	set_external_template
			-- Active `use_external_template'
		do
			set_flags (flags.bit_or ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE))
		ensure
			Is_Set: use_external_template
		end

	unset_external_template
			-- Desactive `use_external_template'
		do
			set_flags (flags.bit_and ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE.bit_not))
		ensure
			Is_Unset: not use_external_template
		end

	use_umask_mode:BOOLEAN
			-- Use permissions configured by umask
			-- This is the default value.
		do
			Result := mode ~ {GIT_EXTERNAL}.GIT_REPOSITORY_INIT_SHARED_UMASK
		end

	set_umask_mode
			-- Activate `use_umask_mode'
		do
			set_mode ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_SHARED_UMASK)
		ensure
			Is_Set: use_umask_mode
		end

	use_group_mode:BOOLEAN
			-- Change the new repo mode to be group writable
		do
			Result := mode ~ {GIT_EXTERNAL}.GIT_REPOSITORY_INIT_SHARED_GROUP
		end

	set_group_mode
			-- Activate `use_group_mode'
		do
			set_mode ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_SHARED_GROUP)
		ensure
			Is_Set: use_group_mode
		end

	use_world_mode:BOOLEAN
			-- Change the new repo mode to be group writable (like `use_group_mode') and world readable
		do
			Result := mode ~ {GIT_EXTERNAL}.GIT_REPOSITORY_INIT_SHARED_ALL
		end

	set_world_mode
			-- Activate `use_world_mode'
		do
			set_mode ({GIT_EXTERNAL}.GIT_REPOSITORY_INIT_SHARED_ALL)
		ensure
			Is_Set: use_world_mode
		end

feature {NONE} -- Implementation

	flags:NATURAL_32
			-- The internal combination of GIT_REPOSITORY_INIT flags
		do
			Result := {GIT_EXTERNAL}.git_repository_init_options_get_flags(item)
		end

	mode:NATURAL_32
			-- One of the internal GIT_REPOSITORY_INIT_SHARED_... constants
		do
			Result := {GIT_EXTERNAL}.git_repository_init_options_get_mode(item)
		end

	set_version(a_version:NATURAL)
			-- Assign `version' with the value of `a_version'
		do
			{GIT_EXTERNAL}.git_repository_init_options_set_version(item, a_version)
		ensure
			Is_Assign: version ~ a_version
		end

	set_flags(a_flags:NATURAL)
			-- Assign `flags' with the value of `a_flags'
		do
			{GIT_EXTERNAL}.git_repository_init_options_set_flags(item, a_flags)
		ensure
			Is_Assign: flags ~ a_flags
		end

	set_mode(a_mode:NATURAL)
			-- Assign `mode' with the value of `a_mode'
		do
			{GIT_EXTERNAL}.git_repository_init_options_set_mode(item, a_mode)
		ensure
			Is_Assign: mode ~ a_mode
		end

	structure_size:INTEGER
			-- <Precursor>
		do
			Result := {GIT_EXTERNAL}.sizeof_git_repository_init_options
		end

	internal_working_path_name:detachable C_STRING
			-- To protect the C string assign to `working_path_name' internal struture
			-- from being collected.

	internal_template_path_name:detachable C_STRING
			-- To protect the C string assign to `template_path_name' internal struture
			-- from being collected.

	internal_description:detachable C_STRING
			-- To protect the C string assign to `description' internal struture
			-- from being collected.

	internal_initial_head:detachable C_STRING
			-- To protect the C string assign to `initial_head' internal struture
			-- from being collected.

	internal_origin_url:detachable C_STRING
			-- To protect the C string assign to `origin_url' internal struture
			-- from being collected.

end
