# Instalador de Aplicaciones para Windows

Este script de lote (batch) está diseñado para facilitar la instalación de aplicaciones en sistemas Windows. Automatiza el proceso de instalación de aplicaciones de la Microsoft Store y otras fuentes en equipos con Windows 10.

## Requisitos

- Sistema operativo: Windows 10 versión 1709 o posterior.
- Acceso de administrador para ejecutar el script.

## Uso

1. Ejecute el script como administrador.
2. Siga las instrucciones en pantalla para agregar las aplicaciones especificadas al sistema.

## Archivos Necesarios

Asegúrese de tener los siguientes archivos en el mismo directorio que el script:

- `*WindowsStore*.appxbundle`: Paquete de la aplicación de la Microsoft Store.
- `*WindowsStore*.xml`: Archivo de licencia para la Microsoft Store.

Si desea instalar aplicaciones adicionales, asegúrese de tener los archivos correspondientes y siga las convenciones de nomenclatura utilizadas en el script.

## Advertencias

- **Permisos de Administrador**: Es necesario ejecutar el script con privilegios de administrador para instalar las aplicaciones correctamente.
- **Compatibilidad**: Este script está diseñado para sistemas Windows 10 versión 1709 y posteriores. No se garantiza su funcionamiento en otras versiones del sistema operativo.

## Contribuciones

Si desea contribuir a este proyecto, siéntase libre de enviar solicitudes de extracción (pull requests) o informar problemas (issues) en el repositorio.

## Licencia

Este script se proporciona bajo la [Licencia MIT](LICENSE).
