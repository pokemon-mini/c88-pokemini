@ECHO off
SETLOCAL
SET files=%*
del %files:/=\% 2>nul
