extends Node2D

var _column = 1
var _row = 1

#5757 lines
var words = "res://words.txt"

var _cur_word
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var _rand_index = randi() % 5756
	var f = File.new()
	f.open(words, File.READ)
	for _i in range(0, _rand_index):
		f.get_line()
	_cur_word = f.get_line().to_upper()

func _check_square_correct(_c):
	var panel = get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(_c))
	if (panel.get_child(0).text == _cur_word[_c - 1]):
		panel.modulate = Color(0.4, 1, 0.4)
		if(get_node_or_null("ViewportContainer/Keyboard/TopRows/" + panel.get_child(0).text) != null):
			get_node("ViewportContainer/Keyboard/TopRows/" + panel.get_child(0).text).modulate = Color(0.4, 1, 0.4)
		else:
			get_node("ViewportContainer/Keyboard/BottomRow/" + panel.get_child(0).text).modulate = Color(0.4, 1, 0.4)
	elif (panel.get_child(0).text in _cur_word):
		panel.modulate = Color(1, 1, 0.4)
		if(get_node_or_null("ViewportContainer/Keyboard/TopRows/" + panel.get_child(0).text) != null && get_node("ViewportContainer/Keyboard/TopRows/" + panel.get_child(0).text).modulate == Color(1, 1, 1)):
			get_node("ViewportContainer/Keyboard/TopRows/" + panel.get_child(0).text).modulate = Color(1, 1, 0.4)
		elif (get_node("ViewportContainer/Keyboard/BottomRow/" + panel.get_child(0).text).modulate == Color(1, 1, 1)):
			get_node("ViewportContainer/Keyboard/BottomRow/" + panel.get_child(0).text).modulate = Color(1, 1, 0.4)
	else:
		panel.modulate = Color(0.4, 0.4, 0.4)
		if(get_node_or_null("ViewportContainer/Keyboard/TopRows/" + panel.get_child(0).text) != null):
			get_node("ViewportContainer/Keyboard/TopRows/" + panel.get_child(0).text).modulate = Color(0.4, 0.4, 0.4)
		else:
			get_node("ViewportContainer/Keyboard/BottomRow/" + panel.get_child(0).text).modulate = Color(0.4, 0.4, 0.4)

func _remove_letter():
	if _column > 1:
		_column -= 1
		get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(_column)).get_child(0).text = ""

func _submit():
	if (get_node("ViewportContainer/InputFields/" + str(_row) + ", 5").get_child(0).text != ""):
		var inp = get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(1)).get_child(0).text + get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(2)).get_child(0).text + get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(3)).get_child(0).text + get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(4)).get_child(0).text + get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(5)).get_child(0).text
		if (word_listed(inp)):
			_check_square_correct(1)
			_check_square_correct(2)
			_check_square_correct(3)
			_check_square_correct(4)
			_check_square_correct(5)
			_row += 1
			_column = 1
		else:
			error("word \"" + inp + "\" not in word list")
	else:
		error("please enter a 5 letter word")
		
func word_listed(var input):
	input = input.to_lower()
	var f = File.new()
	f.open(words, File.READ)
	for i in range(0, 5757):
		if(input == f.get_line()):
			return true
	return false
	
func error(var msg):
	get_node("ViewportContainer/PopupDialog/Label").text = msg
	get_node("ViewportContainer/PopupDialog").popup()

#keyboard handling
func _on_key_pressed(var c):
	if _column <= 5:
		get_node("ViewportContainer/InputFields/" + str(_row) + ", " + str(_column)).get_child(0).text = c
		_column += 1

func _on_ENTER_pressed():
	_submit()
func _on_DELETE_pressed():
	_remove_letter()

