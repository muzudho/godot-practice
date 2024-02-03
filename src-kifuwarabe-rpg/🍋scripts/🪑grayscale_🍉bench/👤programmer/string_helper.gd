# ストリング・ヘルパー（String Helper；文字列の助け）
extends Object


class_name StringHelper


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 全角数字
static var zenkaku_numbers = ["０", "１", "２", "３", "４", "５", "６", "７", "８", "９"]


# ーーーーーーーー
# 文字列関連
# ーーーーーーーー

# １番外側でダブルクォーテーションが挟んでいれば、そのダブルクォーテーションを外します
static func trim_double_quotation(line):
	if 2 <= line.length() and line[0]=="\"" and line[-1]=="\"":
		return line.substr(1, line.length()-2)
	
	return line


# 先頭行と、それ以外に分けます。できなければヌル
static func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	
	if index < 0:
		return null
	
	var head = text.substr(0, index)
	var tail = text.substr(index+1)
	# print("［助監］　head：　[" + head + "]")
	# print("［助監］　tail：　[" + tail + "]")
	return [head, tail]


# 数値を全角テキストに変換
static func number_to_zenkaku_text(number, figures):
	var zenkaku_text = ""
	
	while 0 < number:
		var zenkaku_num = StringHelper.zenkaku_numbers[number % 10]
		number /= 10
		
		zenkaku_text = zenkaku_num + zenkaku_text
	
	# 左側に全角空白を詰める
	var spaces = figures - zenkaku_text.length()
	for i in range(spaces):
		zenkaku_text = "　" + zenkaku_text
		
	return zenkaku_text
