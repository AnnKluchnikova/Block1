#Написать скрипт для резервного копирования указанной информации в указанное место,
#с указанием периодичности или времени запуска. Скрипт должен иметь удобный для человека интерфейс.
#Резервное копирование должно осуществляться как средствами dd, так и tar. По выбору пользователя,
#должна быть возможность работы с git.

#Скрипт запрашивает имя файла для резервного копирования и шаблон имени файла, куда периодически будет
#копироваться информация из указанного файла. После копирования шаблонный файл архивируется. Таким образом
#в каталоге /dev создаются заархивитрованные файлы с копиями указанного ранее файла, имеющие шаблонное имя с добавлением счетчика.
#Кроме этого указанный файл может быть загружен на git и обновляться в репозитории с той же периодичностью.
#!/bin/bash

echo "Укажите файл для резервного копирования (Например: test.c):"
read file
echo "Укажите шаблон имени файла для копирования"
read name
echo "Укажите периодичность выполнения резервного копирования (в секундах)"
read sec
echo "Добавить указанный файл на GitHub? (y/n)"
read git

if [ "$git" == "y" ]
then
    echo "Укажите адрес репозитория http://github.com/user/repo.git"
    read add
    git add "$file"
    git commit -m "Create file"
    git remote add origin "$add"
    git push origin master
fi

i=0
while [ 1=1 ]
do
  if [ "$git" == "y" ]
  then
      git add "$file"
      git commit -m "Update"
      git push
  fi
  touch ${name}${i}.txt
  dd if=$file of=${name}${i}.txt
  tar --create --file ${name}${i}.tar ${name}${i}.txt
  rm -R ${name}${i}.txt
  sudo mv ${name}${i}.tar /dev
  let "i += 1"
  sleep ${sec}
done
