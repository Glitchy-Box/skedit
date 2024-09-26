extends TextureRect



var about = "Made with SKEdit v0.1b. Exported in Concept Mode!"
var mode = "C"
var version = "0.1"




# Called when the node enters the scene tree for the first time.
func _ready():
	#self.scale = Vector2(0.75,0.75);
	self.position = (get_viewport_rect().size / 2) - self.size /2;
	
var bloblos = [];
var tracking = [];
var spwn = Vector2(0,0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_undo"):
		bloblos.remove_at(len(bloblos)-1)
		if len(tracking) !=0:
			tracking[len(tracking)-1].position = Vector2(-1000,-1000);
			tracking[len(tracking)-1].queue_free()
			tracking.remove_at(len(tracking)-1)
		


func _on_text_edit_text_changed(): # BG
	var img = Image.new();
	img.load(get_node("../Label/TextEdit").text);
	var imt = ImageTexture.new();
	imt.set_image(img);
	get_node("../TextureRect").texture = imt;


func clickpoints(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed == false:
			if event.button_index==1:
				var bloblo = get_node("bloblo").duplicate();
				bloblo.position = event.position;
				bloblos.append(event.position);
				
				bloblo.get_node("Label").text = str(len(bloblos));
				tracking.append(bloblo);
				get_node("..").add_child(tracking[len(tracking)-1]);
			else:
				spwn = event.position
				get_node("../bloblo2").position = event.position
		


func save():
	var savedata = {
		"title": "MapEditor",
		"desc": about,
		"points": bloblos,
		"Background": get_node("../Label/TextEdit").text,
		"spawn": spwn,
		"mode": mode
	};
	print(savedata)
	var mfile = FileAccess.open(get_node("../Label2/TextEdit").text, FileAccess.WRITE)
	var datstr = JSON.stringify(savedata);
	mfile.store_line(datstr)


func load():
	var mfile = FileAccess.open(get_node("../Label2/TextEdit").text, FileAccess.READ);
	if (mfile != null):
		var datstr = JSON.parse_string(mfile.get_as_text());
		get_node("../Label/TextEdit").text = datstr["Background"];
		var img = Image.new();
		img.load(get_node("../Label/TextEdit").text);
		var imt = ImageTexture.new();
		imt.set_image(img);
		get_node("../TextureRect").texture = imt;
		
		#Place Points
		bloblos = [];
		tracking = [];
		for point in datstr["points"]:
			var bloblo = get_node("bloblo").duplicate();
			"".split(",")
			bloblo.position = Vector2(int(point.split(",")[0]), int(point.split(",")[1]));
			bloblos.append(bloblo.position);
			
			bloblo.get_node("Label").text = str(len(bloblos));
			tracking.append(bloblo);
			get_node("..").add_child(tracking[len(tracking)-1]);
		spwn = Vector2(int(datstr["spawn"].split(",")[0]), int(datstr["spawn"].split(",")[1]));
		get_node("../bloblo2").position = spwn;
	
	
