@echo on

REM Java 9 does not work with Mockito mockmaker.
set JAVA_HOME=c:\program files\java\jdk1.8.0_152
set PATH=%JAVA_HOME%\bin;%PATH%

cd github/skaffold-java

REM Stops any left-over containers.
REM FOR /f "tokens=*" %%i IN ('docker ps -q') DO docker rm -vf %%i

REM TODO: Enable integration tests once docker works (b/73345382).
cd skaffold-plugins-core && call gradlew.bat clean build --info --stacktrace && ^
cd ../skaffold-maven-plugin && call mvnw.cmd clean install -B -U -X && ^
cd ../skaffold-gradle-plugin && call gradlew.bat clean build --info --stacktrace

exit /b %ERRORLEVEL%
