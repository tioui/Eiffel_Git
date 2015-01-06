note
	description: "Class used to get the informations about packfile transfert from a remote."
	author: "Louis Marchand"
	date: "2015, january 5"
	revision: "0.1"

class
	GIT_TRANSFERT_PROGRESS

create
	make_by_pointer

feature {NONE} -- Initialization

	make_by_pointer(a_item:POINTER)
			-- Initialization of `Current' using `a_item' as internal C pointer
		require
			Item_Not_Null: not a_item.is_default_pointer
		do
			total_object := {GIT_EXTERNAL}.git_transfer_progress_get_total_objects(a_item)
			indexed_objects := {GIT_EXTERNAL}.git_transfer_progress_get_indexed_objects(a_item)
			received_objects := {GIT_EXTERNAL}.git_transfer_progress_get_received_objects(a_item)
			local_objects := {GIT_EXTERNAL}.git_transfer_progress_get_local_objects(a_item)
			total_deltas := {GIT_EXTERNAL}.git_transfer_progress_get_total_deltas(a_item)
			indexed_deltas := {GIT_EXTERNAL}.git_transfer_progress_get_indexed_deltas(a_item)
			received_bytes := {GIT_EXTERNAL}.git_transfer_progress_get_received_bytes(a_item)
		end

feature -- Access

	total_object:NATURAL
			-- Number of objects in the packfile being downloaded

	indexed_objects:NATURAL
			-- Received objects that have been hashed

	received_objects:NATURAL
			-- Objects which have been downloaded

	local_objects:NATURAL
			-- Locally-available objects that have been injected in order to fix a thin pack.

	total_deltas:NATURAL
			-- The number of deltas (diffenrence between objects) in the packfile

	indexed_deltas:NATURAL
			-- The number of deltas (diffenrence between objects) that has been process

	received_bytes:INTEGER_64
			-- Size (in byte) of the packfile received up to now

end
