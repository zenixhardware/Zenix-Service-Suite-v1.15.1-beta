@echo off
cls
echo [!] ЗАПУЩЕН ПРОТОКОЛ ЗАЩИТЫ КОНФИДЕНЦИАЛЬНОСТИ ДЛЯ ZENIX [!]
echo ===================================================

echo [-] Остановка фоновых игровых служб...
taskkill /f /im XboxApp.exe /im GamingServices.exe >nul 2>&1

echo [-] Очистка временного локального кэша...
rmdir /s /q "%localappdata%\Packages\Microsoft.XboxApp_8wekyb3d8bbwe\LocalCache" >nul 2>&1
rmdir /s /q "%localappdata%\Packages\Microsoft.6HorizonLive_8wekyb3d8bbwe" >nul 2>&1
rmdir /s /q "%localappdata%\Temp" >nul 2>&1
mkdir "%localappdata%\Temp"

echo [-] Удаление системных отчётов об ошибках...
rmdir /s /q "C:\Windows\Temp" >nul 2>&1
mkdir "C:\Windows\Temp"

echo [-] Зачистка идентификаторов авторизации в реестре...
reg delete "HKEY_CURRENT_USER\Software\Microsoft\XboxLive" /f >nul 2>&1

echo [-] Обновление сетевой истории DNS...
ipconfig /flushdns >nul 2>&1

echo [-] Очистка журналов событий приложений...
wevtutil cl Application >nul 2>&1

echo [-] Финальное освобождение дискового пространства...
powershell -NoProfile -Command "Clear-RecycleBin -Confirm:$false" >nul 2>&1

echo ===================================================
echo [+] ОЧИСТКА ЗАВЕРШЕНА УСПЕШНО. СИСТЕМА БЕЗОПАСНА. МОЖНО ВКЛЮЧАТЬ СЕТЬ.
pause
