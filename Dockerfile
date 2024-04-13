# Establecer la imagen base como la imagen de Maven
FROM maven:3.9.6-eclipse-temurin-17-focal AS build

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar solo el archivo pom.xml al directorio de trabajo del contenedor
COPY pom.xml .

# Copiar el resto del código fuente al directorio de trabajo del contenedor
COPY src ./src

# Compilar la aplicación usando Maven
RUN mvn clean package -DskipTests

# Segunda etapa del Dockerfile para la ejecución
FROM maven:3.9.6-eclipse-temurin-17-focal

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar solo el archivo JAR compilado desde la etapa de compilación anterior al directorio de trabajo del contenedor
COPY --from=build /app/target/crud-0.0.1-SNAPSHOT.jar java-app.jar

# Establecer el comando de inicio para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "java-app.jar"]

