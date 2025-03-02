
# 🎬 TMDBMovies - App de Películas con SwiftUI & Firebase

Bienvenido a **TMDBMovies**, una aplicación desarrollada en **SwiftUI** con integración de **Firebase** y consumo de la API de **TMDB** para mostrar películas populares.

---

## Características

✅ **Autenticación con Firebase** (Registro, Login, Logout)  
✅ **Persistencia local con CoreData** (para mantener sesión iniciada)  
✅ **Consumo de la API de TMDB** para mostrar películas populares  
✅ **Búsqueda de películas** por título  
✅ **Diseño con SwiftUI** y navegación intuitiva  
✅ **Modo Grid (2 columnas) en la lista de películas**  
✅ **Soporte para imágenes con `AsyncImage`**  

---

## Tecnologías usadas

- **Swift 5**
- **SwiftUI**
- **Firebase (Auth & Firestore)**
- **CoreData**
- **URLSession (para llamadas HTTP a TMDB API)**
- **MVVM Architecture**

---

## Instalación

### **1️⃣ Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/TMDBMovies.git
cd TMDBMovies
```

### **2️⃣ Agregar Firebase a tu proyecto**
- Entra a Firebase Console
- Crea un nuevo proyecto o usa uno existente
- Añade una app iOS con el Bundle ID del proyecto
- Descarga el archivo GoogleService-Info.plist
- Colócalo dentro del proyecto en Xcode (TMDBMovies/GoogleService-Info.plist)


### **3️⃣ Configurar API de TMDB**
- Crea una cuenta en TMDB
- Obtén tu API Key desde "API Settings"
- En Xcode, crea un archivo Secrets.swift en TMDBMovies/ y agrega:
```switch
struct Secrets {
    static let tmdbApiKey = "TU_API_KEY"
}
```

### **4️⃣ Uso de la app**
1. Ejecutar la app en el simulador:

```bash
Cmd + R  # En Xcode
```
2. Registrarse o iniciar sesión con Firebase
3. Explorar películas populares desde la API de TMDB
4. Buscar películas en la lista
5. Ver detalles de cada película
6. Cerrar sesión (se eliminará de CoreData)

