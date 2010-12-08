#Tell the system to check god next request
system = System.find_or_create_by_name("God status")
system.value = "Check"
system.save
