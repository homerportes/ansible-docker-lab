# ansible-docker-lab

Laboratorio práctico que automatiza la instalación y configuración de un servidor web **Nginx** en múltiples nodos simulados con **Docker**, usando **Ansible**.

---

## Requisitos

| Herramienta    | Versión mínima | Instalación                          |
|----------------|---------------|--------------------------------------|
| Docker         | 24.x          | https://docs.docker.com/get-docker/  |
| Docker Compose | 2.x           | Incluido con Docker Desktop           |
| Ansible        | 2.14+         | `pip install ansible`                |

---

## Estructura del proyecto

```
ansible-docker-lab/
├── Dockerfile
├── docker-compose.yml
├── ansible.cfg
├── inventory.ini
├── playbook.yml
├── site/
│   └── index.html
├── .gitignore
└── README.md
```

---

## Instrucciones paso a paso

### 1. Clonar el repositorio

```bash
git clone <URL-del-repositorio>
cd ansible-docker-lab
```

### 2. Levantar los contenedores

```bash
docker compose up --build -d
```

Esto construye la imagen con Ubuntu 24.04 + OpenSSH + Python3 y levanta dos nodos:
- **node1** → expuesto en el puerto `2222`
- **node2** → expuesto en el puerto `2223`

### 3. Verificar conectividad con Ansible

```bash
ansible -i inventory.ini all -m ping
```

Deberías ver `pong` en la respuesta de ambos nodos.

### 4. Ejecutar el playbook

```bash
ansible-playbook -i inventory.ini playbook.yml
```

El playbook realizará en cada nodo:
1. Instalación de Nginx
2. Copia del archivo `site/index.html` a `/var/www/html/`
3. Inicio y habilitación del servicio Nginx

### 5. Verificar el despliegue

```bash
curl http://localhost:2222
curl http://localhost:2223
```

O abre en el navegador:
- http://localhost:2222
- http://localhost:2223

---

## Inventario

| Host  | Puerto | Usuario | Contraseña |
|-------|--------|---------|------------|
| node1 | 2222   | ansible | ansible    |
| node2 | 2223   | ansible | ansible    |

---

## Notas sobre la configuración SSH

- `ansible.cfg` desactiva `host_key_checking` para evitar prompts en entornos de laboratorio.
- El inventario usa `ansible_ssh_extra_args` con `-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null` para ignorar la verificación de claves de host en contenedores efímeros.
- El usuario `ansible` tiene permisos `sudo` sin contraseña, lo que permite el uso de `become: true` en el playbook.

> **Advertencia:** Esta configuración es exclusiva para entornos de laboratorio local. No usar en producción.

---

## Subir el proyecto a GitHub

```bash
# Inicializar repositorio (si no está inicializado)
git init
git add .
git commit -m "feat: práctica ansible - automatización servidor nginx con docker"

# Conectar con repositorio remoto
git remote add origin https://github.com/<tu-usuario>/ansible-docker-lab.git
git branch -M main
git push -u origin main
```
