note
	description: "Every external routine to access libgit2 C library"
	author: "Louis Marchand"
	date: "2014, december 26"
	revision: "0.1"

class
	GIT_EXTERNAL

feature -- External tools

	frozen sizeof_pointer:INTEGER
			-- Number of byte of a standard system pointer
		external
			"C inline"
		alias
			"sizeof(void *)"
		end

feature -- External functions <git_callback.h>

	frozen git_checkout_start(object: GIT_CHECKOUT_OPTIONS; options: POINTER)
			-- Initialize the callback of the checkout system
		external
			"C (EIF_OBJECT, EIF_POINTER) | <git_callback.h>"
		alias
			"git_checkout_start"
		end

	frozen git_fetch_start(object: GIT_CLONE_OPTIONS; options: POINTER)
			-- Initialize the callback of the fetch system
		external
			"C (EIF_OBJECT, EIF_POINTER) | <git_callback.h>"
		alias
			"git_fetch_start"
		end

	frozen git_checkout_stop(options: POINTER)
			-- Close the callback of the checkout system
		external
			"C (EIF_POINTER) | <git_callback.h>"
		alias
			"git_checkout_stop"
		end

	frozen git_fetch_stop(options: POINTER)
			-- Close the callback of the fetch system
		external
			"C (EIF_POINTER) | <git_callback.h>"
		alias
			"git_fetch_stop"
		end

feature -- External functions <git2.h>

	frozen git_threads_init:INTEGER
			-- Init the threading system
		external
			"C : int | <git2.h>"
		alias
			"git_threads_init"
		end

	frozen git_threads_shutdown
			-- Shutdown the threading system
		external
			"C | <git2.h>"
		alias
			"git_threads_shutdown"
		end

	frozen git_repository_free(repo:POINTER)
			-- Free a previously allocated repository
		external
			"C (git_repository *) | <git2.h>"
		alias
			"git_repository_free"
		end

	frozen git_repository_init_ext(repo, repo_path, opts:POINTER):INTEGER
			-- Create a new Git repository in the given folder with extended controls.
		external
			"C (git_repository **, const char *, git_repository_init_options *) : int | <git2.h>"
		alias
			"git_repository_init_ext"
		end

	frozen giterr_detach(cpy:POINTER):INTEGER
			-- Get the last error data and clear it.
		external
			"C (git_error *) : int | <git2.h>"
		alias
			"giterr_detach"
		end

	frozen git_repository_path(repo:POINTER):POINTER
			-- Get the path of this repository
		external
			"C (git_repository *) : const char * | <git2.h>"
		alias
			"git_repository_path"
		end

	frozen git_repository_workdir(repo:POINTER):POINTER
			-- Get the path of the working directory for this repository
		external
			"C (git_repository *) : const char * | <git2.h>"
		alias
			"git_repository_workdir"
		end

	frozen git_repository_is_bare(repo:POINTER):BOOLEAN
			-- Check if a repository is bare
		external
			"C (git_repository *) : int | <git2.h>"
		alias
			"git_repository_is_bare"
		end

	frozen git_repository_is_empty(repo:POINTER):INTEGER
			-- Check if a repository is empty
		external
			"C (git_repository *) : int | <git2.h>"
		alias
			"git_repository_is_empty"
		end

	frozen git_repository_is_shallow(repo:POINTER):BOOLEAN
			-- Determine if the repository was a shallow clone
		external
			"C (git_repository *) : int | <git2.h>"
		alias
			"git_repository_is_shallow"
		end

	frozen git_repository_set_workdir(repo, workdir:POINTER; update_gitlink:INTEGER):INTEGER
			-- Set the path to the working directory for this repository
		external
			"C (git_repository *, const char *, int) : int | <git2.h>"
		alias
			"git_repository_set_workdir"
		end

	frozen git_repository_state(repo:POINTER):INTEGER
			-- Determines the status of a git repository
		external
			"C (git_repository *) : int | <git2.h>"
		alias
			"git_repository_state"
		end

	frozen git_repository_state_cleanup(repo:POINTER):INTEGER
			-- Remove all the metadata associated with an ongoing command
		external
			"C (git_repository *) : int | <git2.h>"
		alias
			"git_repository_state_cleanup"
		end

	frozen git_repository_message(out_buf, repo:POINTER):INTEGER
			-- Retrieve git's prepared message
		external
			"C (git_buf *, git_repository *) : int | <git2.h>"
		alias
			"git_repository_message"
		end

	frozen git_buf_free(buffer:POINTER)
			-- Retrieve git's prepared message
		external
			"C (git_buf *)| <git2.h>"
		alias
			"git_buf_free"
		end

	frozen git_repository_message_remove(repo:POINTER):INTEGER
			-- Remove git's prepared message.
		external
			"C (git_repository *) : int | <git2.h>"
		alias
			"git_repository_message_remove"
		end

	frozen git_repository_get_namespace(repo:POINTER):POINTER
			-- Get the currently active namespace for this repository
		external
			"C (git_repository *) : const char * | <git2.h>"
		alias
			"git_repository_get_namespace"
		end

	frozen git_repository_set_namespace(repo, nmspace:POINTER):INTEGER
			-- Sets the active namespace for this Git Repository
		external
			"C (git_repository *, const char *) : int | <git2.h>"
		alias
			"git_repository_set_namespace"
		end

	frozen git_repository_open_ext(repo, path:POINTER; flags:NATURAL; ceiling_dirs:POINTER):INTEGER
			-- Sets the active namespace for this Git Repository
		external
			"C (git_repository **, const char *, unsigned int, const char *) : int | <git2.h>"
		alias
			"git_repository_open_ext"
		end

	frozen git_checkout_init_options(opts:POINTER; version:NATURAL):INTEGER
			-- Initializes a `git_checkout_options` with default values
		external
			"C (git_checkout_options *, unsigned int) : int | <git2.h>"
		alias
			"git_checkout_init_options"
		end

	frozen git_clone_init_options(opts:POINTER; version:NATURAL):INTEGER
			-- Initializes a `git_clone_options` with default values
		external
			"C (git_clone_options *, unsigned int) : int | <git2.h>"
		alias
			"git_clone_init_options"
		end

	frozen git_repository_init_init_options(opts:POINTER; version:NATURAL):INTEGER
			-- Initializes a `git_repository_init_options` with default values
		external
			"C (git_repository_init_options *, unsigned int) : int | <git2.h>"
		alias
			"git_repository_init_init_options"
		end

	frozen git_clone(a_out, url, local_path, options:POINTER):INTEGER
			-- Initializes a `git_repository_init_options` with default values
		external
			"C (git_repository **, const char *, const char *, const git_clone_options *) : int | <git2.h>"
		alias
			"git_clone"
		end

