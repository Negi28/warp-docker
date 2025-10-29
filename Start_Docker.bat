@echo off
setlocal enabledelayedexpansion

echo === Starting docker compose ===
docker compose up -d

echo === Waiting 10 seconds for mount... ===
timeout /t 10 /nobreak >nul

REM Khởi tạo biến
set COUNT=0
set MAX=3
set CONTAINER_NAME=warp1
set SCRIPT_PATH=/home/warp/KIIP_251028_Linux_Server_1_User1/run.sh

echo === Start script in container %CONTAINER_NAME% ===
:while_loop1
set /a COUNT+=1
if !COUNT! leq %MAX% (
    docker exec %CONTAINER_NAME% sh -c "test -f !SCRIPT_PATH!"

    if !ERRORLEVEL! == 0 (
        echo Script found in %CONTAINER_NAME%! Running script...
        docker exec %CONTAINER_NAME% sh !SCRIPT_PATH!
    ) else (
        echo Sript not found in container %CONTAINER_NAME%, retrying !COUNT!...
        timeout /t 5 /nobreak >nul
        goto while_loop1
    )
)

REM Reset variable for next container
set COUNT=0
set CONTAINER_NAME=warp2
echo === Start script in container %CONTAINER_NAME% ===
:while_loop2
set /a COUNT+=1
if !COUNT! leq %MAX% (
    docker exec %CONTAINER_NAME% sh -c "test -f !SCRIPT_PATH!"

    if !ERRORLEVEL! == 0 (
        echo Script found in %CONTAINER_NAME%! Running script...
        docker exec %CONTAINER_NAME% sh !SCRIPT_PATH!
    ) else (
        echo Sript not found in container %CONTAINER_NAME%, retrying !COUNT!...
        timeout /t 5 /nobreak >nul
        goto while_loop2
    )
)

REM Reset variable for next container
set COUNT=0
set CONTAINER_NAME=warp3
echo === Start script in container %CONTAINER_NAME% ===
:while_loop3
set /a COUNT+=1
if !COUNT! leq %MAX% (
    docker exec %CONTAINER_NAME% sh -c "test -f !SCRIPT_PATH!"

    if !ERRORLEVEL! == 0 (
        echo Script found in %CONTAINER_NAME%! Running script...
        docker exec %CONTAINER_NAME% sh !SCRIPT_PATH!
    ) else (
        echo Sript not found in container %CONTAINER_NAME%, retrying !COUNT!...
        timeout /t 5 /nobreak >nul
        goto while_loop3
    )
)
pause