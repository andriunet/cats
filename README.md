# Cat Gallery App

Este proyecto es una aplicación de iOS llamada **Cat Gallery**, diseñada para mostrar una galería de gatos con su información detallada, incluyendo imágenes, etiquetas y propietario. La app permite a los usuarios buscar gatos por etiquetas y nombres de propietarios, navegar a través de una lista de gatos y ver detalles completos en una pantalla secundaria.

## Características

- **Galería de Gatos**: Visualiza una lista de gatos con sus imágenes y detalles.
- **Búsqueda**: Filtra los gatos por etiquetas o propietarios.
- **Vista Detallada**: Al seleccionar un gato, puedes ver información detallada como:
  - Imagen (si está disponible)
  - Etiquetas asociadas
  - Nombre del propietario
  - Fechas de creación y actualización
- **Interfaz Moderna**: Diseño atractivo con un toque moderno utilizando SwiftUI.
  
## Tecnologías Utilizadas

- **Swift**: El lenguaje de programación principal.
- **SwiftUI**: Para la creación de la interfaz de usuario.
- **Combine**: Para el manejo de datos reactivos.
- **NSCache**: Para guardar las imagenes en cache.
- **Async/Await**: Utilizado para la carga asíncrona de datos e imágenes.
- **Xcode**: Herramienta de desarrollo utilizada.

## Requisitos

- Xcode 13 o superior
- iOS 14 o superior

## Instalación

1. Clona este repositorio:
    ```bash
    git clone https://github.com/tu-usuario/cat-gallery.git
    ```

2. Abre el proyecto en Xcode.

3. Ejecuta la aplicación en tu simulador o dispositivo iOS.

## Funcionalidad

### CatListView

La vista principal de la app muestra una lista de gatos que pueden ser filtrados mediante una barra de búsqueda. Cuando se selecciona un gato, se navega a su vista de detalles.

### CatDetailView

Una vista detallada que muestra más información sobre el gato seleccionado, incluyendo su imagen (si está disponible), las etiquetas asociadas, el propietario y las fechas de creación y actualización.

### Barra de Búsqueda

La barra de búsqueda permite filtrar los gatos por etiquetas o propietarios, haciendo que la experiencia sea más dinámica.

## Estructura del Proyecto

- **CatListView**: Muestra la lista de gatos y permite la búsqueda.
- **CatDetailView**: Muestra los detalles de un gato.
- **CatRowView**: Presenta la información básica de cada gato en la lista.
- **SearchBar**: Componente reutilizable de la barra de búsqueda.
- **CatAPIService**: Servicio encargado de manejar las peticiones de la API para obtener los gatos y sus imágenes.


## Email 📧

andresmarin@icloud.com
---


iPhone

<table>
<tbody>
<tr>
<td><img src="https://github.com/andriunet/cats/blob/main/ScreenShot1.png"/></td>
<td><img src="https://github.com/andriunet/cats/blob/main/ScreenShot2.png"/></td>
</tr>
</tbody>
</table>

iPad

<table>
<tbody>
<tr>
<td><img src="https://github.com/andriunet/cats/blob/main/ScreenShot1_iPad.png"/></td>
<td><img src="https://github.com/andriunet/cats/blob/main/ScreenShot2_iPad.png"/></td>
</tr>
</tbody>
</table>


