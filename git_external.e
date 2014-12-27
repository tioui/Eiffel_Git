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

	frozen GIT_EORPHANEDHEAD:INTEGER
			-- HEAD refers to branch with no commits
		external
			"C inline use <git2.h>"
		alias
			"GIT_EORPHANEDHEAD"
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

	frozen GIT_EMERGECONFLICT:INTEGER
			-- Merge conflicts prevented operation
		external
			"C inline use <git2.h>"
		alias
			"GIT_EMERGECONFLICT"
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

end
