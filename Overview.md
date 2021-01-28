# Non official KAFKA overview

```
- так вот, мы используем кафку как гарантию доставки сообщений. Все, что в нее попадает - сохраняется там на какое-то время. К примеру у нас в кафку пришло  100 сообщений. Пока мы их не вычитали из кафки - офсет будет 0. Как только вычитаем 5 - офсет увеличится соответственно. Если мы попробовали вычитать, но что-то пошло не так - офсет не изменится, и следующее сообщение на вычитку будет то же самое. Мы можем контролировать значение офсета для наших нужд. Например мы дропнули свои базы за определенный период - и нам нужно наново вычитать сообщения из кафки. Ну или проебали часть данных (плохой код на нашей стороне) и пока данные с кафки не пропали - можем их снова вычитать и уже правильно обработать. В случае с нашим сервисом - нам нужно вычитать только данные за последние 3 месяца. Но если в одном топике (читай базе данных) записи добавлялись равномерно по мере поступления, то в другом топике они появились в один день, а дальше продолжили добавляться равномерно по мере поступления. Потому в этом сраном скрипте разных подход к сбросу офсетов. Для одного топика тупо по дате, для другого - для каждой партиции свое значение. Партиции +- то же самое что и шарды. Просто данные размазали по разным инстансам, что б ускорить процесс их вычитки. В общих словах это работает как-то так. Есть еще понятие консьюмер и продьюсер - это уже непосредственно те, кто данные в кафку кладут и те, кто из нее вычитывают, но то по сути уже ответственность девелоперов.
- итого, сбрасывая оффсет в 0, ты триггеришь вычитку всех мессаджей из определённого топика?
- именно

всегда 1 месседж в 1 партиции
и распределение может быть между ними не равномерно
типа 5 записей на 4 партиции будет не всюду по 1 а на одной 2, а может быть 3 на одной и 2 на другой, а на остальных ничего

порядок вычитки - фифо в рамках партиции

лаг. Но по сути это диф между текущим оффсетом и последним оффсетом

```