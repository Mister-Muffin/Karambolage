extends HBoxContainer

func _ready() -> void:
	GLOBALS.add_item.connect(_on_add_item)
	# set slot numbers
	var slots := get_children() as Array[Node]
	for i in range(slots.size()):
		slots[i].change_slot_number(i + 1)


func _on_add_item(type: Item.TYPES, texture: Resource) -> void:
	var slots := get_children() as Array[Node]
	slots.filter(func(slot): return slot.itemCount > 0)
	for slot in slots:
		if slot.type == type:
			slot.add_item(type, texture)
			break
