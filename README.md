# Playhub

## Архитектура системы

## Спецификация сервисов

## Тестирование и покрытие 

## 📦 Установка и запуск

### Способ 1: Автоматическая установка

#### Установка зависимостей

#### Ubuntu/Debian
```
sudo apt update
sudo apt install -y git make golang-go docker.io docker-compose
sudo usermod -aG docker $USER && newgrp docker
```

#### Arch
```
sudo pacman -Syu
sudo pacman -S git make go docker docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker $USER && newgrp docker
```

#### Исполнения установочного скрипта

```bash
git clone https://github.com/viktoralyoshin/playhub.git
cd playhub
chmod +x setup.sh
./setup.sh
```

---

### Способ 2: Ручная установка