# クロック（Clock；時計）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# ハブ取得
func owner_key_config_node():
	return $"../../📂🍉KeyConfig"


# ハブ取得
func moderator():
	return $"../Moderator"


# 状態遷移機械取得
func statemachine():
	return $"../🍇Statemachine"


# ーーーーーーーー
# 時計
# ーーーーーーーー


func on_process(delta):

	if not self.moderator().is_enabled:
		return
	
	if not (self.statemachine().state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	# 初回
	if self.moderator().current_step == 0:
		self.owner_key_config_node().monkey_of_staff().programmer().owner_node().bg_musics.find_node("🎵キーコンフィグ").play()
		self.moderator().current_step += 1
		self.moderator().clear_count()
	
	# ーーーーーーーー
	# （１）キャンセルボタン、メニューボタン
	# ーーーーーーーー
	elif self.moderator().current_step == 1:
		self.moderator().on_step_regular(
				delta,
				null,
				&"VK_Cancel")
	
	# ーーーーーーーー
	# （２）決定ボタン、メッセージ送りボタン
	# ーーーーーーーー
	elif self.moderator().current_step == 2:
		self.moderator().on_step_regular(
				delta,
				&"VK_Cancel",
				&"VK_Ok")
		
	# ーーーーーーーー
	# （３）メッセージ早送りボタン
	# ーーーーーーーー
	elif self.moderator().current_step == 3:
		self.moderator().on_step_regular(
				delta,
				&"VK_Ok",
				&"VK_FastForward")
		
	# ーーーーーーーー
	# （４）レバーの下
	# ーーーーーーーー
	elif self.moderator().current_step == 4:
		self.moderator().on_step_regular(
				delta,
				&"VK_FastForward",
				&"VK_Down")
		
	# ーーーーーーーー
	# （５）レバーの上
	# ーーーーーーーー
	elif self.moderator().current_step == 5:
		self.moderator().on_step_regular(
				delta,
				&"VK_Down",
				&"VK_Up")
		
	# ーーーーーーーー
	# （６）レバーの右
	# ーーーーーーーー
	elif self.moderator().current_step == 6:
		self.moderator().on_step_regular(
				delta,
				&"VK_Up",
				&"VK_Right")
		
	# ーーーーーーーー
	# （７）レバーの左
	# ーーーーーーーー
	elif self.moderator().current_step == 7:
		self.moderator().on_step_regular(
				delta,
				&"VK_Right",
				&"VK_Left")
	
	# ーーーーーーーー
	# 完了
	# ーーーーーーーー
	elif self.moderator().current_step == 8:
		self.moderator().on_step_regular(
				delta,
				&"VK_Left",
				null)
