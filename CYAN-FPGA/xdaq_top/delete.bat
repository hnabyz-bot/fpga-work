@echo off
forfiles /S /M *.bak /C "cmd /c del @file"
forfiles /S /M *.*~ /C "cmd /c del @file"