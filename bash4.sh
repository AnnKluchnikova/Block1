#Скрипт получает данные с top, представляет их в более удобном для пользователя виде,
#с возможностью наложения фильтров для выхода.
#!/bin/bash

echo "Укажите имя пользователя для фильтрации (Например: root) или all, чтобы посмотреть весь список процессов"
read filt

if [[ $filt == "all" ]]
then
 sed -i 'd' res4
 top -b -n 1 > res4
 sed -i '1,6d' res4
 cat res4
else
 sed -i 'd' res4
 top -u "$filt" -b -n 1 > res4
 sed -i '1,6d' res4
 cat res4
fi
