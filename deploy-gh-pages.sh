#!/bin/bash

# 🚀 Script para desplegar documentación en GitHub Pages
# Autor: Asistente IA
# Fecha: 25 de Agosto de 2025

echo "🚀 Desplegando documentación CRM en GitHub Pages..."

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Verificar si estamos en el directorio correcto
if [ ! -f "docusaurus.config.ts" ]; then
    echo -e "${RED}❌ No estás en el directorio correcto. Ve a /tmp/docs-crm${NC}"
    exit 1
fi

echo -e "${BLUE}📋 Paso 1: Compilando documentación...${NC}"
npm run build

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Error al compilar. Verifica que npm esté funcionando.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Documentación compilada correctamente${NC}"

echo -e "${BLUE}📋 Paso 2: Creando rama gh-pages...${NC}"
git checkout -b gh-pages 2>/dev/null || git checkout gh-pages

echo -e "${BLUE}📋 Paso 3: Limpiando rama gh-pages...${NC}"
git rm -rf . --ignore-unmatch

echo -e "${BLUE}📋 Paso 4: Moviendo documentación compilada...${NC}"
cp -r build/* . 2>/dev/null || true
cp -r build/.* . 2>/dev/null || true

echo -e "${BLUE}📋 Paso 5: Agregando archivos...${NC}"
git add .

echo -e "${BLUE}📋 Paso 6: Haciendo commit...${NC}"
git commit -m "🚀 Documentación CRM desplegada en GitHub Pages"

echo -e "${BLUE}📋 Paso 7: Subiendo a GitHub...${NC}"
git push origin gh-pages --force

if [ $? -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Éxito! Documentación subida a GitHub Pages${NC}"
    echo ""
    echo -e "${BLUE}📋 Paso 8: Configurar GitHub Pages${NC}"
    echo -e "${YELLOW}   1. Ve a: https://github.com/carlos2325/docs-crm-marketing${NC}"
    echo -e "${YELLOW}   2. Click en 'Settings'${NC}"
    echo -e "${YELLOW}   3. Scroll down hasta 'Pages'${NC}"
    echo -e "${YELLOW}   4. Source: Deploy from a branch${NC}"
    echo -e "${YELLOW}   5. Branch: gh-pages${NC}"
    echo -e "${YELLOW}   6. Folder: / (root)${NC}"
    echo -e "${YELLOW}   7. Click 'Save'${NC}"
    echo ""
    echo -e "${GREEN}🌐 URL final para compartir:${NC}"
    echo -e "${BLUE}   📚 Documentación: https://carlos2325.github.io/docs-crm-marketing/${NC}"
    echo ""
    echo -e "${GREEN}�� ¡Listo! Tu equipo puede acceder a la documentación${NC}"
    
else
    echo -e "${RED}❌ Error al subir a GitHub. Verifica que el repositorio exista.${NC}"
fi

# Volver a la rama main
echo -e "${BLUE}📋 Volviendo a rama main...${NC}"
git checkout main
