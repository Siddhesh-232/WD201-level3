require "date"
class Todo
  def lAD(txt,dueDate,finish)
    @txt=txt
    @dueDate=dueDate
    @finish=finish
  end
  def dueToday?
    @dueDate==Date.today
  end
  def dueLater?
    @dueDate>Date.today
  end
  def overDue?
    @dueDate<Date.today
  end
  def to_displayable_string
    tab=@finish ? "[x]" : "[ ]"
    "#{tab} #{@txt} #{dueDate}"
  end
end
class TodosList
  def initialize(todos)
    @todos=todos
  end
  def plus(todo)
    @todos<<todo
  end
  def dueToday
    TodosList.new(@todos.filter {|todo|todo.dueToday?})
  end
  def dueLater
    TodosList.new(@todos.filter {|todo|todo.dueLater?})
  end
  def overDue
    TodosList.new(@todos.filter {|todo|todo.overDue?})
  end
  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }.join("\n")
  end
end
date = Date.today
todos = [
  { txt: "Submit assignment", dueDate: date - 1, finish: false },
  { txt: "Pay rent", dueDate: date, finish: true },
  { txt: "File taxes", dueDate: date + 1, finish: false },
  { txt: "Call Acme Corp.", dueDate: date + 1, finish: false },
]
todos = todos.map { |todo|
  Todo.new(todo[:txt], todo[:dueDate], todo[:finish])
}
todos_list = TodosList.new(todos)
todos_list.plus(Todo.new("Service vehicle", date, false))
puts "My Todo List\n\n"
puts "overdue\n"
puts todos_list.overDue.to_displayable_list
puts "\n\n"
puts "Due Today\n"
puts todos_list.dueToday.to_displayable_list
puts "\n\n"
puts "Due Later\n"
puts todos_list.dueLater.to_displayable_list
puts "\n\n"
