--test_scheduler.lua

package.path = package.path..";../?.lua"

Scheduler = require("schedlua.scheduler")()
Task = require("schedlua.task")
Queue = require("schedlua.queue")

local taskID = 100;

local function getNewTaskID()
	taskID = taskID + 1;
	return taskID;
end


local temp = {}


local function spawn(scheduler, priority, func, ...)
	local task = Task(func, ...)
	task.TaskID = getNewTaskID();
	task.priority = priority
	local elem ={}
	table.insert(elem,task.priority)
	table.insert(elem,task.TaskID)
	print("Task has been created...")
	print("priority: "..elem[1])
	print("TaskID: "..elem[2])
	table.insert(temp,elem)
	scheduler:scheduleTask(task, {...});
	return task;
end


local function task1()
	print("first task, first line")
	Scheduler:yield();
	print("first task, second line")
end

local function task2()
	print("second task, only line")
end


local function main()
	local t1 = spawn(Scheduler,0, task1)
	local t2 = spawn(Scheduler,1,  task2)

	while (true) do
		if t1:getStatus() == "dead" and t2:getStatus() == "dead" then
			break;		
                end
                Scheduler:step()

        end


	print(temp[1][2])


end

main()



