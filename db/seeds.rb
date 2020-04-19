(1..100).each do |number|
  Task.create(status: "達成", content: "目標" + number.to_s)
end