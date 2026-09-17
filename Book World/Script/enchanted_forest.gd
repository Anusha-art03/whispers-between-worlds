extends Node2D

@onready var player = $Player

@onready var red_flower: Label = $RedFlower
@onready var moonlit_water: Label = $MoonlitWater
@onready var star_fragment: Label = $StarFragment

@onready var gate_portal: ColorRect = $GatePortal

var has_red_flower := false
var has_moonlit_water := false
var has_star_fragment := false

var gate_unlocked := false
var gate_used := false

var pickup_distance := 70.0
var gate_distance := 100.0


func _ready():
	gate_portal.hide()


func _process(_delta):
	if not has_red_flower:
		if player.position.distance_to(red_flower.position) < pickup_distance:
			if Input.is_key_pressed(KEY_E):
				collect_red_flower()

	if not has_moonlit_water:
		if player.position.distance_to(moonlit_water.position) < pickup_distance:
			if Input.is_key_pressed(KEY_E):
				collect_moonlit_water()

	if not has_star_fragment:
		if player.position.distance_to(star_fragment.position) < pickup_distance:
			if Input.is_key_pressed(KEY_E):
				collect_star_fragment()

	if gate_unlocked and not gate_used:
		if player.position.distance_to(gate_portal.position) < gate_distance:
			if Input.is_key_pressed(KEY_E):
				enter_cottage()


func collect_red_flower():
	has_red_flower = true
	red_flower.hide()
	check_all_items()


func collect_moonlit_water():
	has_moonlit_water = true
	moonlit_water.hide()
	check_all_items()


func collect_star_fragment():
	has_star_fragment = true
	star_fragment.hide()
	check_all_items()


func check_all_items():
	if has_red_flower and has_moonlit_water and has_star_fragment:
		unlock_gate()


func unlock_gate():
	gate_unlocked = true
	gate_portal.show()


func enter_cottage():
	gate_used = true

	get_tree().change_scene_to_file(
		"res://Book World/Scene/Cottage.tscn"
	)
