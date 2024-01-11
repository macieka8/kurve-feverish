extends Label

@onready var score: Score = %Score

func _ready() -> void:
	text = str(score.max_score)
	score.score_ready.connect(_on_score_ready)

func _on_score_ready() -> void:
	text = str(score.max_score)
