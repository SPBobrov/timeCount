#получаем на входе хеш вида accounting_ten_1 = {'ruby' => 54, 'git' => 0.5, 'linux' => 0}
# accounting_ten_2 = {'yoga' => 1, 'физкультура' => 0.5, 'бег' => 0} 
#меняем значение ключей в конце каждого рабочего дня, (должен быть впоследствии бот, который отправляет сообщения в телеграмм)
#считается ежедневно общее значение по каждому дню в виде accounting_ten_1_sum ..., 
#добавляется в хеш вида accounting_ten_sum = {'19-01-2025' => [accounting_ten_1_sum, accounting_ten_2_sum, accounting_ten_3_sum]}
#впоследствии будет график в осях дата / сумма
#смысл в мотивации - аналог метода "непрерывная линия"

#Нужно не в txt сохранять я xml или json и пользоваться парсером для чтения и записи. Впрочем можно написать парсер для записит в txt
#Написал свой парсер - написал
#Реализовать: выдачу данных до того как начинается диалог ввода. после выдачи данных предложить ввести новые данные +
#Реализовать функцию учета времени

####################################
#Методы
####################################

def pty_to_txt (hs, file_adress) #file_adress в виде "file_adress.txt"

	file = File.new(file_adress, "w:UTF-8")

	hs_converting = ''
	hs.each  {|key, value| hs_converting += "#{key}-#{value} "}
		
	file.print(hs_converting)

	file.close

end

def pty_to_hs (file_adress)

	file = File.new(file_adress, "r:UTF-8")
	string = file.read
	file.close
	arr = string.split(' ')
	
	arr1 = []

	arr.each do |item| 
		arr1 << item.split('-')
	end 

	hs ={}

	arr1.each do |item|
		hs[item[0]] = item[1].to_f
	end
	
	return hs
end

####################################
#Переменные
####################################

log = "./parser_log.txt"

####################################
#Основная программа
####################################

accounting_ten_1 = pty_to_hs(log)


puts "Результары на сегодня: ruby - #{accounting_ten_1['ruby']}, git -
 #{accounting_ten_1['git']}, linux - #{accounting_ten_1['linux']}, english
  - #{accounting_ten_1['english']}, tools - #{accounting_ten_1['tools']} "

accounting_ten_1_sum = 0 # обнуляем начальное значение, чтобы посчитать сумму часов на начало учета
accounting_ten_1.each do |key, value|
	accounting_ten_1_sum += value
end

puts "Всего #{accounting_ten_1_sum}"

puts "Осталось до цели #{10000 - accounting_ten_1_sum} "

print 'Готовы ввести новые данные? Да/нет '
is_new_data = gets.chomp.downcase
if is_new_data == 'да' || is_new_data == 'yes'

		
	print 'Введите количество часов ruby - '
	ruby_day = gets.chomp.to_f
	p ruby_day
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

####################################
#Результаты
####################################


	puts "Результары на сегодня: ruby - #{accounting_ten_1['ruby']}, git -
 	#{accounting_ten_1['git']}, linux - #{accounting_ten_1['linux']}, english
  	- #{accounting_ten_1['english']}, tools - #{accounting_ten_1['tools']} "

	puts "Сегодня отработано #{accounting_ten_1_sum_day} часов"
	puts "Всего за весь период учета #{accounting_ten_1_sum}"
	puts "Осталось до цели #{10000 - accounting_ten_1_sum} "

	pty_to_txt(accounting_ten_1, log)

else
	puts 'Продолжайте работу'

end




