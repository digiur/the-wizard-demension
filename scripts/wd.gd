class_name WD extends Object

static var levelNameLast: String = "None"
static var levelNameCurrent: String = "Main"
static var encounterNameLast: String = "None"
static var encounterNameCurrent: String = "None"

static func startLevel(path: String):
	levelNameLast = levelNameCurrent
	levelNameCurrent = path
	Engine.get_main_loop().change_scene_to_file(path)

static func startEncounter(path: String):
	encounterNameLast = encounterNameCurrent
	encounterNameCurrent = path
	Engine.get_main_loop().change_scene_to_file(path)

static func endEncounter():
	encounterNameLast = encounterNameCurrent
	encounterNameCurrent = "None"
	Engine.get_main_loop().change_scene_to_file(levelNameCurrent)
	pass

static func process_dir(path: String, method: Callable):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + path + file_name)
			method.call(path, file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
