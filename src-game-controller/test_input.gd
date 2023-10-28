extends Node


func on_unhandled_input(event):
	
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	#print("［テスト入力］　入力：" + event_as_text)
