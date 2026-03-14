# User Documentation (USER_DOC.md)

This document explains how an end user or administrator can interact with the Inception project.

## Services Provided by the Stack
This infrastructure automatically deploys and manages:
- **WordPress**: A fully functional Content Management System (CMS).
- **Nginx**: A secure web server handling all incoming encrypted traffic.(on port 443)
- **MariaDB**: database storing all WordPress articles and users.
- **Redis Cache**: A high-speed memory cache.
- **FTP Server**: A secure file transfer portal to upload directly to wordpress.
- **Adminer**: A lightweight database UI to view and edit tables.
- **Portainer**: A visual dashboard to manage the Docker containers.
- **Static Website**: Minimal, lightweight about me website.

## Start and Stop the Project
The entire infrastructure is automated via `make`.

To build and start all servers seamlessly in the background:
```bash
make
```

To gracefully stop the servers (without deleting your data):
```bash
make down
```
To Rebuild everything from scratch:
```bash
make re
```

## Accessing the Websites and Administration Panels
Once the project is running (via `make`), you can access the services using your browser:

- **Main WordPress Site:** `https://ymazini.42.fr` (Accept the self-signed TLS warning)
- **WordPress Admin Dashboard:** `https://ymazini.42.fr/wp-admin`
- **Adminer (Database Admin):** `http://localhost:8080`
- **Portainer (Docker Admin):** `http://localhost:7007`
- **Static Resume Site:** `http://localhost:7777`
- **FTP Connection:** Use an FTP client and connect to `localhost:21`. 

## Locating and Managing Credentials
You cannot log into WordPress or Adminer without the passwords. All passwords for this project are securely isolated.

You can find the passwords stored as plain text inside the `secrets/` folder at the root of the project:
- `secrets/wp_admin_password.txt` (For logging into WordPress as Admin)
- `secrets/wp_password.txt` (For logging into WordPress as a standard user)
- `secrets/db_password.txt` (For logging into Adminer's database UI)
- `secrets/db_root_password.txt` (For full MariaDB root administration)
- `secrets/ftp_password.txt` (For logging into the FTP Server)

## Checking that Services are Running Correctly
To ensure your infrastructure is healthy and verify running services, you can use the following commands:

1. **List all active containers:**
   ```bash
   docker compose ps
   ```

2. **View the logs for a specific service:**
   ```bash
   docker compose logs <service>
   ```
   *Replace `<service>` with one of: nginx, wordpress, mariadb, adminer, redis, ftp, portainer, or static-site.*

3. **Access a container's internal shell:**
   ```bash
   docker compose exec <service> sh
   ```
   *Replace `<service>` with the targeted service name.*

4. **Verify through the web interfaces:**
   Open the URLs listed in the access section above in your browser. If you see the expected interface load successfully, the service is running perfectly.
