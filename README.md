# ToDoList-VIPER

## 📌 Описание
ToDoList — это приложение для управления списком задач, реализованное с архитектурой **VIPER**. Оно использует **SwiftUI** и **CoreData** для локального хранения.

## 📷 Скриншоты
### Главный экран  
<img src="https://github.com/domrachefff/ToDoList-VIPER-/blob/main/Screenshots/IMG_5307.PNG" alt="Скриншот игры SnakeOld" width="300">
<img src="https://github.com/domrachefff/ToDoList-VIPER-/blob/main/Screenshots/IMG_5310.PNG" alt="Скриншот игры SnakeOld" width="300">

### Редактирование/Добавление задачи  
<img src="https://github.com/domrachefff/ToDoList-VIPER-/blob/main/Screenshots/IMG_5309.PNG" alt="Скриншот игры SnakeOld" width="300">

## 🚀 Функциональность
- **Создание задач** с заголовком, описанием и датой.
- **Редактирование и удаление** задач.
- **Отметка выполнения** задач.
- **Поиск** по названию и описанию.
- **Синхронизация с API**.

## 🏛 Архитектура
Проект построен по **VIPER**:
- **View (SwiftUI)** — отображение UI.
- **Interactor** — бизнес-логика (работа с CoreData и API).
- **Presenter** — связь между View и Interactor.
- **Entity** — модели данных.
- **Router** — навигация.

## 🔧 Установка
1. Клонируй репозиторий:
   ```bash
   git clone https://github.com/domrachefff/ToDoList-VIPER-.git
   ```
2. Открой проект в Xcode.
3. Запусти на симуляторе или устройстве.

## 📡 API
Приложение использует [DummyJSON ToDo API](https://dummyjson.com/todos) для загрузки списка задач.

## Контакты

- **Автор**: Домрачев Алексей
- **Email**: domrachefff.a@yandex.ru
