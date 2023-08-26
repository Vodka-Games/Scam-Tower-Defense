extends Node

var money = 1000
var towers = []

func _ready():
	for i in range(4):
		towers.append(null)

func _process(delta):
	pass

func buy_item(amount):
	if money < amount:
		return false
	else:
		money -= amount
		return true
