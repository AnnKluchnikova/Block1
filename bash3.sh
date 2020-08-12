#Написать скрипт, который контролирует выполнение какого-либо процесса.
#В случае прерывания этого процесса возобновляет его работу.
#Скрипт должен запросить периодичность проверки и имя процесса.

#Для примера может быть взят процесс yes > /dev/null &
#Скрипт проверяет статус указанного процесса, если статус запущен -> R отсутствует,то сам запускает указанный процесс в фоновом режиме.
#Для завершения процесса используйте команду kill PID в параддедьно запущенном окне терминала.
#!/bin/bash
echo -n "Введите имя процесса: "
read proc
echo -n "Введите периодичность проверки в секундах: "
read sec

while [ 1 = 1 ]
do
  sleep $sec
  stat2=$(ps aux | grep "$proc" | head -n 1 | cut -c 50)
  #echo $stat2
  if [ "$stat2" == "R" ]
  then 
       pid1=$(ps -a |grep "$proc" | cut -c 1-7)
       echo Процесс "$proc" работает c идентификатором "$pid1"
  else
      date=$(date)
      "$proc" > /dev/null &
      pid2=$(ps -a |grep "$proc" | cut -c 1-7)
      echo Процесс "$proc" с идентификатором "$pid2" был запущен "$date"
  fi
done
