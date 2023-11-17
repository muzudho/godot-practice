#	ゴートゥー（Go to；～へ行く）
extends Node


# 監督取得
func get_director():
	return $"../../../Director"


# 助監取得
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(
	line):				# str

	# 次の「§」セクション名
	var next_section_name = line.substr(5).strip_edges()
	print("［命令　ゴートゥー］　次の区画：[" + next_section_name + "]")
	next_section_name = self.get_assistant_director().expand_variables(next_section_name.strip_edges())

	self.goto(next_section_name)


# 同じ部門内の、指定のセクションに飛ぶ
func goto(section_name):
	# 伝言窓の状態が Completed で止まってるとフリーズするから、強制解除
	print("［命令　ゴートゥー］　伝言窓の状態が Completed で止まってるとフリーズするから、強制的にオール・ページズ・フラッシュド")
	self.get_director().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()

	self.get_director().set_current_section(section_name)
	self.get_assistant_director().play_section()
