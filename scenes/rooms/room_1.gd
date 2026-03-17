extends Node2D

class Transiction:
	var area: Area2D
	var to: PackedScene
	
	func _init(area, to) -> void:
		self.area = area
		self.to = to


var transicitions = [
	Transiction.new($transictioin_right, "res://scenes/rooms/room_2.tscn"),
 	Transiction.new($transictioin_down, "res://scenes/rooms/room_3.tscn")
]
