#	コンクリート・ロケーション（Concrete Location；具体的な場所）
extends CanvasLayer


var is_appear = true


#	TODO 使ってない？消す？
#	サブツリーの visible を設定
func set_visible_subtree(is_visible):
	print("［コンクリート・ロケーション］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード
		for child in self.get_children():
			if "visible" in child:
				child.visible = is_visible


# サブツリーの appear を設定
func set_appear_subtree(is_appear):

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_appear != self.is_appear:
		self.is_appear = is_appear

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
