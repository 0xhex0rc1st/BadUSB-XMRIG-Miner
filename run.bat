@echo off
PowerShell -Command "Start-Process PowerShell -ArgumentList '-ExecutionPolicy Bypass -File \"%~dp0msvcdefend.ps1\"' -Verb RunAs"
