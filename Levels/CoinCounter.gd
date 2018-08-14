extends Control

var current_amount

func _ready():
	current_amount = 0
	update_text()

func modify(amount):
	current_amount += amount
	update_text()


func update_text():
	$Label.text = String(current_amount)