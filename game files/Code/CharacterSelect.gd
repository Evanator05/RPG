extends Control

func _ready():
	addCharactersToList()

func addCharactersToList():
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
	var _scene = get_tree().change_scene("res://Level.tscn")

func seperateByCapital(text): #seperate words based on capitals example "HelloWorld" -> "hello world"
	while true: 
		for i in text.length(): #iterate on every letter in the word/sentence
			if text[i] != " ": #if the letter is not a space
				if text[i] == text[i].to_upper(): #if the letter is capitalized
					text[i] = text[i].to_lower()
					if text[i-1] != " ": #if the letter before is not a space
						text = text.insert(i, " ") #add a space
					break
						
		if text == text.to_lower():
			break
			
	if text[0] == " ": #if the first letter is a space
		text[0] = text[0].replace(" ", "") # remove the space
		
	return text


func _on_newCharacter_pressed():
	var _scene = get_tree().change_scene("res://Scenes/Menus/MakeCharacter.tscn")
