## Todoist setup
- Planning process (the most important part!)
	- Weekly planning (30 mins at the start of each week): 
		- Review all project lists and choose tasks for this week; set the due date to the last day of the week (e.g. Sunday)
		- Review "this week" view and adjust accordingly (e.g. add / remove tasks if there are too few / too many)
		- For the rest of the week, refer only to the "this week" view and do not look at the full project lists
	- Daily planning (10 mins at the start of each day):
		- Review "this week" view and choose tasks for today; set the due date to today
		- Review "today" view and adjust accordingly (e.g. add / remove tasks if there are too few / too many)
		- For the rest of the day, only look at the "today" view and do not look at "this week" or any project lists
		- Tackle tasks in order of priority and check them off as you go
- Project and task hierarchy
	- Projects = 3-5 broad areas of life, e.g. "work", "hobbies", "home"
	- Sections = projects / areas in the PARA sense, e.g. "marketing strategy for X", "learn piano", "finances"
	- Tasks = tasks
	- Subtasks = optional, for longer tasks
- Due date
	- Date when I want to DO the task
	- Hard deadlines go into the task title (if you have a premium account, you can use the deadlines feature instead)
- Priorities
	- p1 = important; urgent
	- p2 = important; not urgent
	- p3 = not important; urgent
	- p4 = not important; not urgent
- Views
	- Today = default Todoist view
	- This week = everything due this calendar week
- Labels
	- Time
		- 5-min
		- 15-min
		- 30-min
		- 45+min
	- Energy
		- high-energy
		- low-energy
	- Location / context
		- car
	- Misc
		- ios-reminders: iphone automation from Siri > ios reminders app > todoist 
		- waiting: waiting for 
		- weekly-priority
		- habit-daily


## Obsidian integration
- [obsidian-todoist-plugin](https://github.com/jamiebrynes7/obsidian-todoist-plugin)
	- Just provides a query view inside Obsidian
	- Integration is mostly one way, from Todoist into Obsidian
Queries below

### Habits
```todoist
name: Habits
filter: "#RN Habits & /Nikhil's habits & !subtask"
```

### Today or overdue
```todoist
name: Today or overdue
filter: "today | overdue"
show:
- due
- project
- labels
```


### Weekly dashboard
```todoist
name: p1 or p2 this week
filter: "(due before: next monday) & (!assigned to: Others) & (P1 | P2)"
sorting:
- date
- priority
show:
- due
- project
```

# End