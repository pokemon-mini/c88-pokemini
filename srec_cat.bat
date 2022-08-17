@ECHO off
if exist "%~dp0\bin-windows\srec_cat.exe" (
	"%~dp0\bin-windows\srec_cat.exe" %*
) else (
	start /D "%CD%" /unix /bin/sh -c "srec_cat %* >&2"
)
