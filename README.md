# docker-template-streamlit
# Streamlit Docker Template with Nginx

A production-ready Docker template for Streamlit applications with Nginx as a reverse proxy.

## Features

- Multi-stage Docker build for optimized image size
- Nginx reverse proxy with security best practices
- Configurable server name via environment variables
- SSL/HTTPS support (commented out by default)
- Health check endpoint
- Security headers
- WebSocket support for Streamlit's live updates

## Directory Structure

```
.
├── nginx/
│   └── nginx.conf          # Nginx configuration template
├── Dockerfile              # Multi-stage Dockerfile
└── README.md              # This file
```

## Quick Start

1. Copy this template to your project:
   ```bash
   git clone https://github.com/YDL-Amsterdam/docker-template-streamlit.git
   cp -r docker-template-streamlit/* your-project/
   ```

2. Place your Streamlit app file in the root directory (default name: `app.py`)

3. Build the Docker image:
   ```bash
   docker build -t streamlit-app .
   ```

4. Run the container:
   ```bash
   docker run -d -p 80:80 -p 443:443 streamlit-app
   ```

## Configuration

### Environment Variables

- `SERVER_NAME`: Domain name for the server (defaults to localhost)
- `PYTHONDONTWRITEBYTECODE`: Prevents Python from writing bytecode files
- `PYTHONUNBUFFERED`: Ensures Python output is sent straight to terminal

### SSL/HTTPS Setup

1. Uncomment the SSL section in `nginx.conf`
2. Mount your SSL certificates:
   ```bash
   docker run -d \
     -p 80:80 \
     -p 443:443 \
     -v /path/to/cert.pem:/etc/nginx/ssl/cert.pem \
     -v /path/to/key.pem:/etc/nginx/ssl/key.pem \
     streamlit-app
   ```

## Production Deployment

For production deployment, consider:

1. Enable HTTPS by configuring SSL certificates
2. Update the `SERVER_NAME` environment variable to your domain
3. Adjust the `client_max_body_size` in nginx.conf if needed
4. Configure proper logging
5. Set up monitoring for the health check endpoint

## Health Checks

The container includes a health check endpoint at `/_stcore/health`. Monitor container health with:
```bash
docker inspect --format='{{json .State.Health}}' container_id
```

## Security Features

- HTTPS support (when configured)
- Security headers pre-configured in nginx.conf
- XSS protection enabled
- Regular security updates through base image

## Customization

### Nginx Configuration
- Modify `client_max_body_size` for larger file uploads
- Configure SSL settings
- Add custom security headers
- Add locations for static files

## Troubleshooting

1. Check container logs:
   ```bash
   docker logs container_id
   ```

2. Access container shell:
   ```bash
   docker exec -it container_id /bin/bash
   ```

3. Common issues:
   - Port conflicts: Ensure ports 80/443 are available
   - SSL errors: Check certificate paths and permissions
   - Connection refused: Verify Streamlit is running on port 8501

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License
