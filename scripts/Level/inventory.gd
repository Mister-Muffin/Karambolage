extends HBoxContainer

func _ready() -> void:
	GLOBALS.add_item.connect(_on_add_item)
	# set slot numbers
	var slots := get_children() as Array[Node]
	for i in range(slots.size()):
		slots[i].change_slot_number(i + 1)


func _on_add_item(type: Item.TYPES, texture: Resource) -> void:
	var slots := get_children() as Array[Node]
	# find used slot with specific item type that is not empty
	var filteredSlots = slots.filter(func(slot): return slot.type == type and slot.itemCount > 0)
	print(slots)
	for slot in filteredSlots:
		slot.add_item(type, texture)
		return

	# if no slot was already occupied by the specifiy item
	# loop over all empty and insert into the first one
	for slot in slots:
		if slot.itemCount == 0:
			slot.add_item(type, texture)
			break
