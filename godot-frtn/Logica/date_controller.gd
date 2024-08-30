extends ArithmeticsDate
#DATE CONTROLLER FORMAT

#Format Date is "YEAR-Month-Day" in integers Ex. 2024-01-01
#format_date is use to convert Time dictionary same as the Database format
func format_Date(year: int, month: int, day: int) -> String:
	return "%d-%02d-%02d" % [year, month, day]

func get_Today_String() -> String:
	var t = Time.get_date_dict_from_system()
	return format_Date(t.year, t.month, t.day)

func adjust_Days(date: String, _add_days: int) -> String:
	return add_days(date, _add_days)
	#var adjustedDate = add_days(date, days)
	#return format_Date(adjustedDate.year, adjustedDate.month, adjustedDate.day)

func get_Day_Before(_formatDate)-> String:
	return adjust_Days(_formatDate, -1)

func get_Next_Day(_formatDate)-> String:
	return adjust_Days(_formatDate, 1)
