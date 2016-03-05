--test_scheduler.lua

package.path = package.path..";../?.lua"

PriorityQueue = {
    __index = {
        push = function(self, priority, value)
            local t = self[priority]
            if not t then
                t = {first = 1, last = 0}
                self[priority] = t
            end
            t.last = t.last + 1
            t[t.last] = value 
        end,
        pop = function(self)
            for p, q in pairs(self) do
                if q.first <= q.last then
                    local value = q[q.first]
                    q[q.first] = nil 
                    q.first = q.first + 1
                    return p,value
                else
                    self[p] = nil 
                end
            end
        end
    },
    __call = function(cls)
        return setmetatable({}, cls)
    end
}
 
setmetatable(PriorityQueue, PriorityQueue)




local taskID = 100;

local function getNewTaskID()
	taskID = taskID + 1;
	return taskID;
end


pq = PriorityQueue()

local tasks = {}


local function createTask(priority, ...)
	local task = {}
	table.insert(task,priority)
	table.insert(task,getNewTaskID())
	table.insert(tasks,task)
    pq:push(task[1],task[2])
    print('TaskID: '..task[2]..', priority: '..task[1]..' is created')
	return task;
end


local function main()

    print('========== create Task ============')
    local t101 = createTask(5)
	local t102 = createTask(3)
	local t103 = createTask(2)
	local t104 = createTask(1)
    local t105 = createTask(6)
    local t106 = createTask(4)

    print('============ run Task =============')

    for prio, task in pq.pop, pq do
    print(string.format("TaskID %d is executed in priority %s", task, prio))
    end

end

main()



