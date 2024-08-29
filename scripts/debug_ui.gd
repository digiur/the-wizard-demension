extends CanvasLayer

@onready var levels_menu: PopupMenu = %LevelsMenu
@export_dir var level_directory_path: String = "res://scenes/levels/"

@onready var encounters_menu: PopupMenu = %EncountersMenu
@export_dir var encounter_directory_path: String = "res://scenes/encounters/"

@onready var last_level_name: Label = %LastLevelName
@onready var level_name: Label = %LevelName
@onready var last_encounter_name: Label = %LastEncounterName
@onready var encounter_name: Label = %EncounterName

var level_scenes: Array[String] = []
var encounter_scenes: Array[String] = []

func _ready() -> void:
	level_name.text = WD.levelNameCurrent
	last_level_name.text = WD.levelNameLast

	encounter_name.text = WD.encounterNameCurrent
	last_encounter_name.text = WD.encounterNameLast

	if WD.encounterNameCurrent == "None":
		WD.process_dir(level_directory_path, self.createLevelPopupMenuItem)

	WD.process_dir(encounter_directory_path, self.createEncounterPopupMenuItem)

	if WD.encounterNameCurrent != "None":
		levels_menu.add_item("End Current Encounter", encounter_scenes.size())

func createLevelPopupMenuItem(path: String, file_name: String):
	levels_menu.add_item(file_name, level_scenes.size())
	level_scenes.append(path + file_name)

func createEncounterPopupMenuItem(path: String, file_name: String):
	encounters_menu.add_item(file_name, encounter_scenes.size())
	encounter_scenes.append(path + file_name)

func _on_levels_menu_id_pressed(i: int) -> void:
	if i == encounter_scenes.size():
		WD.endEncounter()
	else:
		WD.startLevel(level_scenes[i])

func _on_encounters_menu_id_pressed(i: int) -> void:
	WD.startEncounter(encounter_scenes[i])
