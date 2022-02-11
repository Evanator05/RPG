extends Control

func _ready():
	print(seperateByCapital("HelloWorld"))
	var characters = Globals.getSaves()
	for c in characters:
		Globals.loadPlayer(c)
		var text = c + "   I   " + Globals.mapIds[Globals.playerMapChunks[0]]
		
		text = seperateByCapital(text)
		
		for i in text.length(): #recapitalize each word
			if text[i-1] == " ":
				text[i] = text[i].to_upper()
		text[0] = text[0].to_upper()
			
		$ItemList.add_item(text)

func _on_ItemList_item_selected(index):
	Globals.playerName = Globals.getSaves()[index]
	get_tree().change_scene("res://Level.tscn")

func seperateByCapital(text): #seperate words based on capitals example "HelloWorld" -> "hello world"
	while true: 
		for i in text.length():
			if text[i] != " ":
				if text[i] == text[i].to_upper():
					text[i] = text[i].to_lower()
					if text[i-1] != " ":
						text = text.insert(i, " ")
					break
						
		if text == text.to_lower():
			break
			
	if text[0] == " ":
		text[0] = text[0].replace(" ", "")
		
	return text
