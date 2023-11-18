# アシスタント・ディレクター（Assistant Director；助監）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return $"../../Director"


# シナリオライター取得
func get_scenario_writer():
	return self.get_director().get_node("📂ScenarioWriter")


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


# プログラム・ハブ取得
func get_program_hub():
	return $"🛩️ProgramsHub"


# 命令ノード取得
func get_instruction(instruction_name):
	return $"🍱Instructions_🍉KifuwarabeVisualNovel".get_node(instruction_name)


# ーーーーーーーー
# その他
# ーーーーーーーー


# シナリオの現在セクション配列のサイズを返す
func get_current_section_size_of_scenario():
	return self.get_program_hub().get_current_section_size_of_scenario()


# シナリオの現在パラグラフ（セクションのアイテム）を返す
func get_current_paragraph_of_scenario():
	return self.get_program_hub().get_current_paragraph_of_scenario()


# 「§」セクションの再生
func play_section():
	self.get_program_hub().play_section()


# 伝言窓で選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	self.get_program_hub().on_choice_selected(row_number)


# 先頭行と、それ以外に分けます。できなければヌル
func split_head_line_or_tail(text):
	return self.get_program_hub().split_head_line_or_tail(text)


# 変数展開する
# `target_before_change` - １行かもしれないし、段落かもしれないし、匿名関数かもしれない
func expand_variables(target_before_change):
	return self.get_program_hub().expand_variables(target_before_change)


# １番外側でダブルクォーテーションが挟んでいれば、そのダブルクォーテーションを外します
func trim_double_quotation(line):
	return self.get_program_hub().trim_double_quotation(line)


# 数値を全角テキストに変換
func number_to_zenkaku_text(number, figures):
	return self.get_program_hub().number_to_zenkaku_text(number, figures)


# パラグラフ（セクションのアイテム）が［ト書き］か、［台詞］か、によって処理を分けます
func parse_paragraph(paragraph_text):
	self.get_program_hub().parse_paragraph(paragraph_text)
