if exist "%PRODDIR%\..\bin-windows\srec_cat.exe" (
	"%PRODDIR%\..\bin-windows\srec_cat.exe" %*
) else (
	start /D "%CD%" /unix /bin/sh -c "srec_cat %* >&2"
)
