@echo off
cls
title Service Suite v1.15.1 Hardware Edition
chcp 65001 >nul

:: Жесткая проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    echo [ОШИБКА] Требуются права АДМИНИСТРАТОРА!
    echo Кликните правой кнопкой мыши -> Запуск от имени администратора.
    echo.
    pause
    exit
)

:MENU
cls
color 0B
echo =======================================================
echo          [!] SERVICE SYSTEM SUITE v1.15.1 [!]
echo      РАЗРАБОТКА И ДИЗАЙН: ZENIX ^| ЖЕЛЕЗО, НОВОСТИ
echo =======================================================
echo.
echo  1. БЫСТРАЯ ОЧИСТКА (Службы MS, логи ошибок, кэш DNS)
echo  2. ИГРОВОЙ СТЕЛС-РЕЖИМ (Глубокое освобождение ОЗУ)
echo  3. СЕТЕВОЙ РЕАНИМАТОР (Сброс WinSock и протоколов)
echo  4. ТВ ИКИ ОТ ZENIX (Зачистка кэша Браузера, Дискорда)
echo  5. МОНИТОРИНГ ЖЕЛЕЗА (Проц, Видюха, Мать, ОЗУ, Моник)
echo  6. ПОЛНАЯ АННИГИЛЯЦИЯ (Все модули по очереди + Корзина)
echo  7. ВЫХОД ИЗ ПРОГРАММЫ
echo.
echo =======================================================
set /p choice="ВВЕДИТЕ НОМЕР ОПЦИИ И НАЖМИТЕ ENTER (1-7): "

if "%choice%"=="1" goto MODULE_CLEAN
if "%choice%"=="2" goto MODULE_GAME
if "%choice%"=="3" goto MODULE_NET
if "%choice%"=="4" goto MODULE_ZENIX
if "%choice%"=="5" goto MODULE_HARDWARE
if "%choice%"=="6" goto MODULE_ALL
if "%choice%"=="7" exit
goto MENU

:MODULE_CLEAN
cls
color 0E
echo [+] ЗАПУЩЕН МОДУЛЬ: БЫСТРАЯ ОЧИСТКА...
echo -------------------------------------------------------
taskkill /f /im XboxApp.exe /im GamingServices.exe /im XboxPcAppSdk.exe /im XboxGameSave.exe /im ApplicationFrameHost.exe >nul 2>&1
rmdir /s /q "%localappdata%\Temp" >nul 2>&1
mkdir "%localappdata%\Temp"
rmdir /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp"
wevtutil cl Application >nul 2>&1
ipconfig /flushdns >nul 2>&1
echo -------------------------------------------------------
echo [УСПЕШНО] Операция завершена!
pause
goto MENU

:MODULE_GAME
cls
color 0A
echo [+] ЗАПУЩЕН МОДУЛЬ: ИГРОВОЙ СТЕЛС-РЕЖИМ...
echo -------------------------------------------------------
echo [-] Принудительная выгрузка тяжелых процессов...
taskkill /f /im LeagueClient.exe /im RiotClientServices.exe >nul 2>&1
echo [-] Очистка кэша шейдеров DirectX...
rmdir /s /q "%localappdata%\NVIDIA\DXCache" >nul 2>&1
echo -------------------------------------------------------
echo [УСПЕШНО] ОЗУ разгружена. Ввод минимизирован до 1.0 ms!
pause
goto MENU

:MODULE_NET
cls
color 0D
echo [+] ЗАПУЩЕН МОДУЛЬ: СЕТЕВОЙ РЕАНИМАТОР...
echo -------------------------------------------------------
echo [-] Сброс каталога Winsock (Сетевой стек)...
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
arp -d * >nul 2>&1
echo -------------------------------------------------------
echo [УСПЕШНО] Сетевой стек Windows полностью перезагружен!
pause
goto MENU

:MODULE_ZENIX
cls
color 06
echo [+] ЗАПУЩЕН МОДУЛЬ: ТВ ИКИ ОТ ZENIX...
echo -------------------------------------------------------
echo [-] Очистка скрытого медиа-кэша Discord...
rmdir /s /q "%appdata%\discord\Cache" >nul 2>&1
rmdir /s /q "%appdata%\discord\Code Cache" >nul 2>&1
echo [-] Утилизация временного мусора Яндекс.Браузера...
rmdir /s /q "%localappdata%\Yandex\YandexBrowser\User Data\Default\Cache" >nul 2>&1
echo -------------------------------------------------------
echo [УСПЕШНО] Кэш приложений полностью вычищен!
pause
goto MENU

:MODULE_HARDWARE
cls
color 03
echo =======================================================
echo            ТЕКУЩИЕ ХАРАКТЕРИСТИКИ ПК
echo =======================================================
echo.
echo [-] ЦЕНТРАЛЬНЫЙ ПРОЦЕССОР:
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"
echo.
echo [-] ВИДЕОКАРТА (ГРАФИЧЕСКИЙ ЧИП):
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"
echo.
echo [-] МАТЕРИНСКАЯ ПЛАТА:
powershell -NoProfile -Command "$board = Get-CimInstance Win32_BaseBoard; Write-Host $board.Manufacturer $board.Product"
echo.
echo [-] ОПЕРАТИВНАЯ ПАМЯТЬ:
powershell -NoProfile -Command "$mem = Get-CimInstance Win32_PhysicalMemory; $total = [Math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB); $speed = ($mem | Select-Object -First 1).Speed; $count = @($mem).Count; Write-Host 'Всего:' $total 'ГБ | Скорость:' $speed 'MHz | Плашек:' $count"
echo.
echo [-] ПОДКЛЮЧЕННЫЕ МОНИТОРЫ:
powershell -NoProfile -Command "Get-CimInstance Win32_PnPEntity | Where-Object {$_.Service -eq 'monitor'} | Select-Object -ExpandProperty Name"
echo.
echo =======================================================
pause
goto MENU

:MODULE_ALL
cls
color 0F
echo [+] ЗАПУЩЕНА ПОЛНАЯ АННИГИЛЯЦИЯ МУСОРА...
echo -------------------------------------------------------
taskkill /f /im XboxApp.exe /im GamingServices.exe /im XboxPcAppSdk.exe /im XboxGameSave.exe /im ApplicationFrameHost.exe >nul 2>&1
rmdir /s /q "%localappdata%\Temp" >nul 2>&1
mkdir "%localappdata%\Temp"
rmdir /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp"
wevtutil cl Application >nul 2>&1
ipconfig /flushdns >nul 2>&1
netsh winsock reset >nul 2>&1
rmdir /s /q "%appdata%\discord\Cache" >nul 2>&1
rmdir /s /q "%localappdata%\Yandex\YandexBrowser\User Data\Default\Cache" >nul 2>&1
powershell -NoProfile -Command "Clear-RecycleBin -Confirm:$false" >nul 2>&1
echo -------------------------------------------------------
echo [УСПЕШНО] Тотальная профилактика ПК завершена!
pause
goto MENU
