@echo off
REM Comprobar la versión de Windows
for /f "tokens=6 delims=[]. " %%G in ('ver') do if %%G lss 16299 goto :version

REM Comprobar los permisos de administrador
%windir%\system32\reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || goto :uac

REM Habilitar las extensiones locales
setlocal enableextensions

REM Determinar la arquitectura del procesador
if /i "%PROCESSOR_ARCHITECTURE%" equ "AMD64" (set "arch=x64") else (set "arch=x86")
cd /d "%~dp0"

REM Comprobar la existencia de archivos necesarios
if not exist "*WindowsStore*.appxbundle" goto :nofiles
if not exist "*WindowsStore*.xml" goto :nofiles

REM Definir dependencias según la arquitectura
if /i %arch%==x64 (
    set "Dependencias=%VCLibsX64%,%VCLibsX86%,%Framework6X64%,%Framework6X86%,%Runtime6X64%,%Runtime6X86%"
) else (
    set "Dependencias=%VCLibsX86%,%Framework6X86%,%Runtime6X86%"
)

REM Verificar la existencia de dependencias
for %%i in (%Dependencias%) do (
    if not exist "%%i" goto :nofiles
)

REM Instalación de aplicaciones
echo.
echo ============================================================
echo Agregando Microsoft Store
echo ============================================================
echo.
1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %Store% -DependencyPackagePath %Dependencias% -LicensePath Microsoft.WindowsStore_8wekyb3d8bbwe.xml
for %%i in (%Dependencias%) do (
    %PScommand% Add-AppxPackage -Path %%i
)
%PScommand% Add-AppxPackage -Path %Store%

REM Instalación de otras aplicaciones si están definidas
if defined PurchaseApp (
    echo.
    echo ============================================================
    echo Agregando Aplicación de Compra en la Tienda
    echo ============================================================
    echo.
    1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %PurchaseApp% -DependencyPackagePath %Dependencias% -LicensePath Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml
    %PScommand% Add-AppxPackage -Path %PurchaseApp%
)
if defined AppInstaller (
    echo.
    echo ============================================================
    echo Agregando Instalador de Aplicaciones
    echo ============================================================
    echo.
    1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %AppInstaller% -DependencyPackagePath %Dependencias% -LicensePath Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml
    %PScommand% Add-AppxPackage -Path %AppInstaller%
)
if defined XboxIdentity (
    echo.
    echo ============================================================
    echo Agregando Proveedor de Identidad de Xbox
    echo ============================================================
    echo.
    1>nul 2>nul %PScommand% Add-AppxProvisionedPackage -Online -PackagePath %XboxIdentity% -DependencyPackagePath %Dependencias% -LicensePath Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml
    %PScommand% Add-AppxPackage -Path %XboxIdentity%
)

REM Fin del script
goto :fin

:uac
echo.
echo ============================================================
echo Error: Ejecute el script como administrador
echo ============================================================
echo.
echo.
echo Presione cualquier tecla para salir
pause >nul
exit

:version
echo.
echo ============================================================
echo Error: Este paquete es para Windows 10 versión 1709 y posterior
echo ============================================================
echo.
echo.
echo Presione cualquier tecla para salir
pause >nul
exit

:nofiles
echo.
echo ============================================================
echo Error: Archivos requeridos no se encuentran en el directorio actual
echo ============================================================
echo.
echo.
echo Presione cualquier tecla para salir
pause >nul
exit

:fin
echo.
echo ============================================================
echo Hecho
echo ============================================================
echo.
echo Presione cualquier tecla para salir.
pause >nul
exit
