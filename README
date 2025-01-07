## Задание

Необходимо развернуть приложение, построенное на микросервисной архитектуре. Приложение состоит из 10 сервисов(postgresql, rabbitmq и 8 сервисов, написанных на Java). Схема разворачиваемого приложения и дополнительнпя информация содержится в директории materials. Требуется: 

1. Cоздать docker compose файл, который позволит развернуть сервисы в docker контейнерах.                          
2. Cоздание кластера, в котором будем разворачиваться на прошлом этапе docker compsoe file, при помощи docker swarm. Кластер будет состоять из 3 нод(2 worker и manager). В кластер будут объединены виртуальные машины, созданные при помощи Vagrant.


# Отчет о проделанной работе

## Part 1. Запуск нескольких docker-контейнеров с использованием docker compose

**1. Создал для каждого сервиса универсальный Dockerfile:**  
- Здесь я использовал принцип multi-stage, сначала происходит сборка, а потом я использую артифакты для запуска приложения. Это помогает уменьшит емкость контейнера, и защищает от потенциальных атак из-за того, что нет компиляторов и тп.  

![image](images/1_dockerfile.png)  


**2. Создал docker-compose.yml:**  
- В нем происходит запуск всех сервисов, а также бд на базе postgres и RabbitMQ.(Можно ознакомится в файле docker-compose.yml)  
- В нем я учел зависимость от бд и RabbitMQ, поэтому сначала запустятся они, потом сервисы.  
![image](images/1_dependence.png) 
- Также все переменные окружения находятся в файлах env(с ними можно ознакомится в папке src).  
![image](images/1_db_env.png)  


**3. Запуск docker-compose.yml:**  
- С помощью команды ```docker-compose up``` происходит сборка, если до этого не было, и запуск всех сервисов(контейнеров)  
![image](images/1_up.png)  


**4. Проверка сервисов с помощью Postman:**  
- Импортируем файл ```application_tests.postman_collection.json``` в приложение Postman и запускаем тесты  
![image](images/1_postman_successful.png)  

## Part 2. Создание виртуальных машин

**1. Иницилизируем Vagrant в корне проекта:**  
```vagrant init```  

**2. Напишем Vagrantfile для одной виртуальной машины:**  
![](images/2_vagrantfile.png)  

**3. Напишем скрипт для загрузки необходимых утилит в виртуальную машину(setip_manager.sh):**  
![](images/2_setup_manager.png)  

**4. Запустим vagrant:**  
```vagrant up```  
![](images/2_vagrant_up.png)    

**5. Убедимся, что исходный код встал, подключившись по ssh:**
```vagrant ssh```



## Part 3. Создание простейшего docker swarm

**1. Модифицируем Vagrantfile для создания manager01, worker01, worker02:**  
![](images/3_vagrantfile.png)  
- Для загрузки необходимых утилит и запуска сервисов для manager и workers созданы bash-скрипты. С ними можно ознакомится в соответсвующих файлах **setup_manager.sh** и **setup_worker.sh**  

**2. Соберем в образы Dockerfile и запушим на Dockerhub**  
![](images/3_docker_hub.png)  

- также в docker-compose используются образы из dockerhub, а не Dockerfile  

**3. Поднимем виртуальные машины**  

- ```vagrant up```  

- В bash-скрипте для менеджера(setup_manager.sh) прописан запуск docker-compose.yml и запуска стека сервисов  

**4. Настроим proxy на базе nginx**   

- Конфигурационный файл  
![](images/3_nginx_conf.png)  

- Реализуем proxy сервер как отдельный сервис в docker-compose.yml  
![](images/3_proxy_service.png)  

**5. Проверим работу proxy сервера с помощью Postman**  
![](images/3_postman.png)  

**6. Используя команды docker, отобразим распределение контейнеров по узлам**  

- Проверим работу узлов  
![](images/3_cluster_load.png)  

- Отобразим работу стэка  
![](images/3_docker_stack.png)  

**7. Вирутализация кластера с помощью Portainer**  
- Общая информация о кластере  
![](images/3_general_info.png)  

- Информация о узлах  
![](images/3_portainer_nodes.png)  

- Информация о стеке  
![](images/3_portainer_stack.png)  