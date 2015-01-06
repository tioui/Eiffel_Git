#ifndef INCLUDE_eiffel_git_callback_h__
#define INCLUDE_eiffel_git_callback_h__

#include <git2.h>
#include "eif_plug.h"
#include "eif_cecil.h" 
#include "eif_hector.h" 

int git_fetch_progress(const git_transfer_progress *, void *);

void git_checkout_progress(const char *, size_t, size_t, void *);

void git_fetch_start(EIF_OBJECT, EIF_POINTER);

void git_checkout_start(EIF_OBJECT, EIF_POINTER);

void git_fetch_stop(EIF_POINTER);

void git_checkout_stop(EIF_POINTER);

#endif
