note
	description: "Options to use when a checkout is performed."
	author: "Louis Marchand"
	date: "2015, january 3"
	revision: "0.1"
	ToDo: "Notify callback"
	ToDo: "baseline field of the structure. Git Tree Needed."

class
	GIT_CHECKOUT_OPTIONS

inherit
	ANY
		redefine
			default_create
		end
	MEMORY_STRUCTURE
		export
			{NONE} all
		redefine
			default_create
		end

create
	default_create,
	make_from_clone_option

feature {NONE} -- Initialization

	default_create
			-- Initialization of `Current'
		local
			l_error:INTEGER
		do
			make
			l_error := {GIT_EXTERNAL}.git_checkout_init_options(item,{GIT_EXTERNAL}.GIT_CHECKOUT_OPTIONS_VERSION)
			make_common
			error.set_code (l_error)
		ensure then
			No_Error_Implies_Valid: error.is_ok implies is_valid
		end

	make_from_clone_option(a_item:POINTER)
			-- Initialization of `Current' sharing `a_item' as `item'
		require
			Is_Pointer_Valid: not a_item.is_default_pointer
		do
			make_by_pointer(a_item)
			make_common
		ensure
			No_Error_Implies_Valid: error.is_ok implies is_valid
		end

	make_common
			-- Code that every creator have to called.
		do
			create error
			create progress_action
			is_callback_initialize := False
			if is_valid then
				enable_safe
				disable_update_allowed_on_conflict
				disable_remove_untracked_files
				disable_remove_ignored_files
				disable_update_only
				enable_update_index
				enable_refresh_before_checkout
				enable_unmerge_files_trigger_conflict
				enable_shell_wildcard_pattern
				disable_skip_locked_directory
				enable_overwrite_ignored_files
				disable_merge_on_conflict
				disable_diff3_on_conflict
				enable_filters
			end
		end

feature -- Access

	is_dry_run:BOOLEAN
			-- No actual update will happend. Just create a dry run that check for conflict
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_NONE) /= 0
		end

	enable_dry_run
			-- Enable `is_dry_run'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item, no_base_strategy.bit_or ({GIT_EXTERNAL}.GIT_CHECKOUT_NONE))
		ensure
			Dry_Run_Is_Set: is_dry_run
			Safe_Is_unset: not is_safe
			Safe_with_create_Is_unset: not is_safe_with_create
			Force_Is_unset: not is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	is_safe:BOOLEAN
			-- Allow safe updates that cannot overwrite uncommitted data
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_SAFE) /= 0
		end

	enable_safe
			-- Enable `is_safe'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item, no_base_strategy.bit_or ({GIT_EXTERNAL}.GIT_CHECKOUT_SAFE))
		ensure
			Safe_Is_Set: is_safe
			Dry_Run_Is_unset: not is_dry_run
			Safe_with_create_Is_unset: not is_safe_with_create
			Force_Is_unset: not is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	is_safe_with_create:BOOLEAN
			-- Allow safe updates plus creation of missing files
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_SAFE_CREATE) /= 0
		end

	enable_safe_with_create
			-- Enable `is_safe_with_create'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item, no_base_strategy.bit_or ({GIT_EXTERNAL}.GIT_CHECKOUT_SAFE_CREATE))
		ensure
			Safe_with_create_Is_Set: is_safe_with_create
			Dry_Run_Is_unset: not is_dry_run
			Safe_Is_unset: not is_safe
			Force_Is_unset: not is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	is_force:BOOLEAN
			-- Allow all updates to force working directory to look like index
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_FORCE) /= 0
		end

	enable_force
			-- Enable `is_force'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item, no_base_strategy.bit_or ({GIT_EXTERNAL}.GIT_CHECKOUT_FORCE))
		ensure
			Force_Is_Set: is_force
			Dry_Run_Is_unset: not is_dry_run
			Safe_Is_unset: not is_safe
			Safe_with_create_Is_unset: not is_safe_with_create
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end


	is_update_allowed_on_conflict:BOOLEAN
			-- Allow checkout to make safe updates even if conflicts are found
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_ALLOW_CONFLICTS) /= 0
		end

	enable_update_allowed_on_conflict
			-- Enable `is_update_allowed_on_conflict'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_ALLOW_CONFLICTS
						)
					)
		ensure
			Is_Set: is_update_allowed_on_conflict
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_update_allowed_on_conflict
			-- Disable `is_update_allowed_on_conflict'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_ALLOW_CONFLICTS.bit_not
						)
				)
		ensure
			Is_UnSet: not is_update_allowed_on_conflict
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_remove_untracked_files:BOOLEAN
			-- Remove untracked files not in index (that are not ignored)
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_REMOVE_UNTRACKED) /= 0
		end

	enable_remove_untracked_files
			-- Enable `must_remove_untracked_files'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_REMOVE_UNTRACKED
						)
					)
		ensure
			Is_Set: must_remove_untracked_files
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_remove_untracked_files
			-- Disable `must_remove_untracked_files'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_REMOVE_UNTRACKED.bit_not
						)
				)
		ensure
			Is_UnSet: not must_remove_untracked_files
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_remove_ignored_files:BOOLEAN
			-- Remove ignored files not in index
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_REMOVE_IGNORED) /= 0
		end

	enable_remove_ignored_files
			-- Enable `must_remove_ignored_files'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_REMOVE_IGNORED
						)
					)
		ensure
			Is_Set: must_remove_ignored_files
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_remove_ignored_files
			-- Disable `must_remove_ignored_files'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_REMOVE_IGNORED.bit_not
						)
				)
		ensure
			Is_UnSet: not must_remove_ignored_files
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	is_update_only:BOOLEAN
			-- Only update existing files, don't create new ones
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_UPDATE_ONLY) /= 0
		end

	enable_update_only
			-- Enable `is_update_only'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_UPDATE_ONLY
						)
					)
		ensure
			Is_Set: is_update_only
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_update_only
			-- Disable `is_update_only'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_UPDATE_ONLY.bit_not
						)
				)
		ensure
			Is_UnSet: not is_update_only
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_update_index:BOOLEAN
			-- Checkout updates index entries as it goes
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_DONT_UPDATE_INDEX) = 0
		end

	enable_update_index
			-- Enable `must_update_index'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_DONT_UPDATE_INDEX.bit_not
						)
				)
		ensure
			Is_Set: must_update_index
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_update_index
			-- Disable `must_update_index'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_DONT_UPDATE_INDEX
						)
					)
		ensure
			Is_UnSet: not must_update_index
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_refresh_before_checkout:BOOLEAN
			-- Don't refresh index/config/etc before doing checkout
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_NO_REFRESH) = 0
		end

	enable_refresh_before_checkout
			-- Enable `must_refresh_before_checkout'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_NO_REFRESH.bit_not
						)
				)
		ensure
			Is_Set: must_refresh_before_checkout
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_refresh_before_checkout
			-- Disable `must_refresh_before_checkout'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_NO_REFRESH
						)
					)
		ensure
			Is_UnSet: not must_refresh_before_checkout
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	is_unmerge_files_trigger_conflict:BOOLEAN
			-- Trigger a conflict when an unmerged files is found on checkout.
		do
			Result := not must_skip_unmerge_files and not must_use_our_files_when_unmerge and not must_use_their_files_when_unmerge
		end

	enable_unmerge_files_trigger_conflict
			-- Enable `is_unmerge_files_trigger_conflict'
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_SKIP_UNMERGED.bit_or (
								{GIT_EXTERNAL}.GIT_CHECKOUT_USE_OURS.bit_or (
									{GIT_EXTERNAL}.GIT_CHECKOUT_USE_THEIRS
								)
							).bit_not
						)
				)
		ensure
			Is_Set: is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_UnSet: not must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Unset: not must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Unset: not must_use_their_files_when_unmerge
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_skip_unmerge_files:BOOLEAN
			-- Only update existing files, don't create new ones
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_SKIP_UNMERGED) /= 0
		end

	enable_skip_unmerge_files
			-- Enable `must_skip_unmerge_files'
		require
			Current_Is_Valid: is_valid
		do
			enable_unmerge_files_trigger_conflict
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_SKIP_UNMERGED
						)
					)
		ensure
			Is_Set: must_skip_unmerge_files
			Unmerge_Files_Trigger_Conflict_UnSet: not is_unmerge_files_trigger_conflict
			Use_Our_Files_When_Unmerge_Unset: not must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Unset: not must_use_their_files_when_unmerge
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_use_our_files_when_unmerge:BOOLEAN
			-- For unmerged files, checkout stage 2 from index
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_USE_OURS) /= 0
		end

	enable_use_our_files_when_unmerge
			-- Enable `must_use_our_files_when_unmerge'
		require
			Current_Is_Valid: is_valid
		do
			enable_unmerge_files_trigger_conflict
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_USE_OURS
						)
					)
		ensure
			Is_Set: must_use_our_files_when_unmerge
			Unmerge_Files_Trigger_Conflict_UnSet: not is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Unset: not must_skip_unmerge_files
			Use_Their_Files_When_Unmerge_Unset: not must_use_their_files_when_unmerge
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_use_their_files_when_unmerge:BOOLEAN
			-- For unmerged files, checkout stage 3 from index
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_USE_THEIRS) /= 0
		end

	enable_use_their_files_when_unmerge
			-- Enable `must_use_their_files_when_unmerge'
		require
			Current_Is_Valid: is_valid
		do
			enable_unmerge_files_trigger_conflict
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_USE_THEIRS
						)
					)
		ensure
			Is_Set: must_use_their_files_when_unmerge
			Unmerge_Files_Trigger_Conflict_UnSet: not is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Unset: not must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Unset: not must_use_our_files_when_unmerge
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_use_shell_wildcard_pattern:BOOLEAN
			-- Use shell wildcard pattern in the `paths_to_checkout' path. If `False',
			-- `paths_to_checkout' is used as a list of path name.
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH) = 0
		end

	enable_shell_wildcard_pattern
			-- Enable `must_use_shell_wildcard_pattern'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH.bit_not
						)
				)
		ensure
			Is_Set: must_use_shell_wildcard_pattern
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_shell_wildcard_pattern
			-- Disable `must_use_shell_wildcard_pattern'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH
						)
					)
		ensure
			Is_UnSet: not must_use_shell_wildcard_pattern
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_skip_locked_directory:BOOLEAN
			-- Ignore directories in use, they will be left empty
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES) /= 0
		end

	enable_skip_locked_directory
			-- Enable `must_skip_locked_directory'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES
						)
					)
		ensure
			Is_Set: must_skip_locked_directory
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_skip_locked_directory
			-- Disable `must_skip_locked_directory'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES.bit_not
						)
				)
		ensure
			Is_UnSet: not must_skip_locked_directory
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_overwrite_ignored_files:BOOLEAN
			-- Overwrite ignored files that exist in the checkout target
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_DONT_OVERWRITE_IGNORED) = 0
		end

	enable_overwrite_ignored_files
			-- Enable `must_overwrite_ignored_files'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_DONT_OVERWRITE_IGNORED.bit_not
						)
				)
		ensure
			Is_Set: must_overwrite_ignored_files
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_overwrite_ignored_files
			-- Disable `must_overwrite_ignored_files'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_DONT_OVERWRITE_IGNORED
						)
					)
		ensure
			Is_UnSet: not must_overwrite_ignored_files
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_merge_on_conflict:BOOLEAN
			-- Write normal merge files for conflicts
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_CONFLICT_STYLE_MERGE) /= 0
		end

	enable_merge_on_conflict
			-- Enable `must_merge_on_conflict'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_CONFLICT_STYLE_MERGE
						)
					)
		ensure
			Is_Set: must_merge_on_conflict
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	disable_merge_on_conflict
			-- Disable `must_merge_on_conflict'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_CONFLICT_STYLE_MERGE.bit_not
						)
				)
		ensure
			Is_UnSet: not must_merge_on_conflict
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Diff3_On_Conflict_Not_Changed: must_use_diff3_on_conflict = old must_use_diff3_on_conflict
		end

	must_use_diff3_on_conflict:BOOLEAN
			-- Include common ancestor data in diff3 format files for conflicts
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and ({GIT_EXTERNAL}.GIT_CHECKOUT_CONFLICT_STYLE_DIFF3) /= 0
		end

	enable_diff3_on_conflict
			-- Enable `must_use_diff3_on_conflict'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
						{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_or(
								{GIT_EXTERNAL}.GIT_CHECKOUT_CONFLICT_STYLE_DIFF3
						)
					)
		ensure
			Is_Set: must_merge_on_conflict
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
		end

	disable_diff3_on_conflict
			-- Disable `must_use_diff3_on_conflict'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_checkout_strategy(item,
					{GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and(
							{GIT_EXTERNAL}.GIT_CHECKOUT_CONFLICT_STYLE_DIFF3.bit_not
						)
				)
		ensure
			Is_UnSet: not must_merge_on_conflict
			Dry_Run_Not_Changed: is_dry_run = old is_dry_run
			Safe_Not_Changed: is_safe = old is_safe
			Safe_With_Create_Not_Changed: is_safe_with_create = old is_safe_with_create
			Force_Not_Changed: is_force = old is_force
			Update_Allowed_On_Conflict_Not_Change: is_update_allowed_on_conflict = old is_update_allowed_on_conflict
			Remove_Untracked_Files_Not_Changed: must_remove_untracked_files = old must_remove_untracked_files
			Remove_Ignored_Files_Not_Changed: must_remove_ignored_files = old must_remove_ignored_files
			Update_Only_Not_Changed: is_update_only = old is_update_only
			Refresh_Before_Checkout_Not_Changed: must_refresh_before_checkout = old must_refresh_before_checkout
			Update_Index_Not_Changed: must_update_index = old must_update_index
			Unmerge_Files_Trigger_Conflict_Not_Changed: is_unmerge_files_trigger_conflict = old is_unmerge_files_trigger_conflict
			Skip_Unmerge_Files_Not_Changed: must_skip_unmerge_files = old must_skip_unmerge_files
			Use_Our_Files_When_Unmerge_Not_Changed: must_use_our_files_when_unmerge = old must_use_our_files_when_unmerge
			Use_Their_Files_When_Unmerge_Not_Changed: must_use_their_files_when_unmerge = old must_use_their_files_when_unmerge
			Shell_Wildcard_Pattern_Not_Changed: must_use_shell_wildcard_pattern = old must_use_shell_wildcard_pattern
			Overwrite_Ignored_Files_Not_Changed: must_overwrite_ignored_files = old must_overwrite_ignored_files
			Skip_Locked_Directory_Not_Changed: must_skip_locked_directory = old must_skip_locked_directory
			Merge_On_Conflict_Not_Changed: must_merge_on_conflict = old must_merge_on_conflict
		end

	is_filters_enabled:BOOLEAN
			-- Apply filters like CRLF conversion
		require
			Current_Is_Valid: is_valid
		do
			Result := not {GIT_EXTERNAL}.git_checkout_options_get_disable_filters(item)
		end

	enable_filters
			-- Enable `is_filters_enabled'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_disable_filters(item, False)
		ensure
			Is_Enabled: is_filters_enabled
		end

	disable_filters
			-- Disable `is_filters_enabled'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_disable_filters(item, True)
		ensure
			Is_Disabled: not is_filters_enabled
		end

	paths_to_checkout:ARRAYED_LIST[READABLE_STRING_GENERAL]
			-- When not empty, List of shell files patterns (possibly with wildcard) specifying which
			-- paths should be taken into account, otherwise all files. Return only a copy of the
			-- list, not the list itself.
		require
			Current_Is_Valid: is_valid
		local
			l_count, i:INTEGER
			l_c_paths:POINTER
			l_c_string:C_STRING
		do
			l_c_paths := {GIT_EXTERNAL}.git_checkout_options_get_paths_pointer(item)
			if l_c_paths.is_default_pointer then
				create Result.make (0)
			else
				l_count := {GIT_EXTERNAL}.git_strarray_get_count(l_c_paths).to_integer
				create Result.make (l_count)
				from i := 1 until i > l_count loop
					create l_c_string.make_by_pointer ({GIT_EXTERNAL}.git_strarray_get_string_i (l_c_paths, i - 1))
					Result.extend(l_c_string.string)
					i := i + 1
				end
			end
		end

	set_paths_to_checkout(a_paths_to_checkout:FINITE[READABLE_STRING_GENERAL])
			-- Assign `paths_to_checkout' with the values in `a_paths_to_checkout'
		require
			Current_Is_Valid: is_valid
		local
			l_count, i:INTEGER
			l_c_string:C_STRING
			l_c_paths, l_strings_pointer, l_string_pointer:POINTER
			l_list:LINEAR[READABLE_STRING_GENERAL]
		do
			l_c_paths := {GIT_EXTERNAL}.git_checkout_options_get_paths_pointer(item)
			if l_c_paths.is_default_pointer then
				check False end
			else
				{GIT_EXTERNAL}.git_strarray_free(l_c_paths)
				l_count := a_paths_to_checkout.count
				{GIT_EXTERNAL}.git_strarray_set_count(l_c_paths, l_count)
				l_strings_pointer := l_strings_pointer.memory_calloc (l_count, {GIT_EXTERNAL}.sizeof_pointer)
				{GIT_EXTERNAL}.git_strarray_set_strings(l_c_paths, l_strings_pointer)
				from
					i := 1
					l_list := a_paths_to_checkout.linear_representation
					l_list.start
				until
					l_list.exhausted
				loop
					create l_c_string.make (l_list.item)
					l_string_pointer := l_string_pointer.memory_calloc (l_c_string.managed_data.count,1)
					l_string_pointer.memory_copy (l_c_string.managed_data.item, l_c_string.managed_data.count)
					{GIT_EXTERNAL}.git_strarray_set_string_i(l_c_paths, i - 1, l_string_pointer)
					l_list.forth
					i := i + 1
				end
			end
		end

	target_directory:detachable READABLE_STRING_GENERAL assign set_target_directory
			-- Alternative checkout path to workdir or Void for default
		require
			Current_Is_Valid: is_valid
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_checkout_options_get_target_directory(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_target_directory(a_target_directory:detachable READABLE_STRING_GENERAL)
			-- Assign `a_target_directory' to `target_directory'
		require
			Current_Is_Valid: is_valid
		local
			l_c_string:C_STRING
		do
			if attached a_target_directory then
				create l_c_string.make (a_target_directory)
				{GIT_EXTERNAL}.git_checkout_options_set_target_directory(item, l_c_string.item)
				internal_target_directory := l_c_string
			else
				{GIT_EXTERNAL}.git_checkout_options_set_target_directory(item, create {POINTER})
				internal_target_directory := Void
			end
		ensure
			Is_Assign: a_target_directory ~ target_directory
		end

	ancestor_label:detachable READABLE_STRING_GENERAL assign set_ancestor_label
			-- the name of the common ancestor side of conflicts
		require
			Current_Is_Valid: is_valid
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_checkout_options_get_ancestor_label(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_ancestor_label(a_ancestor_label:detachable READABLE_STRING_GENERAL)
			-- Assign `a_ancestor_label' to `ancestor_label'
		require
			Current_Is_Valid: is_valid
		local
			l_c_string:C_STRING
		do
			if attached a_ancestor_label then
				create l_c_string.make (a_ancestor_label)
				{GIT_EXTERNAL}.git_checkout_options_set_ancestor_label(item, l_c_string.item)
				internal_ancestor_label := l_c_string
			else
				{GIT_EXTERNAL}.git_checkout_options_set_ancestor_label(item, create {POINTER})
				internal_ancestor_label := Void
			end
		ensure
			Is_Assign: a_ancestor_label ~ ancestor_label
		end

	our_label:detachable READABLE_STRING_GENERAL assign set_our_label
			-- the name of the "our" side of conflicts
		require
			Current_Is_Valid: is_valid
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_checkout_options_get_our_label(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_our_label(a_our_label:detachable READABLE_STRING_GENERAL)
			-- Assign `a_our_label' to `our_label'
		require
			Current_Is_Valid: is_valid
		local
			l_c_string:C_STRING
		do
			if attached a_our_label then
				create l_c_string.make (a_our_label)
				{GIT_EXTERNAL}.git_checkout_options_set_our_label(item, l_c_string.item)
				internal_our_label := l_c_string
			else
				{GIT_EXTERNAL}.git_checkout_options_set_our_label(item, create {POINTER})
				internal_our_label := Void
			end
		ensure
			Is_Assign: a_our_label ~ our_label
		end

	their_label:detachable READABLE_STRING_GENERAL assign set_their_label
			-- the name of the "their" side of conflicts
		require
			Current_Is_Valid: is_valid
		local
			l_pointer:POINTER
		do
			l_pointer := {GIT_EXTERNAL}.git_checkout_options_get_their_label(item)
			if l_pointer.is_default_pointer then
				Result := Void
			else
				Result := (create {C_STRING}.make_by_pointer (l_pointer)).string
			end
		end

	set_their_label(a_their_label:detachable READABLE_STRING_GENERAL)
			-- Assign `a_their_label' to `their_label'
		require
			Current_Is_Valid: is_valid
		local
			l_c_string:C_STRING
		do
			if attached a_their_label then
				create l_c_string.make (a_their_label)
				{GIT_EXTERNAL}.git_checkout_options_set_their_label(item, l_c_string.item)
				internal_their_label := l_c_string
			else
				{GIT_EXTERNAL}.git_checkout_options_set_their_label(item, create {POINTER})
				internal_their_label := Void
			end
		ensure
			Is_Assign: a_their_label ~ their_label
		end

	directory_mode:NATURAL assign set_directory_mode
			-- The checkout directory file mode (in unix convention)
			-- If 0, will use 0755
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_dir_mode(item)
		end

	set_directory_mode(a_directory_mode:NATURAL)
			-- Assign `directory_mode' with the value of `a_directory_mode'
		require
			Current_Is_Valid: is_valid
			Mode_Is_Valid: is_mode_valid(a_directory_mode)
		do
			{GIT_EXTERNAL}.git_checkout_options_set_dir_mode(item, a_directory_mode)
		ensure
			Is_Set: directory_mode = a_directory_mode
		end

	file_mode:NATURAL assign set_file_mode
			-- The checkout file mode (in unix convention)
			-- If 0, will use the blob file mode (or 0644 if not specified)
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_dir_mode(item)
		end

	set_file_mode(a_file_mode:NATURAL)
			-- Assign `file_mode' with the value of `a_file_mode'
		require
			Current_Is_Valid: is_valid
			Mode_Is_Valid: is_mode_valid(a_file_mode)
		do
			{GIT_EXTERNAL}.git_checkout_options_set_file_mode(item, a_file_mode)
		ensure
			Is_Set: file_mode = a_file_mode
		end

	file_open_flags:INTEGER assign set_file_open_flags
			-- Flags used when opening files during the checkout.
			-- The flags are set by ORing the {GIT_EXTERNAL}.O_* values
			-- See: oflag of http://pubs.opengroup.org/onlinepubs/007908799/xsh/open.html
			-- If null, will used {GIT_EXTERNAL}.`O_CREAT' | {GIT_EXTERNAL}.`O_TRUNC' | {GIT_EXTERNAL}.`O_WRONLY'
		note
			ToDo: "Creating a class to manage those flags."
		require
			Current_Is_Valid: is_valid
		do
			Result := {GIT_EXTERNAL}.git_checkout_options_get_file_open_flags(item)
		end

	set_file_open_flags(a_file_open_flags:INTEGER)
			-- Assign `file_open_flags' with the value of `a_file_open_flags'
		require
			Current_Is_Valid: is_valid
		do
			{GIT_EXTERNAL}.git_checkout_options_set_file_open_flags(item, a_file_open_flags)
		end

	is_mode_valid(a_mode:NATURAL):BOOLEAN
			-- `True' if `a_mode' represent a valide file mode (in unix convention)
		do
			Result := 	((a_mode \\ 10) < 8) and (((a_mode // 10) \\ 10) < 8) and
						(((a_mode // 100) \\ 10) < 8) and (((a_mode // 1000) \\ 10) < 8) and
						(a_mode <= 7777)
		end

	is_valid:BOOLEAN
			-- Is `Current' in a valid (usable) state
		do
			Result := not item.is_default_pointer
		end

	error:GIT_ERROR
			-- The last error that has append in the internal library when managing `Current'

	progress_action:ACTION_SEQUENCE[TUPLE[path:READABLE_STRING_GENERAL; current_transfer, total_transfer:INTEGER_64]]
			-- Actions performed when progress informations are available.

feature {GIT_REPOSITORY, GIT_CLONE_OPTIONS} -- Implementation

	start_callback
			-- Must be used to activate the `progress_action' feature (before a checkout)
			-- After the checkout, the procedure `stop_callback' must be called.
		require
			Current_Is_Valid: is_valid
		do
			if not progress_action.is_empty then
				{GIT_EXTERNAL}.git_checkout_start (Current, item)
				is_callback_initialize := True
			end
		end

	stop_callback
			-- Desactivate the `progress_action' feature.
			-- Must be used after the checkout. If it is not, a memory leak could
			-- happend.
		do
			if is_callback_initialize then
				{GIT_EXTERNAL}.git_checkout_stop (item)
				is_callback_initialize := False
			end
		end

	is_callback_initialize:BOOLEAN
			-- Is `progress_action' feature initialized.

feature {GIT_CLONE_OPTIONS} -- Implementation

	set_parent_clone_options(a_clone_options:GIT_CLONE_OPTIONS)
			-- Assign `parent_clone_options' with the value of `a_clone_options'
		do
			parent_clone_options := a_clone_options
		end

	parent_clone_options: detachable GIT_CLONE_OPTIONS
			-- If the `Current' is include in a {GIT_CLONE_OPTIONS}.`checkout_options'
			-- this feature protect the parent {GIT_CLONE_OPTIONS} from being
			-- collected if `Current' is still in use.

feature {NONE} -- implementation

	progress(a_path_pointer:POINTER; a_current_transfer, a_total_transfer:INTEGER_64)
			-- Receive the checkout informations from the C callback functions.
			-- The informations are the file that is processed in `a_path_pointer'
			-- the number of this file in `a_current_transfer' on a total
			-- of `a_total_transfer' files.
		local
			l_path:READABLE_STRING_GENERAL
		do
			if a_path_pointer.is_default_pointer then
				l_path := ""
			else
				l_path := (create {C_STRING}.make_by_pointer (a_path_pointer)).string
			end
			progress_action.call ([l_path, a_current_transfer, a_total_transfer])
		end

	structure_size:INTEGER
			-- <Precursor>
		do
			Result := {GIT_EXTERNAL}.sizeof_git_checkout_options
		end

	no_base_strategy:NATURAL
			-- Get the strategy_flags containing all preceding option but not the base ones (dry_run, safe, safe_create and force)
		require
			Current_Is_Valid: is_valid
		local
			l_no_base_strategy_flags:NATURAL
		do
			l_no_base_strategy_flags := {GIT_EXTERNAL}.GIT_CHECKOUT_NONE.bit_or (
											{GIT_EXTERNAL}.GIT_CHECKOUT_SAFE.bit_or (
											{GIT_EXTERNAL}.GIT_CHECKOUT_SAFE_CREATE.bit_or (
											{GIT_EXTERNAL}.GIT_CHECKOUT_FORCE
											))).bit_not
			Result := {GIT_EXTERNAL}.git_checkout_options_get_checkout_strategy(item).bit_and (l_no_base_strategy_flags)
		end

	internal_target_directory:detachable C_STRING
			-- To protect the C string assign to `target_directory' internal struture
			-- from being collected.

	internal_ancestor_label:detachable C_STRING
			-- To protect the C string assign to `ancestor_label' internal struture
			-- from being collected.

	internal_our_label:detachable C_STRING
			-- To protect the C string assign to `our_label' internal struture
			-- from being collected.

	internal_their_label:detachable C_STRING
			-- To protect the C string assign to `their_label' internal struture
			-- from being collected.

invariant
	Directory_Mode_Is_Valid: is_mode_valid(directory_mode)
end
