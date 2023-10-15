#	コンクリート・ロケーション（Concrete Location；具体的な場所）
extends CanvasLayer


var is_appear = true


#	TODO 使ってない？消す？
#	サブツリーの visible を設定
func set_visible_subtree(visible_flag):
	print("［コンクリート・ロケーション］　可視性：" + str(visible_flag))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if visible_flag != self.visible:
		self.visible = visible_flag

		#	子ノード
		for child in self.get_children():
			if "visible" in child:
				child.visible = visible_flag


# サブツリーの appear を設定
func set_appear_subtree(appear_flag):

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if appear_flag != self.is_appear:
		self.is_appear = appear_flag

		var offset = null

		if self.is_appear:
			# 画面内に戻す
			offset = Vector2(0, -720)

		else:
			# 画面下の外に押し出す
			offset = Vector2(0, 720)

		#	自ノード
		self.position += offset

		#	子ノード
		for child in self.get_children():
			if "position" in child:
				child.position += offset
