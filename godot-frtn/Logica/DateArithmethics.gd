extends Node

func add_days(date_dict, days_to_add):
	var year = date_dict.year
	var month = date_dict.month
	var day = date_dict.day
	
	# Arr Días por mes
	var days_in_month = [31, (28 + int(year % 4 == 0 and (year % 100 != 0 or year % 400 == 0))), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	
	var s = sign(days_to_add)
	days_to_add = abs(days_to_add)
	
	if s > 0:
		while days_to_add > 0:
			day += 1
			if day > days_in_month[month-1]:
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
				day = days_in_month[month-1]
			days_to_add -= 1
	
	return {"year": year, "month": month, "day": day}




