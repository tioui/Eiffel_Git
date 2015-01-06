note
	description: "Options to use when a clone is performed."
	author: "Louis Marchand"
	date: "2015, january 3"
	revision: "0."

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
			create checkout_options.make_from_clone_option ({GIT_EXTERNAL}.git_clone_options_get_checkout_opts(item), Current)
			create error
			create progress_action
			is_callback_initialize := False
			error.set_code (l_error)
		end

feature -- Access

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

end
