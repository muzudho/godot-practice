# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return $"../../../Director"


# シナリオライター取得
func get_scenario_writer():
	return self.get_director().get_node("📂ScenarioWriter")


# シナリオ・リーダー取得
func get_scenario_reader():
	return self.get_scenario_writer().get_node("System/Reader")


# BGM取得
func get_bgm():
	return self.get_director().get_node("📂Musician_BGM")


# 効果音取得
func get_se():
	return self.get_director().get_node("📂Musician_SE")


# 背景アーティスト
func get_background_artist():
	return self.get_director().get_node("📂BackgroundArtist")


# イラストレーター取得
func get_illustrator():
	return self.get_director().get_node("📂Illustrator")


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return self.get_director().get_node("📂TelopCoordinator")


# モンスターの全身像
func get_monster_whole_body():
	return self.get_director().get_node("MonsterTrainer/WholeBody")


# モンスター・フェースズ
func get_monster_faces():
	return self.get_director().get_node("MonsterTrainer/Faces")


# 命令ノード取得
func get_instruction(instruction_name):
	return $"../🍱Instructions_🍉KifuwarabeVisualNovel".get_node(instruction_name)



# ーーーーーーーー
# その他
# ーーーーーーーー


# 変数展開する
# `target_before_change` - １行かもしれないし、段落かもしれないし、匿名関数かもしれない
func expand_variables(target_before_change):
	
	target_before_change = target_before_change.strip_edges()
		
	if target_before_change is String:
		# ここで `{{banana}} などの引数を　変数展開したい
		
		# 無限に変数展開することを防ぐため、変換前文字列と、変換後文字列は別途用意する
		var terget_after_change = ""
				
		var from = 0
		
		while from < target_before_change.length():
			var open_index = target_before_change.find("{{", from)
			var close_index = target_before_change.find("}}", from)
			
			if from <= open_index and open_index + 2 < close_index:

				# Head
				terget_after_change += target_before_change.substr(from, open_index - from)

				# 変数名取得
				var key = target_before_change.substr(open_index + 2, close_index - (open_index + 2))
				print("［助監　変数展開］　変数キー：［" + key + "］")
				
				if key in self.get_director().stage_directions_variables:
					var value = self.get_director().stage_directions_variables[key]
					print("［助監　変数展開］　変数値：［" + value + "］")
				
					terget_after_change += value
				
				else:
					print("［助監　変数展開］　変数値が見つかりません")
					
					# 仕方ないので、カッコ悪いが、キー（ハンドルバー）を画面に表示する
					terget_after_change += "{{" + key + "}}"

				from = close_index + 2
		
			else:
				#print("［助監　変数展開］　対象なし　段落：［" + target_before_change + "］")
				terget_after_change += target_before_change.substr(from)
				break

		return terget_after_change
	
	else:
		#print("［助監　変数展開］　対象なし　非テキスト")
		return target_before_change
