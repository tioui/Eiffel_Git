#include "git_callback.h"


int git_fetch_progress(
            const git_transfer_progress *stats,
            void *payload)
{
	printf("Enter\n");
	EIF_OBJECT object = (EIF_OBJECT) payload;
	EIF_PROCEDURE ep;
	EIF_TYPE_ID tid;
	int l_result = 0;
	printf("step 1\n");
	tid = eif_type_id ("GIT_CLONE_OPTIONS");
	printf("step 2\n");
	if (tid != EIF_NO_TYPE){
		printf("step 3\n");
		ep = eif_procedure ("progress", tid);
		printf("step 4\n");
		if(ep != NULL){
			printf("step 4.1\n");
			(ep) (eif_access(object), stats);	
			printf("step 5\n");
		}else{
			printf("step 4.2\n");
			eif_panic("Cannot see the `progress' procedure in class `GIT_CLONE_OPTIONS'");
			l_result = -1;
		}
	}else{
		eif_panic("Cannot found the class `GIT_CLONE_OPTIONS'");
		l_result = -1;
	}
	printf("Exit\n");
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
	tid = eif_type_id ("GIT_CHECKOUT_OPTIONS");
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
	opts->remote_callbacks.payload = object;
}

void git_checkout_start(EIF_OBJECT object, EIF_POINTER options){
	git_checkout_options *opts = (git_checkout_options*) options;
	opts->progress_cb = &git_checkout_progress;
	opts->progress_payload = object;
}



