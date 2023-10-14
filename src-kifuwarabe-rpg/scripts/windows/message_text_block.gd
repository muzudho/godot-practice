# テキスト・ブロック（TextBlock）
extends Label

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine_of_message_window = null

var is_visible_initialized = false


func get_snapshot(department_node_name):
	return $"../../../../../System/Snapshots".get_node(department_node_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#	TODO ★ タイプライター機能は、スナップショット、またはメッセージの方に持たせたい
func _process(delta):
	
	# 非表示のときは働かない
	if self.visible:
	
		# タイプライター風表示中
		if self.statemachine_of_message_window.is_typewriter():
			
			if not self.is_visible_initialized:
				# 初回に可視化
				# TODO ここで自分の状態を変更するコードを書きたくない。エッジ―へ移動したい
				self.visible = true
				self.is_visible_initialized = true
			
			self.get_snapshot("VisualNovelDepartment").count_of_typewriter += delta

			# １文字 50ms でも、結構ゆっくり
			var wait_time = 0.05
		
			# メッセージの早送り
			if Input.is_key_pressed(KEY_R):
				# print("［テキストブロック］　メッセージの早送り")
				wait_time = 0.01
		
			if wait_time <= self.get_snapshot("VisualNovelDepartment").count_of_typewriter:
				if 0 < self.get_snapshot("VisualNovelDepartment").text_block_buffer.length():
					# １文字追加
					self.text += self.get_snapshot("VisualNovelDepartment").text_block_buffer.substr(0, 1)
					self.get_snapshot("VisualNovelDepartment").text_block_buffer = self.get_snapshot("VisualNovelDepartment").text_block_buffer.substr(1, self.get_snapshot("VisualNovelDepartment").text_block_buffer.length()-1)
				else:
					# 完全表示中
					self.statemachine_of_message_window.all_characters_pushed()
				
				self.get_snapshot("VisualNovelDepartment").count_of_typewriter -= wait_time
