#	ビジュアル・ノベル・デパートメント・スナップショット（Visual Novel Department Snapshot；ビジュアル・ノベル部のこの瞬間の状態）
extends AbstractDepartmentSnapshot


#	メッセージを出力する対象となるノードの名前（文字列）。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
var message_window_name_obj = &"下"		# StringName 型 シンタックス・シュガー
