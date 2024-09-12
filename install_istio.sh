#!/bin/bash

# Versión de Istio a descargar
ISTIO_VERSION="1.17.2"

# Guardar el directorio actual (ruta base)
BASE_DIR=$(pwd)

# Detectar el sistema operativo
OS_TYPE=$(uname -s)

# Paso 1: Determinar la URL correcta según el sistema operativo
case "$OS_TYPE" in
  Linux*)   
    OS="linux-amd64" 
    EXT="tar.gz"
    EXTRACT_CMD="tar -xzf" 
    ISTIOCTL_BIN="istioctl"
    ;;
  Darwin*)  
    OS="osx" 
    EXT="tar.gz"
    EXTRACT_CMD="tar -xzf" 
    ISTIOCTL_BIN="istioctl"
    ;;
  MINGW* | CYGWIN* | MSYS*)
    OS="win"
    EXT="zip"
    EXTRACT_CMD="unzip"
    ISTIOCTL_BIN="istioctl.exe"
    ;;
  *)
    echo "Sistema operativo no compatible: $OS_TYPE"
    exit 1
    ;;
esac

# Paso 2: Descargar Istio
echo "Descargando Istio versión $ISTIO_VERSION para $OS..."
curl -L https://github.com/istio/istio/releases/download/$ISTIO_VERSION/istio-$ISTIO_VERSION-$OS.$EXT -o istio-$ISTIO_VERSION-$OS.$EXT

# Verificar si la descarga fue exitosa
if [ ! -f "istio-$ISTIO_VERSION-$OS.$EXT" ]; then
    echo "Error: No se pudo descargar Istio $ISTIO_VERSION. Verifique su conexión a Internet o intente más tarde."
    exit 1
fi

# Paso 3: Extraer los archivos
echo "Extrayendo Istio..."
$EXTRACT_CMD istio-$ISTIO_VERSION-$OS.$EXT

# Cambiar al directorio de Istio extraído
cd "istio-$ISTIO_VERSION" || exit

# Paso 4: Agregar Istio al PATH
export PATH=$PWD/bin:$PATH

# Paso 5: Instalar Istio en el clúster con el perfil por defecto
echo "Instalando Istio en Kubernetes..."
$ISTIOCTL_BIN install --set profile=default -y

# Paso 6: Verificar que los pods de Istio están corriendo
echo "Verificando los pods de Istio..."
kubectl get pods -n istio-system

# Volver al directorio base
cd "$BASE_DIR"

# Paso 7: Aplicar la regla DestinationRule desde la carpeta k8s
echo "Aplicando DestinationRule desde $BASE_DIR/k8s/istio-destination-rule.yaml"
if [ -f "$BASE_DIR/k8s/istio-destination-rule.yaml" ]; then
  kubectl apply -f "$BASE_DIR/k8s/istio-destination-rule.yaml"
else
  echo "Error: el archivo k8s/istio-destination-rule.yaml no existe en $BASE_DIR."
fi

echo "¡Instalación completada!"
