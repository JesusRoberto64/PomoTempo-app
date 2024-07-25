extends Node
class_name ArithmeticsDate

func is_Leap_Year(year: int) -> bool:
	return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)

func get_Days_In_Month(year: int, month: int)-> int:
	var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	if month == 2 and is_Leap_Year(year):
		return 29
	return daysInMonth[month - 1]

func add_days(_date, days_to_add: int)-> String:
	var year = int(_date.get_slice("-",0))
	var month = int(_date.get_slice("-",1))
	var day = int(_date.get_slice("-",2))
	
	#Determin the direction add or subtract, base on number's sign 
	var s = sign(days_to_add)
	days_to_add = abs(days_to_add)
	
	if s > 0:
		while days_to_add > 0:
			day += 1
			if day > get_Days_In_Month(year, month):
				month += 1
				if month > 12:
					month = 1
					year += 1
				day = 1
			days_to_add -= 1
	else:
		while days_to_add > 0:
			day -= 1
			if day < 1:
				month -= 1
				if month < 1:
					month = 12
					year -= 1
				day = get_Days_In_Month(year, month)
			days_to_add -= 1
	
	return "%d-%02d-%02d" % [year, month, day]#{"year": year, "month": month, "day": day}




