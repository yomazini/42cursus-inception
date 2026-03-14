# Developer Documentation (DEV_DOC.md)

This document is a technical guide for developers who wish to set up, build, or debug the Inception infrastructure.

## Setting Up from Scratch
Before building the project, a developer MUST manually configure the host environment.

### Prerequisites
1. Install Docker Engine and the Docker Compose plugin on a Linux VM.
2. Add your local user (`ymazini`) to the `docker` group so that you can execute `docker` and `make` commands.
3. Edit your `/etc/hosts` file to resolve the domain locally:
   ```bash
   127.0.0.1 ymazini.42.fr
   ```

### Configuration Files and Secrets
The project orchestrates via the `srcs/docker-compose.yml` file. Before launching, the developer must ensure that:
1. The `srcs/.env` file exists and contains the necessary usernames and domain configurations.
2. The `secrets/` directory exists at the root of the repository, containing the `.txt` files holding the physical passwords (e.g., `db_password.txt`, `ftp_password.txt`). The system fails securely if these are missing.

## Building and Launching
The execution is heavily abstracted into the root `Makefile`.

To build the images locally and launch the containers detached:
```bash
make
```

To stop all services and completely wipe all data volumes to start completely fresh:
```bash
make fclean
```

## Managing Containers and Volumes
If a developer needs to debug a specific crash or modify internal files, use the following commands:

- **Check Live Container Logs:** (Crucial if a container is stuck in a restart loop)
  ```bash
  docker logs wordpress
  docker logs mariadb
  ```
- **Enter a Running Container Shell:**
  ```bash
  docker exec -it nginx /bin/bash
  ```
- **Inspect the Internal Network:**
  ```bash
  docker network inspect docker-network
  ```
- **Check Space/Volumes:**
  ```bash
  docker system df
  docker volume ls
  ```

## Data Persistence Strategy
The Inception architecture guarantees data persistence using Docker Named Volumes defined with explicit `device` paths in the `docker-compose.yml`.

- **Where is data stored?** 
  All persistent data is physically located on the host VM at:
  - `/home/ymazini/data/mariadb` (MariaDB Database files)
  - `/home/ymazini/data/wordpress` (HTML/PHP Web files)
  - `/home/ymazini/data/portainer` (Portainer Dashboard data)

- **How does it persist?**
  When containers are destroyed (`make down` or `docker rm -f`), the physical data remains securely on the host at the absolute paths above. When the containers are rebuilt (`make`), Docker magically re-attaches the fresh containers to those exact host directories, completely restoring the websites and databases without data loss.

## Advanced Operations (Wiping the Architecture)
In the event that the Docker daemon becomes corrupted or you need to test the pristine state of your build scripts, you can forcefully obliterate the entire Docker environment.

**Warning: This deletes all stopped containers, unused networks, dangling images, and build cache.**
```bash
docker system prune -a --volumes -f
```
*(This command is intentionally integrated into the `fclean` rule of the Makefile to ensure a perfectly clean slate before re-evaluations).*
