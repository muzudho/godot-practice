# モンキー（Monkey；猿）
#
# 木登りが得意
extends Object


class_name Monkey


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 親の直下の子
var cached_ancestor_children = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー

# 親の直下の子を調べる。なければ、祖先の直下の子を調べる
func find_ancestor_child(
		current_node,		# Node
		target_node_name):	# StringName
	return MonkeyHelper.find_ancestor_child(
			current_node,		# Node
			target_node_name,
			func():
				return self.cached_ancestor_children)