feature -- External structures (git_repository_init_options)

	frozen sizeof_git_repository_init_options: INTEGER
			-- Number of byte of the C structure git_repository_init_options
		external
			"C inline use <git2.h>"
		alias
			"sizeof(git_repository_init_options)"
		end

	frozen git_repository_init_options_set_version (struct: POINTER; the_value: NATURAL)
			-- Assign the version number in `the_value' of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, unsigned int)"
		alias
			"version"
		end

	frozen git_repository_init_options_get_version (struct:POINTER):NATURAL
			-- Retreive the version number of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):unsigned int"
		alias
			"version"
		end


	frozen git_repository_init_options_set_flags (struct: POINTER; the_value: NATURAL_32)
			-- Assign the flags in `the_value' of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, uint32_t)"
		alias
			"flags"
		end

	frozen git_repository_init_options_get_flags (struct:POINTER):NATURAL_32
			-- Retreive the flags of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):uint32_t"
		alias
			"flags"
		end

	frozen git_repository_init_options_set_mode (struct: POINTER; the_value: NATURAL_32)
			-- Assign the mode in `the_value' of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, uint32_t)"
		alias
			"mode"
		end

	frozen git_repository_init_options_get_mode (struct:POINTER):NATURAL_32
			-- Retreive the mode of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):uint32_t"
		alias
			"mode"
		end

	frozen git_repository_init_options_set_workdir_path (struct, the_value: POINTER)
			-- Assign the workdir_path pointed by `the_value' of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, const char *)"
		alias
			"workdir_path"
		end

	frozen git_repository_init_options_get_workdir_path (struct:POINTER):POINTER
			-- Retreive a pointer to the working_path name of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):const char *"
		alias
			"workdir_path"
		end

	frozen git_repository_init_options_set_description (struct, the_value: POINTER)
			-- Assign the description pointed by `the_value' of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, const char *)"
		alias
			"description"
		end

	frozen git_repository_init_options_get_description (struct:POINTER):POINTER
			-- Retreive a pointer to the description of the git_repository_init_options structure
			-- pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):const char *"
		alias
			"description"
		end

	frozen git_repository_init_options_set_template_path (struct, the_value: POINTER)
			-- Assign the template directory path pointed by `the_value' of the
			-- git_repository_init_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, const char *)"
		alias
			"template_path"
		end

	frozen git_repository_init_options_get_template_path (struct:POINTER):POINTER
			-- Retreive a pointer to the template directory path of the
			-- git_repository_init_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):const char *"
		alias
			"template_path"
		end

	frozen git_repository_init_options_set_initial_head (struct, the_value: POINTER)
			-- Assign the initial head branch name pointed by `the_value' of the
			-- git_repository_init_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, const char *)"
		alias
			"initial_head"
		end

	frozen git_repository_init_options_get_initial_head (struct:POINTER):POINTER
			-- Retreive a pointer to the initial head branch name of the
			-- git_repository_init_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):const char *"
		alias
			"initial_head"
		end

	frozen git_repository_init_options_set_origin_url (struct, the_value: POINTER)
			-- Assign the origin remote url pointed by `the_value' of the
			-- git_repository_init_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options, const char *)"
		alias
			"origin_url"
		end

	frozen git_repository_init_options_get_origin_url (struct:POINTER):POINTER
			-- Retreive a pointer to the origin remote url of the
			-- git_repository_init_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_repository_init_options):const char *"
		alias
			"origin_url"
		end

