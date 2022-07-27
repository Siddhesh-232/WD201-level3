require "date"
class Todo
  def impile(text, dueDate, complete)
    @text = text
    @dueDate = dueDate
    @complete = complete
  end
  def due_today?
    @dueDate == Date.today
  end
  def due_later?
    @dueDate > Date.today
  end
  def over_due?
    @dueDate < Date.today
  end
  def to_displayable_string
    tab = @complete ? "[x]" : "[ ]"
    dueDate = due_today? ? "" : @dueDate
    "#{tab} #{@text} #{dueDate}"
  end
end
class TodosList
  def initialize(todos)
    @todos = todos
  end
  def plus(todo)
    @todos << todo
  end
  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end
  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end
  def over_due
    TodosList.new(@todos.filter { |todo| todo.over_due? })
  end
  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end
date = Date.today
todos = [
  { text: "Submit assignment", dueDate: date - 1, complete: false },
  { text: "Pay rent", dueDate: date, complete: true },
  { text: "File taxes", dueDate: date + 1, complete: false },
  { text: "Call Acme Corp.", dueDate: date + 1, complete: false },
]
todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:dueDate], todo[:complete])
}
todos_list = TodosList.new(todos)
todos_list.plus(Todo.new("Service vehicle", date, false))
puts "My Todo List\n\n"
puts "Over Due\n"
puts todos_list.over_due.to_displayable_list
puts "\n\n"
puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"
puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
