local Scheduler = require("schedlua.scheduler")()
local Task = require("schedlua.task")
local Queue = require("schedlua.queue")


local taskID = 0;


local function getNewTaskID()
	taskID = taskID + 1;
	return taskID;
end


local function spawn(scheduler, priority, func, ...)
	local task = Task(func, ...)
	task.TaskID = getNewTaskID();
	schdeuler:scheduleTask(task, priority, ...) 
	-- TasksReadyToRun:enqueue(task)
	return task;
end


local function task1()
	print("first task")
end

local function task2()
	print("second task")
end


local function main()
	local t1 = spawn(Scheduler, 2, task1)
	local t2 = spawn(Scheduler, 1, task2)

	print("task 1 priority: ", t1.getPriority())
	print("task 2 priority: ", t2.getPriority())			

end

main()