feature -- External structures (git_checkout_options)

	frozen sizeof_git_checkout_options: INTEGER
			-- Number of byte of the C structure git_checkout_options
		external
			"C inline use <git2.h>"
		alias
			"sizeof(git_checkout_options)"
		end

	frozen git_checkout_options_set_version (struct: POINTER; the_value: NATURAL)
			-- Assign `the_value' of the version of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, unsigned int)"
		alias
			"version"
		end

	frozen git_checkout_options_get_version (struct:POINTER):NATURAL
			-- Retreive the value of the version of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):unsigned int"
		alias
			"version"
		end

	frozen git_checkout_options_set_checkout_strategy (struct: POINTER; the_value: NATURAL)
			-- Assign `the_value' of the checkout strategy flags of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, unsigned int)"
		alias
			"checkout_strategy"
		end

	frozen git_checkout_options_get_checkout_strategy (struct:POINTER):NATURAL
			-- Retreive the value of the checkout strategy flags of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):unsigned int"
		alias
			"checkout_strategy"
		end

	frozen git_checkout_options_set_disable_filters (struct: POINTER; the_value: BOOLEAN)
			-- Assign `the_value' of the disable filters boolean of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, int)"
		alias
			"disable_filters"
		end

	frozen git_checkout_options_get_disable_filters (struct:POINTER):BOOLEAN
			-- Retreive the value of the disable filters boolean of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):int"
		alias
			"disable_filters"
		end

	frozen git_checkout_options_set_dir_mode (struct: POINTER; the_value: NATURAL)
			-- Assign `the_value' of the directory mode of the
			-- git_checkout_options structure pointed by the `struct' pointer
			-- default is 0755
		external
			"C [struct <git2.h>] (git_checkout_options, unsigned int)"
		alias
			"dir_mode"
		end

	frozen git_checkout_options_get_dir_mode (struct:POINTER):NATURAL
			-- Retreive the value of the directory mode of the
			-- git_checkout_options structure pointed by the `struct' pointer
			-- default is 0755
		external
			"C [struct <git2.h>] (git_checkout_options):unsigned int"
		alias
			"dir_mode"
		end

	frozen git_checkout_options_set_file_mode (struct: POINTER; the_value: NATURAL)
			-- Assign `the_value' of the file mode of the
			-- git_checkout_options structure pointed by the `struct' pointer
			-- default is 0755
		external
			"C [struct <git2.h>] (git_checkout_options, unsigned int)"
		alias
			"file_mode"
		end

	frozen git_checkout_options_get_file_mode (struct:POINTER):NATURAL
			-- Retreive the value of the file mode of the
			-- git_checkout_options structure pointed by the `struct' pointer
			-- default is 0755
		external
			"C [struct <git2.h>] (git_checkout_options):unsigned int"
		alias
			"file_mode"
		end

	frozen git_checkout_options_set_file_open_flags (struct: POINTER; the_value: INTEGER)
			-- Assign `the_value' of the file open C lib flags of the
			-- git_checkout_options structure pointed by the `struct' pointer
			-- default is O_CREAT | O_TRUNC | O_WRONLY
		external
			"C [struct <git2.h>] (git_checkout_options, int)"
		alias
			"file_open_flags"
		end

	frozen git_checkout_options_get_file_open_flags (struct:POINTER):INTEGER
			-- Retreive the value of the file open C lib flags of the
			-- git_checkout_options structure pointed by the `struct' pointer
			-- default is O_CREAT | O_TRUNC | O_WRONLY
		external
			"C [struct <git2.h>] (git_checkout_options):int"
		alias
			"file_open_flags"
		end

	frozen git_checkout_options_set_notify_flags (struct: POINTER; the_value: NATURAL)
			-- Assign `the_value' of the notification (callback) system flags of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, unsigned int)"
		alias
			"notify_flags"
		end

	frozen git_checkout_options_get_notify_flags (struct:POINTER):NATURAL
			-- Retreive the value of the notification (callback) system flags of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):unsigned int"
		alias
			"notify_flags"
		end

	frozen git_checkout_options_get_paths_pointer (struct:POINTER):POINTER
			-- Retreive the pointer of the paths array of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C inline use <git2.h>"
		alias
			"&(((git_checkout_options *)$struct)->paths)"
		end

	frozen git_checkout_options_set_baseline (struct, the_value: POINTER)
			-- Assign `the_value' of the tree baseline pointer of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, git_tree *)"
		alias
			"baseline"
		end

	frozen git_checkout_options_get_baseline (struct:POINTER):POINTER
			-- Retreive the value of the tree baseline pointer of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):git_tree *"
		alias
			"baseline"
		end

	frozen git_checkout_options_set_target_directory (struct, the_value: POINTER)
			-- Assign `the_value' of the target directory name pointer of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, const char *)"
		alias
			"target_directory"
		end

	frozen git_checkout_options_get_target_directory (struct:POINTER):POINTER
			-- Retreive the value of the target directory name pointer of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):const char *"
		alias
			"target_directory"
		end

	frozen git_checkout_options_set_our_label (struct, the_value: POINTER)
			-- Assign `the_value' of the the name of the "our" side of conflicts of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, const char *)"
		alias
			"our_label"
		end

	frozen git_checkout_options_get_our_label (struct:POINTER):POINTER
			-- Retreive the value of the the name of the "our" side of conflicts of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):const char *"
		alias
			"our_label"
		end

	frozen git_checkout_options_set_their_label (struct, the_value: POINTER)
			-- Assign `the_value' of the the name of the "their" side of conflicts of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options, const char *)"
		alias
			"their_label"
		end

	frozen git_checkout_options_get_their_label (struct:POINTER):POINTER
			-- Retreive the value of the the name of the "their" side of conflicts of the
			-- git_checkout_options structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_checkout_options):const char *"
		alias
			"their_label"
		end

feature -- External structures (git_clone_options)

	frozen sizeof_git_clone_options: INTEGER
			-- Number of byte of the C structure git_clone_options
		external
			"C inline use <git2.h>"
		alias
			"sizeof(git_clone_options)"
		end

	frozen git_clone_options_get_checkout_opts (struct:POINTER):POINTER
			-- Retreive a pointer to the git_checkout_options of the
			-- git_repository_init_options structure pointed by the `struct' pointer
		external
			"C inline use <git2.h>"
		alias
			"&(((git_clone_options *)$struct)->checkout_opts)"
		end

