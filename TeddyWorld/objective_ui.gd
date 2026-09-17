extends CanvasLayer

var memories_found := 0
const TOTAL_MEMORIES := 3

var objective_panel: Panel
var objective_label: Label


func _ready():
	objective_panel = find_child("ObjectivePanel", true, false)
	objective_label = find_child("ObjectiveLabel", true, false)

	if objective_panel == null:
		push_error("ObjectivePanel not found!")
		return

	if objective_label == null:
		push_error("ObjectiveLabel not found!")
		return

	# Show objective when Teddy World starts
	objective_panel.visible = true
	objective_panel.modulate.a = 1.0

	update_objective()


func collect_memory():
	if memories_found >= TOTAL_MEMORIES:
		return

	memories_found += 1
	update_objective()

	if memories_found == TOTAL_MEMORIES:
		objective_label.text = "OBJECTIVE\n\nAll forgotten memories recovered.\n\nMEMORIES   3 / 3"


func update_objective():
	if objective_label == null:
		return

	objective_label.text = "OBJECTIVE\n\nFind the forgotten memories of Teddy\n\nMEMORIES   %d / %d" % [
		memories_found,
		TOTAL_MEMORIES
	]
