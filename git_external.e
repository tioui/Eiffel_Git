note
	description: "Summary description for {GIT_EXTERNAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GIT_EXTERNAL

feature -- External functions

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

end
