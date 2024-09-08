class_name WD extends Object

# Message BUS
static var grid_click: Signal = new_static_signal("grid_click")

static var static_signal_id: int = 0

static func new_static_signal(name: StringName) -> Signal:
	var signal_name: String = "StaticSignal-%s-%s" % [static_signal_id, name]
	var owner_class := (WD as Object)
	owner_class.add_user_signal(signal_name)
	static_signal_id += 1
	return Signal(owner_class, signal_name)

# Scene Controller
static var levelNameLast: String = "None"
static var levelNameCurrent: String = "Main"
static var encounterNameLast: String = "None"
static var encounterNameCurrent: String = "None"

static func start_level(path: String):
	levelNameLast = levelNameCurrent
	levelNameCurrent = path
	Engine.get_main_loop().change_scene_to_file(path)

static func start_encounter(path: String):
	encounterNameLast = encounterNameCurrent
	encounterNameCurrent = path
	Engine.get_main_loop().change_scene_to_file(path)

static func end_encounter():
	encounterNameLast = encounterNameCurrent
	encounterNameCurrent = "None"
	Engine.get_main_loop().change_scene_to_file(levelNameCurrent)

# Filesystem Methods
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
