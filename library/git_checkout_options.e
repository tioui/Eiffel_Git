note
	description: "Options to use when a checkout is performed."
	author: "Louis Marchand"
	date: "2015, january 3"
	revision: "0.1"

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
		end

	make_from_clone_option(a_item:POINTER; a_options:GIT_CLONE_OPTIONS)
			-- Initialization of `Current' when `Current' is include
			-- inside `a_options' and used `a_item' as `item'
		do
			make_by_pointer(a_item)
			parent_clone_options := a_options
			make_common
		end

	make_common
			-- Code that every creator have to called.
		do
			create error
			create progress_action
		end

feature -- Access

	error:GIT_ERROR
			-- The last error that has append in the internal library when managing `Current'

	progress_action:ACTION_SEQUENCE[TUPLE[path:READABLE_STRING_GENERAL; current_transfer, total_transfer:INTEGER_64]]
			-- Actions performed when progress informations are available.

feature {GIT_REPOSITORY, GIT_CLONE_OPTIONS} -- Implementation

	start_callback
			-- Must be used to activate the `progress_action' feature (before a checkout)
			-- After the checkout, the procedure `stop_callback' must be called.
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

	parent_clone_options: detachable GIT_CLONE_OPTIONS
			-- If the `Current' is include in a {GIT_CLONE_OPTIONS}.`checkout_options'
			-- this feature protect the parent {GIT_CLONE_OPTIONS} from being
			-- collected if `Current' is still in use.

	structure_size:INTEGER
			-- <Precursor>
		do
			Result := {GIT_EXTERNAL}.sizeof_git_checkout_options
		end
end
