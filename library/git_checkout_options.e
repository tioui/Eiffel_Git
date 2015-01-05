note
	description: "Summary description for {GIT_CHECKOUT_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

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
			default_create,
			make_by_pointer
		end

create
	default_create,
	make_by_pointer

feature {NONE} -- Initialization

	default_create
		local
			l_error:INTEGER
		do
			make
			l_error := {GIT_EXTERNAL}.git_checkout_init_options(item,{GIT_EXTERNAL}.GIT_CHECKOUT_OPTIONS_VERSION)
			make_common
			error.set_code (l_error)
		end

	make_by_pointer(a_item:POINTER)
		do
			Precursor {MEMORY_STRUCTURE}(a_item)
			make_common
		end

	make_common
		do
			create error
			create progress_action
			{GIT_EXTERNAL}.git_checkout_start (Current, item)
		end

feature -- Access

	error:GIT_ERROR

	progress_action:ACTION_SEQUENCE[TUPLE[path:READABLE_STRING_GENERAL; current_transfer, total_transfer:INTEGER_64]]

feature {NONE} -- implementation

	progress(a_path_pointer:POINTER; current_transfer, total_transfer:INTEGER_64)
		local
			l_path:READABLE_STRING_GENERAL
		do
			if a_path_pointer.is_default_pointer then
				l_path := ""
			else
				l_path := (create {C_STRING}.make_by_pointer (a_path_pointer)).string
			end
			progress_action.call ([l_path, current_transfer, total_transfer])
		end

	structure_size:INTEGER
		do
			Result := {GIT_EXTERNAL}.sizeof_git_checkout_options
		end
end
