note
	description: "Summary description for {GIT_CLONE_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
		local
			l_error:INTEGER
		do
			make
			l_error := {GIT_EXTERNAL}.git_clone_init_options(item,{GIT_EXTERNAL}.GIT_CLONE_OPTIONS_VERSION)
			create checkout_options.make_by_pointer ({GIT_EXTERNAL}.git_clone_options_get_checkout_opts(item))
			create error
			create progress_action
			{GIT_EXTERNAL}.git_fetch_start (Current, item)
			error.set_code (l_error)
		end

feature -- Access

	error:GIT_ERROR

	checkout_options:GIT_CHECKOUT_OPTIONS

	progress_action:ACTION_SEQUENCE[TUPLE[statistics:GIT_TRANSFERT_PROGRESS]]

feature {NONE} -- implementation

	progress(a_statistics_pointer:POINTER)
		local
			l_statistics:GIT_TRANSFERT_PROGRESS
		do
			create l_statistics.make_by_pointer (a_statistics_pointer)
			progress_action.call ([l_statistics])
		end

	structure_size:INTEGER
		do
			Result := {GIT_EXTERNAL}.sizeof_git_clone_options
		end

end
