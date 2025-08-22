#!/bin/bash

# 🚀 Script para crear el repositorio y subir la documentación del CRM
# Autor: Asistente IA
# Fecha: 22 de Agosto de 2025

echo "🚀 Iniciando creación del repositorio de documentación CRM..."

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Verificar si git está instalado
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git no está instalado. Por favor instala Git primero.${NC}"
    exit 1
fi

# Verificar si estamos en el directorio correcto
if [ ! -f "docusaurus.config.ts" ]; then
    echo -e "${RED}❌ No estás en el directorio correcto. Ve a /tmp/docs-crm${NC}"
    exit 1
fi

echo -e "${BLUE}📋 Paso 1: Crear repositorio en GitHub...${NC}"
echo -e "${YELLOW}⚠️  IMPORTANTE: Debes crear el repositorio manualmente en GitHub${NC}"
echo -e "${YELLOW}   1. Ve a: https://github.com/marketingsoluciones${NC}"
echo -e "${YELLOW}   2. Click en 'New repository'${NC}"
echo -e "${YELLOW}   3. Nombre: docs-crm-marketing${NC}"
echo -e "${YELLOW}   4. Descripción: Documentación completa del sistema CRM - Equipo Marketing Soluciones${NC}"
echo -e "${YELLOW}   5. Visibility: Private${NC}"
echo -e "${YELLOW}   6. Initialize with README: ✅${NC}"
echo -e "${YELLOW}   7. Click 'Create repository'${NC}"

echo ""
read -p "🚀 ¿Ya creaste el repositorio? Presiona Enter para continuar..."

echo -e "${BLUE}🔧 Paso 2: Configurar Git...${NC}"

# Inicializar Git
git init

# Configurar remote
git remote add origin https://github.com/marketingsoluciones/docs-crm-marketing.git

# Verificar remote
echo -e "${GREEN}✅ Remote configurado:${NC}"
git remote -v

echo -e "${BLUE}📝 Paso 3: Agregar archivos...${NC}"

# Agregar todos los archivos
git add .

echo -e "${BLUE}💾 Paso 4: Hacer commit...${NC}"

# Hacer commit
git commit -m "🚀 Documentación inicial del CRM - Equipo Marketing Soluciones"

echo -e "${BLUE}🚀 Paso 5: Subir a GitHub...${NC}"

# Subir a GitHub
git push -u origin main

if [ $? -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Éxito! Código subido a GitHub${NC}"
    echo ""
    echo -e "${BLUE}📋 Paso 6: Configurar GitHub Pages${NC}"
    echo -e "${YELLOW}   1. Ve a: https://github.com/marketingsoluciones/docs-crm-marketing${NC}"
    echo -e "${YELLOW}   2. Click en 'Settings'${NC}"
    echo -e "${YELLOW}   3. Scroll down hasta 'Pages'${NC}"
    echo -e "${YELLOW}   4. Source: Deploy from a branch${NC}"
    echo -e "${YELLOW}   5. Branch: main${NC}"
    echo -e "${YELLOW}   6. Folder: / (root)${NC}"
    echo -e "${YELLOW}   7. Click 'Save'${NC}"
    echo ""
    echo -e "${GREEN}🌐 URLs finales para compartir:${NC}"
    echo -e "${BLUE}   📚 Documentación: https://marketingsoluciones.github.io/docs-crm-marketing/${NC}"
    echo -e "${BLUE}   🔧 Repositorio: https://github.com/marketingsoluciones/docs-crm-marketing${NC}"
    echo ""
    echo -e "${GREEN}🎯 ¡Listo! Tu equipo puede acceder a la documentación${NC}"
else
    echo -e "${RED}❌ Error al subir a GitHub. Verifica que el repositorio exista.${NC}"
fi
