message("Removing downloaded libraries...")
file(REMOVE_RECURSE lib)
file(MAKE_DIRECTORY lib)
message("Done!")
