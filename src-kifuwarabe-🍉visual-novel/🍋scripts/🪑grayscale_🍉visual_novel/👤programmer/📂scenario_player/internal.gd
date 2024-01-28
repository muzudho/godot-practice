# インターナル（Internal；内部）
#
#	内部で共有する変数など
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 全命令（キー："命令名:"　値：ノード名）
var directory_for_instruction_code_and_node_name = null

# `department:` 命令に失敗すると、次の `goto:` 命令は１回無視されるというルール。
# 次の `goto:` 命令に到達するか、次の `department:` 命令に成功するか、 ト書きが終わると解除
var is_department_not_found = false
