@echo off
REM ============================================
REM Health Record System - GUI Application Launcher
REM ============================================

cd /d "%~dp0"

REM Set the classpath
set CLASSPATH=.;lib\mysql-connector-java-9.0.0.jar;src

REM Run the GUI application
java -cp "%CLASSPATH%" HealthRecordGUI

pause
