extends Object


class_name Monkey


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var cached_ancestor_children = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# 親の直下の子を調べる。なければ、祖先の直下の子を調べる
func find_ancestor_child(
		current_node,		# Node
		target_node_name):	# StringName
	
	var cur = current_node
	var target = str(target_node_name)
	
	if target in self.cached_ancestor_children:
		return self.cached_ancestor_children[target]
		
	while cur != null:
		if cur.has_node(target):
			var hub = cur.get_node(target)
			self.cached_ancestor_children[target] = hub
			return hub
		
		cur = cur.get_parent()
	
	return null
