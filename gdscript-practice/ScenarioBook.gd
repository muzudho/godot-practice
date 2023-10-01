# シナリオ・ブック（Scenario Book；台本の本）
# 　大した名前だが、大した機能はない。
extends Node

var scenario_array = [
	# ２３４５６７８９０１２３４５６７８９０
	"""\
	きふわらべ
	「お父ん、知ってたら教えてくれだぜ。
	　エスフェン(SFEN)の 7g7f って何だぜ？
	""",
	"""\
	お父ん
	「あー。７筋の７段目の駒を６段目に
	　突くことだぜ。分かったら　もう寝ろ
	""",
	"""\
	きふわらべ
	「3c3d　って何だぜ？
	""",
	"""\
	お父ん
	「角換わりだろ。
	　もう寝ろ
	""",
	"""\
	きふわらべ
	「お父ん、なんで唐揚げを食べてるんだぜ？
	　ダイエットはどうした？野菜食べろだぜ！
	""",
	"""\
	お父ん
	「元気になりたくて唐揚げを食べるんだぜ
	""",
	# ２３４５６７８９０１２３４５６７８９０
	"""\
	　カロリー計算しようと思ったときもあった
	　上限いっぱいまで食べてしまうので止めた
	""",
]

func get_scenario_array():
	return self.scenario_array

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
