# База данных: Музыкальный плеер
# Дайновиич Олег Леонардович, 153503

## Сущности:

### 1. Пользователь
- UserId
- Username
- Email
- PasswordHash
- CreatedAt
- UpdatedAt
### 2. Аккаунт
- AccountId
- UserId
- Avatar
- Bio
- CreatedAt
- UpdatedAt
### 3. Исполнитель
- ArtistId
- Name
- Avatar
- Bio
### 4. Платная подписка
- SubscriptionId
- UserId
- StartDate
- EndDate
### 5. Плейлист
- PlaylistId
- UserId
- Name
- Duration
- CreatedAt
- UpdatedAt
### 6. Альбом
- AlbumId
- Name
- ArtistId
- ReleaseDate
- Duration
- Cover
### 7. Песня
- SongId
- Name
- ArtistId
- AlbumId
- GenreId
- Duration
- Text
- ReleaseDate
### 8. Жанр
- GenreId
- Name
- Description
### 9. Недавно прослушанное
- RecentlyListenedId
- UserId
- EntityId
- EntityType
### 10. Уведомление
- NotificationId
- UserId
- Message
- SentAt
- SeenAt
