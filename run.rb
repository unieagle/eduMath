
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

def get_questions
  lower = 1
  upper = 5
  questions = []
  (lower..upper).each do |a|
    (a..upper).each do |b|
      q = "#{a} + #{b}"
      questions << q
    end
  end
  return questions
end

def run
  questions = get_questions
  questions.shuffle!
  results = {}
  questions.each do |q|
    results[q] = show_question(q)
  end

  results.keys.sort.each do |question|
    puts "#{question} : #{symbol(results[question])}"
  end

  puts "Total: #{questions.count}"
  puts "Correct: #{results.values.select{|r| r == true}.count}"
end

run
