# База данных: Музыкальный плеер
# Дайновиич Олег Леонардович, 153503

## Функциональные требования:
### 1. Неавторизованный пользователь
- Регистрация
- Аутентификация и авторизация
### 2. Пользователь без подписки
- Внесение изменений в аккаунт
- Удаление аккаунта
- Прослушивание трэков в случайном порядке
- Поиск и фильтрация
### 3. Пользователь с подпиской
- Внесение изменений в аккаунт
- Удаление аккаунта
- Прослушивание трэков в любом порядке
- Пропуск и перемотка трэков
- Поиск и фильтрация
- Создание и редактирование плейлистов
### 4. Артист
- Создание, редактирование и удаление альбомов
- Публикация и удаление трэков
### 5. Администратор
- Рекламные действия (показ рекламных увеломдений, рекомендации)
- Логирование действий с аккаунтами пользователей
- Журналирование активности пользователей
- Управление правами доступа пользователей (управление платными подписками)
- Просмотр аккаунтов и управление (блокировка, удаление) аккаунтами пользователей
- Просмотр и управление альбомами, плейлистами и трэками

## Сущности:
### 1. Пользователь
- Id INT NOT NULL, PK
- Username, TEXT NOT NULL
- Email TEXT NOT NULL
- PasswordHash TEXT NOT NULL
- CreatedAt DATE
- UpdatedAt DATE
### 2. Аккаунт
- Id INT NOT NULL, PK
- UserId INT NOT NULL, FK -> user
- Avatar PICTURE
- Bio TEXT
- CreatedAt DATE
- UpdatedAt DATE
### 3. Исполнитель
- Id INT NOT NULL, PK
- Name TEXT NOT NULL
- Avatar PICTURE
- Bio TEXT 
### 4. Платная подписка
- Id INT NOT NULL, PK
- AccountId INT NOT NULL, FK -> account
- StartDate DATE
- EndDate DATE
### 5. Плейлист
- Id INT NOT NULL, PK
- AccountId INT NOT NULL, FK -> account
- Name TEXT NOT NULL
- Duration TIME NOT NULL
- CreatedAt DATE
- UpdatedAt DATE
### 6. Альбом
- Id INT NOT NULL, PK
- Name TEXT NOT NULL
- ArtistId INT NOT NULL, FK -> artist
- ReleaseDate DATE
- Duration TIME NOT NULL
- Cover PICTURE
### 7. Песня
- Id INT NOT NULL, PK
- Name TEXT NOT NULL
- ArtistId INT NOT NULL, FK -> artist
- AlbumId INT NOT NULL, FK -> album
- GenreId INT NOT NULL, FK -> genre
- Duration TIME NOT NULL
- Text TEXT NOT NULL
- ReleaseDate DATE
### 8. Жанр
- Id INT NOT NULL, PK
- Name TEXT NOT NULL
- Description TEXT 
### 9. Недавно прослушанное
- Id INT NOT NULL, PK
- AccountId INT NOT NULL, FK -> account
- EntityId INT NOT NULL, FK -> song / playlist / album
- EntityType ENTITY NOT NULL
### 10. Уведомление
- Id INT NOT NULL, PK
- AccountId INT NOT NULL, FK -> account
- Message TEXT NOT NULL
- SentAt DATE
- SeenAt DATE
