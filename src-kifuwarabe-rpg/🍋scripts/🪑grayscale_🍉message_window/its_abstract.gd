# メッセージ・ウィンドウ（Message Window；伝言窓）
# イッツ・アブストラクト（Its abstract；その抽象的な）
extends Sprite2D


class_name AbstractMessageWindow


# 状態機械
var statemachine_of_message_window = load("res://🍋scripts/🪑grayscale_🍉message_window/statemachines/message_window.gd").new()
