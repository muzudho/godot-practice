# クロック（Clock；時計）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 時計
# ーーーーーーーー


func on_process(delta):

	if not self.monkey().moderator().is_enabled:
		return
	
	if not (self.monkey().statemachine().state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	# 初回
	if self.monkey().moderator().key_config_item_number == 0:
		self.monkey().of_staff().programmer().owner_node().bg_musics.find_node("🎵キーコンフィグ").play()
		self.monkey().moderator().key_config_item_number += 1
		self.monkey().moderator().clear_count()
	
	# ーーーーーーーー
	# （１）キャンセルボタン、メニューボタン
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 1:
		self.monkey().moderator().on_step_regular(
				delta,
				null,
				&"VK_Cancel")
	
	# ーーーーーーーー
	# （２）決定ボタン、メッセージ送りボタン
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 2:
		self.monkey().moderator().on_step_regular(
				delta,
				&"VK_Cancel",
				&"VK_Ok")
		
	# ーーーーーーーー
	# （３）メッセージ早送りボタン
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 3:
		self.monkey().moderator().on_step_regular(
				delta,
				&"VK_Ok",
				&"VK_FastForward")
		
	# ーーーーーーーー
	# （４）レバーの下
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 4:
		self.monkey().moderator().on_step_regular(
				delta,
				&"VK_FastForward",
				&"VK_Down")
		
	# ーーーーーーーー
	# （５）レバーの上
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 5:
		self.monkey().moderator().on_step_regular(
				delta,
				&"VK_Down",
				&"VK_Up")
		
	# ーーーーーーーー
	# （６）レバーの右
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 6:
		self.monkey().moderator().on_step_regular(
				delta,
				&"VK_Up",
				&"VK_Right")
		
	# ーーーーーーーー
	# （７）レバーの左
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 7:
		self.monkey().moderator().on_step_regular(
				delta,
				&"VK_Right",
				&"VK_Left")
	
	# ーーーーーーーー
	# 完了
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 8:
		self.monkey().moderator().on_step_regular(
				delta,
				&"VK_Left",
				null)
