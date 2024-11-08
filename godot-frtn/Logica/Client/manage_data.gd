extends Node

func mision_Data(data)-> Dictionary:
	var newDir = {}
	
	for i in data.size():
		print(i)
		newDir.merge({i : data[i]})
	print(newDir)
	
	return {}
