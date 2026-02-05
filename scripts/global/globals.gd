class_name Global extends Node
enum Result {
	SUCCESS,
	FAILURE,
	NOTHING,
	DUPLICATE
}

func todo(msg := ""):
	assert(false, "TODO: %s" % msg)
