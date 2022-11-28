@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Rebuild app container. Are you sure (y/[n])?
IF /I "%AREYOUSURE%" NEQ "y" GOTO END

docker-compose -f ../docker/docker-compose.yml -p "p001" up -d --no-deps --build app

:END
endlocal