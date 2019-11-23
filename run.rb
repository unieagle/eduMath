
def symbol(value)
  value ? "✅" : "❌"
end

def show_question(question)
  puts "#{question} = ?"
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
  # ((upper-1)..upper).each do |a|
  #   (lower..a).each do |b|
  #     q = format_question(a, b)
  #     questions << q
  #   end
  # end
  return questions
end

def get_sub_questions
  lower = 1
  upper = 6
  questions = []
  (lower..upper).each do |a|
    (a..upper).each do |b|
      q = format_question(b, a, :sub)
      questions << q
    end
  end
  ((upper-1)..upper).each do |a|
    (lower..a).each do |b|
      q = format_question(a, b, :sub)
      questions << q
    end
  end
  return questions
end

def run
  questions = get_questions.shuffle.first(15)
            + get_sub_questions.shuffle.first(15)

  results = []
  questions.each do |q|
    results << [q, show_question(q)]
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

run
