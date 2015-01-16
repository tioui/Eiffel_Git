#include "git_callback.h"

/**
 * Callback function launch by a fetch (or clone)
 * command.
 *
 * @param stats Progress informations
 * @param payload A reference to an Eiffel Object to relay callback
 *
 * @return 0 for no error, a negative value if an error occured
 */
int git_fetch_progress(
            const git_transfer_progress *stats,
            void *payload)
{
	EIF_OBJECT object = (EIF_OBJECT) payload;
	EIF_PROCEDURE ep;
	EIF_TYPE_ID tid;
	int l_result = 0;
	tid = eif_type(object);
	if (tid != EIF_NO_TYPE){
		ep = eif_procedure ("progress", tid);
		if(ep != NULL){
			(ep) (eif_access(object), stats);	
		}else{
			eif_panic("Cannot see the `progress' procedure in class `GIT_CLONE_OPTIONS'");
			l_result = -1;
		}
	}else{
		eif_panic("Cannot found the class `GIT_CLONE_OPTIONS'");
		l_result = -1;
	}
	return l_result;
}

/**
 * Callback function launch by a checkout
 *
 * @param path The path name of the object that is being transfered
 * @param cur The index of the currently transfered object
 * @param tot The total number of object to transfer
 * @param payload A reference to an Eiffel Object to relay callback
 */
void git_checkout_progress(
            const char *path,
            size_t cur,
            size_t tot,
            void *payload)
{
	EIF_OBJECT object = (EIF_OBJECT) payload;
	EIF_PROCEDURE ep;
	EIF_TYPE_ID tid;
	tid = eif_type(object);
	if (tid != EIF_NO_TYPE){
		ep = eif_procedure ("progress", tid);
		if(ep != NULL){
			(ep) (eif_access(object), path, cur, tot);	
		}else{
			eif_panic("Cannot see the `progress' procedure in class `GIT_CHECKOUT_OPTIONS'");
		}
	}else{
		eif_panic("Cannot found the class `GIT_CHECKOUT_OPTIONS'");
	}
}

/**
 * Set the correct value for the clone callback system
 *
 * @param object The Eiffel object that will receive the callback
 * @param options The clone options to set the callback in
 */
void git_clone_start(EIF_OBJECT object, EIF_POINTER options){
	git_clone_options *opts = (git_clone_options *) options;
	opts->remote_callbacks.transfer_progress = &git_fetch_progress;
	opts->remote_callbacks.payload = eif_adopt(object);
}

/**
 * Set the correct value for the checkout callback system
 *
 * @param object The Eiffel object that will receive the callback
 * @param options The checkout options to set the callback in
 */
void git_checkout_start(EIF_OBJECT object, EIF_POINTER options){
	git_checkout_options *opts = (git_checkout_options*) options;
	opts->progress_cb = &git_checkout_progress;
	opts->progress_payload = eif_adopt(object);
}

/**
 * Free the values in the clone callback system
 *
 * @param options The clone options to free the callback
 */
void git_clone_stop(EIF_POINTER options){
	git_clone_options *opts = (git_clone_options *) options;
	opts->remote_callbacks.transfer_progress = NULL;
	eif_wean(opts->remote_callbacks.payload);
	opts->remote_callbacks.payload = NULL;
}

/**
 * Free the values in the checkout callback system
 *
 * @param options The clone options to free the callback
 */
void git_checkout_stop(EIF_POINTER options){
	git_checkout_options *opts = (git_checkout_options*) options;
	opts->progress_cb = NULL;
	eif_wean(opts->progress_payload);
	opts->progress_payload = NULL;
}

