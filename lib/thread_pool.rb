class ThreadPool
  attr_reader :queue

  def initialize(tasks, thread_limit, thread_object=Thread)
    @queue         = populate_queue(tasks)
    @thread_limit  = thread_limit
    @thread_object = thread_object
  end

  def execute
    (0...@thread_limit).map do
      create_worker
    end.each(&:join)
  end

  private

  def populate_queue(tasks)
    _queue = Queue.new
    tasks.each do |task|
      _queue.push(task)
    end

    _queue
  end

  def create_worker
    @thread_object.new do
      begin
        execute_tasks
      rescue ThreadError
      end
    end
  end

  def execute_tasks
    while task = @queue.pop(true)
      task.call
    end
  end
end
