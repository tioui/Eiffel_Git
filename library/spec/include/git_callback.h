#ifndef INCLUDE_eiffel_git_callback_h__
#define INCLUDE_eiffel_git_callback_h__

#include <git2.h>
#include "eif_plug.h"
#include "eif_cecil.h" 
#include "eif_hector.h" 

/**
 * Callback function launch by a fetch (or clone)
 * command.
 *
 * @param stats Progress informations
 * @param payload A reference to an Eiffel Object to relay callback
 *
 * @return 0 for no error, a negative value if an error occured
 */
int git_fetch_progress(const git_transfer_progress * stats, void * payload);

/**
 * Callback function launch by a checkout
 *
 * @param path The path name of the object that is being transfered
 * @param cur The index of the currently transfered object
 * @param tot The total number of object to transfer
 * @param payload A reference to an Eiffel Object to relay callback
 */
void git_checkout_progress(const char * path, size_t cur, size_t tot, void * payload);

/**
 * Set the correct value for the clone callback system
 *
 * @param object The Eiffel object that will receive the callback
 * @param options The clone options to set the callback in
 */
void git_clone_start(EIF_OBJECT object, EIF_POINTER options);

/**
 * Set the correct value for the checkout callback system
 *
 * @param object The Eiffel object that will receive the callback
 * @param options The checkout options to set the callback in
 */
void git_checkout_start(EIF_OBJECT object, EIF_POINTER options);

/**
 * Free the values in the clone callback system
 *
 * @param options The clone options to free the callback
 */
void git_clone_stop(EIF_POINTER options);

/**
 * Free the values in the checkout callback system
 *
 * @param options The clone options to free the callback
 */
void git_checkout_stop(EIF_POINTER options);

#endif
