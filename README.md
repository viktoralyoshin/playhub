# Playhub

## Архитектура системы

### Сервисы

[```api-gateway```](https://github.com/viktoralyoshin/api-gateway) - Связующее звено между фронтом и микросервисами

[```auth-service```](https://github.com/viktoralyoshin/auth-service) - Сервис авторизации и управления пользвоателями

[```game-service```](https://github.com/ddashadyy/game-service) - Сервис игр, работает с внешним API IGDB, управляет играми

[```social-service```](https://github.com/viktoralyoshin/social-service) - Сервис с отзывами

[```library-service```](https://github.com/ddashadyy/library-service) - Сервис библиотек пользователей

[```rating-service```](https://github.com/viktoralyoshin/rating-service) - Сервис для расчёта рейтинга игры на основе отзывов

### Внешние пакеты
[```utils```](https://github.com/viktoralyoshin/utils) - Пакет с общими элементами микросервисов, подохдит для переиспользования в других проектах
[```playhub-proto```](https://github.com/viktoralyoshin/playhub-proto) - Пакет с ```.proto``` файлами 

## Сервисы

### api-gateway

Является связующим звеном, то есть с фронта ему приходят http-запросы, а он в свою очередь подготоавливает и отправляет запросы в микросервисы по gRPC, после получения ответа от микросервиса, возвращает ответ на фронт.

#### API-Routes

Основная группа - ```/api/v1```

|Группа  |Метод  |Маршрут  | Нужна авторизация |
|:-------|:------|:--------|:--------|
|/auth|POST|/signin|NO|
|/auth|POST|/signup|NO|
|/auth|GET|/new-tokens|NO|
|/auth|GET|/|YES|
|/auth|GET|/user/:id|NO|
|/auth|GET|/logout|NO|
|/games|GET|/search|NO|
|/games|GET|/top|NO|
|/games|GET|/game/:slug|NO|
|/games|GET|/upcoming|NO|
|/games|GET|/|NO|
|/games|GET|/game/id/:id|NO|
|/library|GET|/user|YES|
|/library|GET|/stats|YES|
|/library|POST|/new/:id|YES|
|/social|POST|/|YES|
|/social|GET|/feed|NO|
|/social|GET|/user|YES|
|/social|GET|/game/:id|NO|

#### ENVS

```
- GAMES_SERVICE_ADDR (адрес сервиса с играми)
- AUTH_SERVICE_ADDR (адрес сервиса авторизации)
- SOCIAL_SERVICE_ADDR (адрес сервиса  с отзывами)
- LIBRARY_SERVICE_ADDR (адрес сервиса библиотек пользователей)
- REFRESH_TOKEN_TTL (время жизни refresh_token)
- DOMAIN (домен для cookies)
- ENV (логирование)
```
---
### game-service

Этот микросервис отвечает за хранение, поиск и предоставление всей информации о видеоиграх.

#### gRPC Methods

```
service GameService {
    
    rpc SearchGames (SearchGamesRequest) returns (GamesListResponse);

    rpc GetGame (GetGameRequest) returns (GetGameResponse);

    rpc GetGamesByGenre (GetGamesByGenreRequest) returns (GamesListResponse);

    rpc GetTopRatedGames (GetDiscoveryRequest) returns (GamesListResponse);

    rpc GetUpcomingGames (GetDiscoveryRequest) returns (GamesListResponse);

    rpc ListGames (ListGamesRequest) returns (GamesListResponse);

    rpc SetRating (RatingRequest) returns (google.protobuf.Empty);
}
```

#### ENV
```
- CLIENT_ID=${IGDB_CLIENT_ID}
- CLIENT_SECRET=${IGDB_CLIENT_SECRET}
- DB_CONNECTION
```
---
### game-serivice

Управляет авторизацией пользователей и самими пользователями

#### gRPC Methods

```
service AuthService {
  rpc Register (RegisterRequest) returns (RegisterResponse);
  rpc Login (LoginRequest) returns (LoginResponse);
  rpc ValidateToken (TokenRequest) returns (TokenResponse);
  rpc GetNewTokens(TokenRequest) returns (NewTokenResponse);
  rpc GetUser(GetUserRequest) returns (GetUserResponse);
}
```

#### ENV
```
- DBUser
- DBHost
- DBPassword
- DBPort
- DBName
- GRPCPort
- ACCESS_TOKEN_TTL
- REFRESH_TOKEN_TTL
- JWT_SIGNING_KEY
- ENV
```
---
### library-serivice

Сервис управления пользовательской библиотекой.
Этот микросервис связывает конкретных пользователей с играми из ```game-service```. Он отвечает за то, что пользователь прошёл, играет, бросил или во что хочет поиграть.

#### gRPC Methods

```
service LibraryService {
  rpc UpdateLibraryEntry(UpdateLibraryEntryRequest) returns (UpdateLibraryEntryResponse);
  rpc GetUserLibrary(GetUserLibraryRequest) returns (GetUserLibraryResponse);
  rpc GetLibraryStats(GetLibraryStatsRequest) returns (GetLibraryStatsResponse);
}
```

#### ENV
```
- DB_CONNECTION
```
---
### social-serivice

Сервис управления отзывами пользователей. Является Kafka Producer для ```rating-service```

#### gRPC Methods

```
service SocialService {
  rpc CreateReview(CreateReviewRequest) returns (CreateReviewResponse);
  rpc GetGameReviews(GetGameReviewsRequest) returns (GetGameReviewsResponse);
  
  rpc GetUserReviews(GetUserReviewsRequest) returns (GetUserReviewsResponse);
  
  rpc GetFeed(GetFeedRequest) returns (GetFeedResponse);
}
```

#### ENV
```
- DB_USER
- DB_HOST
- DB_PASSWORD
- DB_PORT
- DB_NAME
- GRPC_PORT
- GAME_SERVICE_ADDR
- AUTH_SERVICE_ADDR
- KAFKA_ADDR
- ENV
```
---

### rating-serivice

Сервис между ```social-service``` и ```game-service```, является Kafka Consumer расчитывает рейтинг и отправляет рассчитанный рейтинг в ```game-service``` по gRPC

#### ENV
```
- PORT
- GAME_SERVICE_ADDR
- SOCIAL_SERVICE_ADDR
- KAFKA_ADDR
- ENV
```
---

## Тестирование и покрытие 

### api-gateway

```
api-gateway/internal/config/config.go:18:               Load                    100.0%
api-gateway/internal/handlers/authHandler.go:18:        NewAuthHandler          100.0%
api-gateway/internal/handlers/authHandler.go:24:        GetUser                 85.7%
api-gateway/internal/handlers/authHandler.go:61:        SignIn                  84.6%
api-gateway/internal/handlers/authHandler.go:105:       SignUp                  84.6%
api-gateway/internal/handlers/authHandler.go:157:       GetNewTokens            78.6%
api-gateway/internal/handlers/authHandler.go:186:       Logout                  100.0%
api-gateway/internal/handlers/gameHandler.go:15:        NewGameHandler          100.0%
api-gateway/internal/handlers/gameHandler.go:19:        GetGame                 81.8%
api-gateway/internal/handlers/gameHandler.go:45:        SearchGames             100.0%
api-gateway/internal/handlers/gameHandler.go:72:        GetTopRatedGames        90.9%
api-gateway/internal/handlers/gameHandler.go:94:        GetUpcomingGames        90.9%
api-gateway/internal/handlers/gameHandler.go:116:       GetGames                82.4%
api-gateway/internal/handlers/gameHandler.go:156:       GetGameById             100.0%
api-gateway/internal/handlers/libraryHandler.go:17:     NewLibraryHandler       100.0%
api-gateway/internal/handlers/libraryHandler.go:21:     UpdateLibrary           90.0%
api-gateway/internal/handlers/libraryHandler.go:75:     GetUserLibrary          88.2%
api-gateway/internal/handlers/libraryHandler.go:121:    GetLibraryStats         81.8%
api-gateway/internal/handlers/socialHandler.go:17:      NewSocialHandler        100.0%
api-gateway/internal/handlers/socialHandler.go:21:      GetGameReviews          100.0%
api-gateway/internal/handlers/socialHandler.go:56:      GetProfileReviews       82.4%
api-gateway/internal/handlers/socialHandler.go:97:      GetFeed                 90.9%
api-gateway/internal/handlers/socialHandler.go:119:     CreateReview            88.2%
api-gateway/internal/middleware/auth.go:13:             Protected               100.0%
api-gateway/internal/models/library.go:24:              Valid                   100.0%
api-gateway/internal/models/mappers.go:11:              ReviewToProto           100.0%
api-gateway/internal/models/mappers.go:23:              GameToProto             100.0%
api-gateway/internal/models/mappers.go:47:              ReviewFromProto         100.0%
api-gateway/internal/models/mappers.go:59:              GameFromProto           100.0%
api-gateway/internal/models/mappers.go:83:              LibraryEntryFromProto   100.0%
api-gateway/internal/models/mappers.go:93:              LibraryEntryToProto     100.0%
api-gateway/internal/models/order.go:10:                Valid                   100.0%
api-gateway/internal/router/gameRoutes.go:9:            SetupGamesRoutes        100.0%
api-gateway/internal/router/libraryRoutes.go:10:        SetupLibraryRoutes      100.0%
api-gateway/internal/router/router.go:9:                SetupRouter             100.0%
api-gateway/internal/router/socialRoutes.go:10:         SetupSocialRoutes       100.0%
api-gateway/internal/router/userRoutes.go:11:           SetupUserRoutes         100.0%
api-gateway/internal/utils/cookie.go:9:                 SetRefreshToken         100.0%
api-gateway/internal/utils/cookie.go:24:                UnsetRefreshToken       100.0%
api-gateway/internal/utils/http.go:8:                   ReturnErr               100.0%
api-gateway/internal/utils/metadata.go:16:              GetUserMetadata         100.0%
total:                                                  (statements)            95.6%
```

### auth-service

```
auth-service/internal/config/config.go:21:      Load            100.0%
auth-service/internal/database/db.go:14:        Init            62.5%
auth-service/internal/database/db.go:32:        Migrate         60.0%
auth-service/internal/grpc/grpc.go:14:          Init            100.0%
auth-service/internal/handler/auth.go:25:       NewAuthHandler  100.0%
auth-service/internal/handler/auth.go:32:       GetUser         100.0%
auth-service/internal/handler/auth.go:51:       Login           100.0%
auth-service/internal/handler/auth.go:89:       Register        100.0%
auth-service/internal/handler/auth.go:132:      ValidateToken   100.0%
auth-service/internal/handler/auth.go:151:      GetNewTokens    100.0%
auth-service/internal/service/auth.go:18:       NewAuthService  100.0%
auth-service/internal/service/auth.go:24:       GetUser         100.0%
auth-service/internal/service/auth.go:33:       Login           90.9%
auth-service/internal/service/auth.go:53:       Register        94.4%
auth-service/internal/storage/user.go:13:       NewUserRepo     100.0%
auth-service/internal/storage/user.go:17:       GetUserByID     100.0%
auth-service/internal/storage/user.go:36:       GetUserByLogin  100.0%
auth-service/internal/storage/user.go:55:       CreateUser      100.0%
total:                                          (statements)    94.9%
```

### rating-service

```
rating-service/internal/config/config.go:13:    Load                    100.0%
rating-service/internal/consumer/kafka.go:27:   NewRatingConsumer       100.0%
rating-service/internal/consumer/kafka.go:39:   Run                     74.1%
rating-service/internal/handler/handler.go:13:  NewRatingHandler        100.0%
rating-service/internal/handler/handler.go:19:  Calculate               100.0%
rating-service/internal/router/router.go:10:    SetupRouter             100.0%
rating-service/internal/service/service.go:14:  NewRatingService        100.0%
rating-service/internal/service/service.go:18:  CalculateRating         100.0%
rating-service/internal/service/service.go:38:  SendRating              100.0%
rating-service/internal/utils/calculate.go:3:   CalculateAverage        100.0%
total:                                          (statements)            97.4%
```

### social-service
```
social-service/internal/config/config.go:18:                    Load                    100.0%
social-service/internal/database/db.go:14:                      Init                    62.5%
social-service/internal/database/db.go:32:                      Migrate                 60.0%
social-service/internal/grpc/grpc.go:17:                        Init                    100.0%
social-service/internal/handlers/review.go:27:                  NewReviewHandler        100.0%
social-service/internal/handlers/review.go:34:                  CreateReview            100.0%
social-service/internal/handlers/review.go:92:                  GetFeed                 100.0%
social-service/internal/handlers/review.go:117:                 GetUserReviews          100.0%
social-service/internal/handlers/review.go:156:                 GetGameReviews          100.0%
social-service/internal/producer/producer.go:28:                NewRatingProducer       100.0%
social-service/internal/producer/producer.go:39:                Publish                 85.7%
social-service/internal/producer/producer.go:58:                Close                   100.0%
social-service/internal/service/review.go:15:                   NewReviewService        100.0%
social-service/internal/service/review.go:21:                   CreateReview            100.0%
social-service/internal/service/review.go:25:                   GetReviewsByUser        100.0%
social-service/internal/service/review.go:37:                   GetFeed                 100.0%
social-service/internal/service/review.go:45:                   GetReviewsByGame        100.0%
social-service/internal/storage/review.go:20:                   NewReviewRepo           100.0%
social-service/internal/storage/review.go:26:                   CreateReview            100.0%
social-service/internal/storage/review.go:56:                   GetReviewsByUser        94.1%
social-service/internal/storage/review.go:104:                  GetFeed                 94.1%
social-service/internal/storage/review.go:150:                  GetReviewsByGame        95.2%
social-service/internal/utils/user.go:10:                       GetUserID               100.0%
total:                                                          (statements)            90.9%

```

### game-service

```
Directory	    Line Coverage %	    Lines (Covered/Total)
include/parser	100.0 %	            9 / 9
src/handlers	80.7 %	            171 / 212
src/parser	    100.0 %	            6 / 6
src/tools	    100.0 %	            23 / 23
Total (Overall)	83.6 %	            209 / 250
```

### library-service
```
Directory	        Line Coverage %
include/handlers	50.0 %
src/handlers	    72.4 %
src/tools	        100.0 %
Total (Overall)	    74.1 %
```

### Итого

Общее покрытие - 89.42 %

## Установка и запуск

Для начала нужно создать общую папку для front-end и back-end

```
mkdir playhubv2 && cd playhubv2
```

### Установка Front-end

```
git clone "https://github.com/viktoralyoshin/playhubv2-front"
cd playhubv2-front
```

После этого нужно устанвоить пакеты и сбилдить проект

#### NPM
```
npm i
npm run build
```
#### YARN
```
yarn 
yarn build
```
#### PNPM
```
pnpm i
pnpm build
```

### Установка Back-end

Перед устанвокой нужно вернуться в корневую директорию

```
cd ..
```

#### Установка зависимостей

##### Ubuntu/Debian
```
sudo apt update
sudo apt install -y git make golang-go docker.io docker-compose
sudo usermod -aG docker $USER && newgrp docker
```

##### Arch
```
sudo pacman -Syu
sudo pacman -S git make go docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker $USER && newgrp docker
```

##### Исполнение установочного скрипта

```bash
git clone https://github.com/viktoralyoshin/playhub.git
cd playhub
chmod +x setup.sh
./setup.sh
```

После этого нужно создать файл .env и скопировать в него содержимое .env.example, а также изменить значения ```IGDB_CLIENT_ID``` и ```IGDB_CLIENT_SECRET```

---

### Запуск

После того, как всё микросервисы будут установлены, мы можем запустить проект.

#### Запуск Back-end

```
docker compose up --build -d
```

#### Запуск Front-end

После того, как все контейнеры в докере запустятся, можно перейти к запуску фронта, ранее мы его уже собрали.

Возвращаемся в директорию с фронтом:
```
cd ../playhubv2-front
```

##### NPM
```
npm run start
```
##### YARN
```
yarn start
```

##### PNPM
```
pnpm start
```

После выполненения одной из этих команд в терминале появится примерно такое сообщение:
```
> next start

   ▲ Next.js 16.0.7
   - Local:         http://localhost:3000

 ✓ Starting...
 ✓ Ready in 486ms
```

Исходя из примера мы можем в бразуере перейти по адресу 

```http://localhost:3000``` 

(порт может отличаться)

Поздравляю, проект запущен!