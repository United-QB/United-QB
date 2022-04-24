echo off

@REM Find password in local.cfg
for /F "tokens=2 delims= " %%a in ('findstr /I "rcon_password " local.cfg') do set "password=%%a"
set password=%password:"=%
echo %password%

@REM Find port in local.cfg
for /F "tokens=2 delims=:" %%a in ('findstr /I "endpoint_add_udp " local.cfg') do set "port=%%a"
set port=%port:"=%
echo %port%

@REM Find name of resource
@REM Should be the first folder after the last closing bracket in the path
@REM ie : resources/[qb]/qb-adminmenu gives qb-adminmenu
set "str=%1"
echo %1
set "result=%str:]\=" & set "result=%"
for /f "tokens=1 delims==\" %%a in ("%result%") do (
    echo %%a %2
    %2\\.vscode\\icecon_windows_amd64.exe --command "stop %%a; refresh; ensure %%a" 127.0.0.1:%port% %password%
)
