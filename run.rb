
def symbol(value)
  value ? "✅" : "❌"
end

def show_question(question, question_number = nil)
  puts "第#{question_number}题. #{question} = ?"
  ans = ''
  while ans.length == 0
    ans = gets.chomp
  end
  correct = eval(question) == ans.to_f
  puts symbol(correct)
  unless correct
    puts "正确答案是: #{question} = #{eval(question)}"
  end
  puts ''
  correct
end

Random.new_seed

def format_question(a, b, op = :add)
  case op
  when :add
    if Random.rand >= 0.5
      "#{a} + #{b}"
    else
      "#{b} + #{a}"
    end
  when :sub
    "#{a} - #{b}"
  end
end

def get_questions
  lower = 1
  upper = 9
  questions = []
  (lower..upper).each do |a|
    (a..upper).each do |b|
      q = format_question(a, b)
      questions << q
    end
  end
  return questions
end

def get_sub_questions
  lower = 1
  upper = 18
  questions = []
  (lower..upper).each do |a|
    (lower..[a, 9].min).each do |b|
      next if a - b <= 0 || a - b > 9
      q = format_question(a, b, :sub)
      questions << q
    end
  end
  return questions
end

def get_mixed_questions
  left_range = (10..99)
  right_range = (10..99)

  questions = []
  100.times do |i|
    left = Random.rand(left_range)
    right = Random.rand(right_range)
    q = format_question(left, right)
    questions << q
  end
  questions
end

def questions
  questions = get_questions +
              get_sub_questions
  print_questions(questions)
end

def print_questions(questions)
  questions.each do |q|
    puts "#{q} ="
  end
  puts questions.size
end

def run
  questions = get_questions.shuffle.first(15) +
              get_sub_questions.shuffle.first(25)

  questions.shuffle!

  results = []
  questions.each_with_index do |q, idx|
    results << [q, show_question(q, idx + 1)]
  end

  results.each do |question|
    puts "#{question.first} : #{symbol(question.last)}"
  end

  puts ""
  puts "---------------"
  puts "总题数: #{questions.count}"
  puts "正确✅: #{results.select{|q| q.last == true}.count}"
  puts "错误❌: #{results.select{|q| q.last != true}.count}"
  puts "---------------"
  puts ""

  wrongs = results.select{|q| q.last == false }
  while wrongs.count > 0
    puts "复习: #{wrongs.count}"
    wrongs.each do |question|
      question[1] = show_question(question.first)
    end
    wrongs = wrongs.select{|q| q.last == false }
  end
end

# questions
# run
print_questions(get_mixed_questions)
# questions(true)
# run
