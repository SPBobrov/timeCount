
print 'Готовы ввести новые данные? Д/н '
readiness = gets.chomp.downcase

exit if /[дl]/ !~ readiness 


print 'Введите количество часов ruby - '
ruby_day = gets.chomp.to_f
accounting_ten_1['ruby'] += ruby_day

print 'Введите количество часов git - '
git_day = gets.chomp.to_f
accounting_ten_1['git'] += git_day

print 'Введите количество часов linux - '
linux_day = gets.chomp.to_f
accounting_ten_1['linux'] += linux_day

print 'Введите количество часов english - '
english_day = gets.chomp.to_f
accounting_ten_1['english'] += english_day

print 'Введите количество часов tools - '
tools_day = gets.chomp.to_f
accounting_ten_1['tools'] += tools_day

accounting_ten_1_sum_day = ruby_day + git_day + linux_day + english_day + tools_day
accounting_ten_1_sum = 0 # обнуляем начальное значение, чтобы посчитать сумму часов на конец учета
accounting_ten_1.each do |key, value|
accounting_ten_1_sum += value
end