feature -- External structures (git_transfer_options)

	frozen sizeof_git_transfer_progress: INTEGER
			-- Number of byte of the C structure git_transfer_progress
		external
			"C inline use <git2.h>"
		alias
			"sizeof(git_transfer_progress)"
		end

	frozen git_transfer_progress_get_total_objects (struct:POINTER):NATURAL
			-- Retreive the number of object that have to be retreive of the
			-- git_transfer_progress structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_transfer_progress):unsigned int"
		alias
			"total_objects"
		end

	frozen git_transfer_progress_get_indexed_objects (struct:POINTER):NATURAL
			-- Retreive the number of object that have been downloaded and has been
			-- hashed of the git_transfer_progress structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_transfer_progress):unsigned int"
		alias
			"indexed_objects"
		end

	frozen git_transfer_progress_get_received_objects (struct:POINTER):NATURAL
			-- Retreive the number of object that have already been retreived of the
			-- git_transfer_progress structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_transfer_progress):unsigned int"
		alias
			"received_objects"
		end

	frozen git_transfer_progress_get_local_objects (struct:POINTER):NATURAL
			-- Retreive the number of locally-available objects of the
			-- git_transfer_progress structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_transfer_progress):unsigned int"
		alias
			"local_objects"
		end

	frozen git_transfer_progress_get_total_deltas (struct:POINTER):NATURAL
			-- Retreive the total delta value of the
			-- git_transfer_progress structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_transfer_progress):unsigned int"
		alias
			"total_deltas"
		end

	frozen git_transfer_progress_get_indexed_deltas (struct:POINTER):NATURAL
			-- Retreive the number of delta value that has been received and hashed of the
			-- git_transfer_progress structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_transfer_progress):unsigned int"
		alias
			"indexed_deltas"
		end

	frozen git_transfer_progress_get_received_bytes (struct:POINTER):INTEGER_64
			-- Retreive the number of bytes that has been received of the
			-- git_transfer_progress structure pointed by the `struct' pointer
		external
			"C [struct <git2.h>] (git_transfer_progress):size_t"
		alias
			"received_bytes"
		end



feature -- External structures (git_error)

	frozen sizeof_git_error: INTEGER
			-- Number of byte of the C structure git_error
		external
			"C inline use <git2.h>"
		alias
			"sizeof(git_error)"
		end

	frozen git_error_get_message (struct:POINTER):POINTER
			--  Extra details of the error
		external
			"C [struct <git2.h>] (git_error):char *"
		alias
			"message"
		end

	frozen git_error_get_klass (struct:POINTER):INTEGER
			--  Classes code of the error
		external
			"C [struct <git2.h>] (git_error):int"
		alias
			"klass"
		end


feature -- External structures (git_buf)

	frozen sizeof_git_buf: INTEGER
			-- Number of byte of the C structure git_buf
		external
			"C inline use <git2.h>"
		alias
			"sizeof(git_buf)"
		end

	frozen git_buf_get_ptr (struct:POINTER):POINTER
			-- start of the allocated memory
		external
			"C [struct <git2.h>] (git_buf):char *"
		alias
			"ptr"
		end

	frozen git_buf_get_size (struct:POINTER):INTEGER
			-- size (in bytes) of the data that is actually used
		external
			"C [struct <git2.h>] (git_buf):size_t"
		alias
			"size"
		end

	frozen git_buf_get_asize (struct:POINTER):INTEGER
			-- holds the known total amount of allocated memory
		external
			"C [struct <git2.h>] (git_buf):size_t"
		alias
			"asize"
		end

feature -- External structure (git_repository)

	frozen deferencing_git_repository_pointer(repopointer:POINTER):POINTER
			-- Number of byte of a standard system pointer
		external
			"C inline use <git2.h>"
		alias
			"*((git_repository **) $repopointer)"
		end

feature -- External constants

	frozen GIT_OK:INTEGER
			-- No error
		external
			"C inline use <git2.h>"
		alias
			"GIT_OK"
		end

	frozen GIT_ERROR:INTEGER
			-- Generic error
		external
			"C inline use <git2.h>"
		alias
			"GIT_ERROR"
		end

	frozen GIT_ENOTFOUND:INTEGER
			-- Requested object could not be found
		external
			"C inline use <git2.h>"
		alias
			"GIT_ENOTFOUND"
		end

	frozen GIT_EEXISTS:INTEGER
			-- Object exists preventing operation
		external
			"C inline use <git2.h>"
		alias
			"GIT_EEXISTS"
		end

	frozen GIT_EAMBIGUOUS:INTEGER
			-- More than one object matches
		external
			"C inline use <git2.h>"
		alias
			"GIT_EAMBIGUOUS"
		end

	frozen GIT_EBUFS:INTEGER
			-- Output buffer too short to hold data
		external
			"C inline use <git2.h>"
		alias
			"GIT_EBUFS"
		end

	frozen GIT_EUSER:INTEGER
			-- Error returned from a user callback
		external
			"C inline use <git2.h>"
		alias
			"GIT_EUSER"
		end

	frozen GIT_EBAREREPO:INTEGER
			-- Operation not allowed on bare repository
		external
			"C inline use <git2.h>"
		alias
			"GIT_EBAREREPO"
		end

	frozen GIT_EUNBORNBRANCH:INTEGER
			-- HEAD refers to branch with no commits
		external
			"C inline use <git2.h>"
		alias
			"GIT_EUNBORNBRANCH"
		end

	frozen GIT_EUNMERGED:INTEGER
			-- Merge in progress prevented operation
		external
			"C inline use <git2.h>"
		alias
			"GIT_EUNMERGED"
		end

	frozen GIT_ENONFASTFORWARD:INTEGER
			-- Reference was not fast-forwardable
		external
			"C inline use <git2.h>"
		alias
			"GIT_ENONFASTFORWARD"
		end

	frozen GIT_EINVALIDSPEC:INTEGER
			-- Name/ref spec was not in a valid format
		external
			"C inline use <git2.h>"
		alias
			"GIT_EINVALIDSPEC"
		end


	frozen GIT_ELOCKED:INTEGER
			-- Lock file prevented operation
		external
			"C inline use <git2.h>"
		alias
			"GIT_ELOCKED"
		end

	frozen GIT_EMERGECONFLICT:INTEGER
			-- Merge conflicts prevented operation
		external
			"C inline use <git2.h>"
		alias
			"GIT_EMERGECONFLICT"
		end


	frozen GIT_EMODIFIED:INTEGER
			-- Reference value does not match expected
		external
			"C inline use <git2.h>"
		alias
			"GIT_EMODIFIED"
		end

	frozen GIT_PASSTHROUGH:INTEGER
			-- Internal only
		external
			"C inline use <git2.h>"
		alias
			"GIT_PASSTHROUGH"
		end

	frozen GIT_ITEROVER:INTEGER
			-- Signals end of iteration with iterator
		external
			"C inline use <git2.h>"
		alias
			"GIT_ITEROVER"
		end

	frozen GITERR_NONE:INTEGER
			-- Error classes for no error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_NONE"
		end

	frozen GITERR_NOMEMORY:INTEGER
			-- Error classes for no more memory
		external
			"C inline use <git2.h>"
		alias
			"GITERR_NOMEMORY"
		end

	frozen GITERR_OS:INTEGER
			-- Error classes for operating system error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_OS"
		end

	frozen GITERR_INVALID:INTEGER
			-- Error classes for invalid commands
		external
			"C inline use <git2.h>"
		alias
			"GITERR_INVALID"
		end

	frozen GITERR_REFERENCE:INTEGER
			-- Error classes for reference error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_REFERENCE"
		end

	frozen GITERR_ZLIB:INTEGER
			-- Error classes for an error in the zlib library
		external
			"C inline use <git2.h>"
		alias
			"GITERR_ZLIB"
		end

	frozen GITERR_REPOSITORY:INTEGER
			-- Error classes for a repository error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_REPOSITORY"
		end

	frozen GITERR_CONFIG:INTEGER
			-- Error classes for a configuration error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_CONFIG"
		end

	frozen GITERR_REGEX:INTEGER
			-- Error classes for a regular expression error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_REGEX"
		end

	frozen GITERR_ODB:INTEGER
			-- Error classes for an error in object database
		external
			"C inline use <git2.h>"
		alias
			"GITERR_ODB"
		end

	frozen GITERR_INDEX:INTEGER
			-- Error classes for an index error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_INDEX"
		end

	frozen GITERR_OBJECT:INTEGER
			-- Error classes for an object error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_OBJECT"
		end

	frozen GITERR_NET:INTEGER
			-- Error classes for a network error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_NET"
		end

	frozen GITERR_TAG:INTEGER
			-- Error classes for a tag error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_TAG"
		end

	frozen GITERR_TREE:INTEGER
			-- Error classes for a repository tree error
		external
			"C inline use <git2.h>"
		alias
			"GITERR_TREE"
		end

	frozen GITERR_INDEXER:INTEGER
			-- Error classes for an error in the indexer
		external
			"C inline use <git2.h>"
		alias
			"GITERR_INDEXER"
		end

	frozen GITERR_SSL:INTEGER
			-- Error classes for an error in the SSL library
		external
			"C inline use <git2.h>"
		alias
			"GITERR_SSL"
		end

	frozen GITERR_SUBMODULE:INTEGER
			-- Error classes for a submodule
		external
			"C inline use <git2.h>"
		alias
			"GITERR_SUBMODULE"
		end

	frozen GITERR_THREAD:INTEGER
			-- Error classes for an internal thread manipulation
		external
			"C inline use <git2.h>"
		alias
			"GITERR_THREAD"
		end

	frozen GITERR_STASH:INTEGER
			-- Error classes for a change stashing
		external
			"C inline use <git2.h>"
		alias
			"GITERR_STASH"
		end

	frozen GITERR_CHECKOUT:INTEGER
			-- Error classes for an error in a checkout
		external
			"C inline use <git2.h>"
		alias
			"GITERR_CHECKOUT"
		end

	frozen GITERR_FETCHHEAD:INTEGER
			-- Error classes while fetching the head of a repository
		external
			"C inline use <git2.h>"
		alias
			"GITERR_FETCHHEAD"
		end

	frozen GITERR_MERGE:INTEGER
			-- Error classes for an error while merging
		external
			"C inline use <git2.h>"
		alias
			"GITERR_MERGE"
		end

	frozen GITERR_SSH:INTEGER
			-- Error classes for an error in the SSH library
		external
			"C inline use <git2.h>"
		alias
			"GITERR_SSH"
		end

	frozen GITERR_FILTER:INTEGER
			-- Error classes for an error while filtering
		external
			"C inline use <git2.h>"
		alias
			"GITERR_FILTER"
		end

	frozen GITERR_REVERT:INTEGER
			-- Error classes for an error while reverting
		external
			"C inline use <git2.h>"
		alias
			"GITERR_REVERT"
		end

	frozen GITERR_CALLBACK:INTEGER
			-- Error classes for an error while calling callback
		external
			"C inline use <git2.h>"
		alias
			"GITERR_CALLBACK"
		end

	frozen GITERR_CHERRYPICK:INTEGER
			-- Error classes for an error while cherry-picking
		external
			"C inline use <git2.h>"
		alias
			"GITERR_CHERRYPICK"
		end

	frozen GIT_REPOSITORY_INIT_OPTIONS_VERSION:NATURAL
			-- The version of the git repository initialization option
		external
			"C [macro <git2.h>] : unsigned int"
		alias
			"GIT_REPOSITORY_INIT_OPTIONS_VERSION"
		end

	frozen GIT_REPOSITORY_INIT_BARE:NATURAL
			-- Create a bare repository with no working directory
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_BARE"
		end

	frozen GIT_REPOSITORY_INIT_NO_REINIT:NATURAL
			-- Return an GIT_EEXISTS error if the repo_path
			-- appears to already be an git repository
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_NO_REINIT"
		end

	frozen GIT_REPOSITORY_INIT_NO_DOTGIT_DIR:NATURAL
			-- Normally a ".git" will be appended to the repo path
			-- for non-bare repos (if it is not already there), but
			-- passing this flag prevents that behavior.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_NO_DOTGIT_DIR"
		end

	frozen GIT_REPOSITORY_INIT_MKDIR:NATURAL
			-- Make the repo_path (and workdir_path) as needed. Init is
			-- always willing to create the ".git" directory even without this
			-- flag. This flag tells init to create the trailing component of
			-- the repo and workdir paths as needed.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_MKDIR"
		end

	frozen GIT_REPOSITORY_INIT_MKPATH:NATURAL
			-- Recursively make all components of the repo and workdir
			-- paths as necessary.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_MKPATH"
		end

	frozen GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE:NATURAL
			-- libgit2 normally uses internal templates to
			-- initialize a new repo. This flags enables external templates,
			-- looking the "template_path" from the options if set, or the
			-- `init.templatedir` global config if not, or falling back on
			-- "/usr/share/git-core/templates" if it exists.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_EXTERNAL_TEMPLATE"
		end

	frozen GIT_REPOSITORY_INIT_SHARED_UMASK:NATURAL
			-- Use permissions configured by umask - the default.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_SHARED_UMASK"
		end

	frozen GIT_REPOSITORY_INIT_SHARED_GROUP:NATURAL
			-- Use "--shared=group" behavior, chmod'ing the new repo
			-- to be group writable and "g+sx" for sticky group assignment.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_SHARED_GROUP"
		end

	frozen GIT_REPOSITORY_INIT_SHARED_ALL:NATURAL
			-- Use "--shared=all" behavior, adding world readability.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_INIT_SHARED_ALL"
		end

	frozen GIT_REPOSITORY_STATE_NONE:INTEGER
			-- No operation in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_NONE"
		end

	frozen GIT_REPOSITORY_STATE_MERGE:INTEGER
			-- A merge in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_MERGE"
		end

	frozen GIT_REPOSITORY_STATE_REVERT:INTEGER
			-- A revert in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_REVERT"
		end

	frozen GIT_REPOSITORY_STATE_CHERRY_PICK:INTEGER
			-- A cherry pick in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_CHERRY_PICK"
		end

	frozen GIT_REPOSITORY_STATE_BISECT:INTEGER
			-- A bisect command in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_BISECT"
		end

	frozen GIT_REPOSITORY_STATE_REBASE:INTEGER
			-- A rebase command in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_REBASE"
		end

	frozen GIT_REPOSITORY_STATE_REBASE_INTERACTIVE:INTEGER
			-- An interactive rebase in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_REBASE_INTERACTIVE"
		end

	frozen GIT_REPOSITORY_STATE_REBASE_MERGE:INTEGER
			-- A rebase merge in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_REBASE_MERGE"
		end

	frozen GIT_REPOSITORY_STATE_APPLY_MAILBOX:INTEGER
			-- An apply mailbox in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_APPLY_MAILBOX"
		end

	frozen GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE:INTEGER
			-- An apply mailbox in progress
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_STATE_APPLY_MAILBOX_OR_REBASE"
		end

	frozen GIT_REPOSITORY_OPEN_NO_SEARCH:NATURAL
			-- Only open the repository if it can be immediately found
			-- in the given path. Do not walk up from the path looking
			-- at parent directories.
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_OPEN_NO_SEARCH"
		end

	frozen GIT_REPOSITORY_OPEN_CROSS_FS:NATURAL
			-- Unless this flag is set, open will not
			-- continue searching across filesystem boundaries
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_OPEN_CROSS_FS"
		end

	frozen GIT_REPOSITORY_OPEN_BARE:NATURAL
			-- Open repository as a bare repo regardless of core.bare config
		external
			"C inline use <git2.h>"
		alias
			"GIT_REPOSITORY_OPEN_BARE"
		end

	frozen GIT_PATH_LIST_SEPARATOR:CHARACTER
			-- The separator used in path list strings
		external
			"C inline use <git2.h>"
		alias
			"GIT_PATH_LIST_SEPARATOR"
		end

	frozen GIT_CHECKOUT_OPTIONS_VERSION:NATURAL
			-- The version of the latest `git_checkout_options' structure
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_OPTIONS_VERSION"
		end

	frozen GIT_CLONE_OPTIONS_VERSION:NATURAL
			-- The version of the latest `git_clone_options' structure
		external
			"C inline use <git2.h>"
		alias
			"GIT_CLONE_OPTIONS_VERSION"
		end

	frozen GIT_CHECKOUT_NONE:NATURAL
			-- default is a dry run, no actual updates
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_NONE"
		end

	frozen GIT_CHECKOUT_SAFE:NATURAL
			-- Allow safe updates that cannot overwrite uncommitted data
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_SAFE"
		end

	frozen GIT_CHECKOUT_SAFE_CREATE:NATURAL
			-- Allow safe updates plus creation of missing files
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_SAFE_CREATE"
		end

	frozen GIT_CHECKOUT_FORCE:NATURAL
			-- Allow all updates to force working directory to look like index
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_FORCE"
		end

	frozen GIT_CHECKOUT_ALLOW_CONFLICTS:NATURAL
			-- Allow checkout to make safe updates even if conflicts are found
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_ALLOW_CONFLICTS"
		end

	frozen GIT_CHECKOUT_REMOVE_UNTRACKED:NATURAL
			-- Remove untracked files not in index (that are not ignored)
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_REMOVE_UNTRACKED"
		end

	frozen GIT_CHECKOUT_REMOVE_IGNORED:NATURAL
			-- Remove ignored files not in index
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_REMOVE_IGNORED"
		end

	frozen GIT_CHECKOUT_UPDATE_ONLY:NATURAL
			-- Only update existing files, don't create new ones
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_UPDATE_ONLY"
		end

	frozen GIT_CHECKOUT_DONT_UPDATE_INDEX:NATURAL
			-- Normally checkout updates index entries as it goes; this stops that
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_DONT_UPDATE_INDEX"
		end

	frozen GIT_CHECKOUT_NO_REFRESH:NATURAL
			-- Don't refresh index/config/etc before doing checkout
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_NO_REFRESH"
		end

	frozen GIT_CHECKOUT_SKIP_UNMERGED:NATURAL
			-- Allow checkout to skip unmerged files
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_SKIP_UNMERGED"
		end

	frozen GIT_CHECKOUT_USE_OURS:NATURAL
			-- For unmerged files, checkout stage 2 from index
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_USE_OURS"
		end

	frozen GIT_CHECKOUT_USE_THEIRS:NATURAL
			-- For unmerged files, checkout stage 3 from index
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_USE_THEIRS"
		end

	frozen GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH:NATURAL
			-- Treat pathspec as simple list of exact match file paths
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH"
		end

	frozen GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES:NATURAL
			-- Ignore directories in use, they will be left empty
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES"
		end

	frozen GIT_CHECKOUT_DONT_OVERWRITE_IGNORED:NATURAL
			-- Don't overwrite ignored files that exist in the checkout target
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_DONT_OVERWRITE_IGNORED"
		end

	frozen GIT_CHECKOUT_CONFLICT_STYLE_MERGE:NATURAL
			--  Write normal merge files for conflicts
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_CONFLICT_STYLE_MERGE"
		end

	frozen GIT_CHECKOUT_CONFLICT_STYLE_DIFF3:NATURAL
			--  Include common ancestor data in diff3 format files for conflicts
		external
			"C inline use <git2.h>"
		alias
			"GIT_CHECKOUT_CONFLICT_STYLE_DIFF3"
		end

end
