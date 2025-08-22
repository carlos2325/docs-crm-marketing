#!/bin/bash

# 🚀 Script para crear el repositorio automáticamente usando token de GitHub
# Autor: Asistente IA
# Fecha: 22 de Agosto de 2025

echo "🚀 Iniciando creación automática del repositorio de documentación CRM..."

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

# Solicitar token de GitHub
echo -e "${BLUE}🔑 Paso 1: Configurar token de GitHub...${NC}"
echo -e "${YELLOW}⚠️  Necesito tu token de GitHub para crear el repositorio automáticamente${NC}"
echo -e "${YELLOW}   Si no tienes uno, ve a: https://github.com/settings/tokens${NC}"
echo -e "${YELLOW}   Crea un token con permisos: repo, admin:org${NC}"

read -p "🔑 Ingresa tu token de GitHub: " GITHUB_TOKEN

if [ -z "$GITHUB_TOKEN" ]; then
    echo -e "${RED}❌ No se ingresó token. Saliendo...${NC}"
    exit 1
fi

echo -e "${BLUE}📋 Paso 2: Crear repositorio en GitHub...${NC}"

# Crear repositorio usando la API de GitHub
RESPONSE=$(curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/orgs/marketingsoluciones/repos \
  -d '{
    "name": "docs-crm-marketing",
    "description": "Documentación completa del sistema CRM - Equipo Marketing Soluciones",
    "private": true,
    "auto_init": true
  }')

# Verificar si se creó correctamente
if echo "$RESPONSE" | grep -q "html_url"; then
    echo -e "${GREEN}✅ Repositorio creado exitosamente en GitHub!${NC}"
    
    # Extraer la URL del repositorio
    REPO_URL=$(echo "$RESPONSE" | grep -o '"html_url":"[^"]*"' | cut -d'"' -f4)
    echo -e "${BLUE}🔗 Repositorio creado: $REPO_URL${NC}"
    
else
    echo -e "${RED}❌ Error al crear el repositorio:${NC}"
    echo "$RESPONSE"
    echo -e "${YELLOW}⚠️  Verifica que tu token tenga permisos suficientes${NC}"
    exit 1
fi

echo -e "${BLUE}🔧 Paso 3: Configurar Git...${NC}"

# Configurar remote
git remote add origin https://github.com/marketingsoluciones/docs-crm-marketing.git

# Verificar remote
echo -e "${GREEN}✅ Remote configurado:${NC}"
git remote -v

echo -e "${BLUE}🚀 Paso 4: Subir código a GitHub...${NC}"

# Subir a GitHub
git push -u origin main

if [ $? -eq 0 ]; then
    echo -e "${GREEN}🎉 ¡Éxito! Código subido a GitHub${NC}"
    echo ""
    echo -e "${BLUE}📋 Paso 5: Configurar GitHub Pages${NC}"
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
    echo ""
    echo -e "${BLUE}📧 Mensaje para compartir con tu equipo:${NC}"
    echo "¡Hola equipo! 🚀"
    echo ""
    echo "He configurado la documentación completa del CRM en el grupo Marketingsoluciones:"
    echo "📚 https://marketingsoluciones.github.io/docs-crm-marketing/"
    echo ""
    echo "🔧 Repositorio: https://github.com/marketingsoluciones/docs-crm-marketing"
    echo ""
    echo "✅ Incluye:"
    echo "- API GraphQL completa con todos los endpoints"
    echo "- Guías de frontend con React y TypeScript"
    echo "- Ejemplos de código prácticos"
    echo "- Sistema de colaboración privado"
    echo "- Deploy automático en GitHub Pages"
    echo ""
    echo "👥 Todos los miembros del grupo tienen acceso automáticamente."
    echo "🎯 Pueden agregar ejemplos, mejorar documentación y reportar issues."
    echo ""
    echo "¡Empezad a documentar y colaborar! 🎉"
    
else
    echo -e "${RED}❌ Error al subir a GitHub. Verifica que el repositorio exista.${NC}"
fi
