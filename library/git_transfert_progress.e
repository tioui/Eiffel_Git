note
	description: "Summary description for {GIT_TRANSFERT_PROGRESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GIT_TRANSFERT_PROGRESS

create
	make_by_pointer

feature {NONE} -- Initialization

	make_by_pointer(a_item:POINTER)
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

	indexed_objects:NATURAL

	received_objects:NATURAL

	local_objects:NATURAL

	total_deltas:NATURAL

	indexed_deltas:NATURAL

	received_bytes:INTEGER_64

end
