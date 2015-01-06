#include "git_callback.h"

pthread_t main_thread;

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


void git_fetch_start(EIF_OBJECT object, EIF_POINTER options){
	git_clone_options *opts = (git_clone_options *) options;
	opts->remote_callbacks.transfer_progress = &git_fetch_progress;
	opts->remote_callbacks.payload = eif_adopt(object);
}

void git_checkout_start(EIF_OBJECT object, EIF_POINTER options){
	git_checkout_options *opts = (git_checkout_options*) options;
	opts->progress_cb = &git_checkout_progress;
	opts->progress_payload = eif_adopt(object);
}

void git_fetch_stop(EIF_POINTER options){
	git_clone_options *opts = (git_clone_options *) options;
	opts->remote_callbacks.transfer_progress = NULL;
	eif_wean(opts->remote_callbacks.payload);
	opts->remote_callbacks.payload = NULL;
}

void git_checkout_stop(EIF_POINTER options){
	git_checkout_options *opts = (git_checkout_options*) options;
	opts->progress_cb = NULL;
	eif_wean(opts->progress_payload);
	opts->progress_payload = NULL;
}

