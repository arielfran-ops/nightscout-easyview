FROM python:3.13-slim

# Create non-root user
RUN useradd -m appuser

# Set work directory
WORKDIR /home/appuser/app

# Copy uploader.py
COPY src/uploader.py .

# Install dependencies
RUN pip install --no-cache-dir requests pyyaml

# Make sure non-root user has access
RUN chown -R appuser:appuser /home/appuser

# Change user
USER appuser

# Run uploader
CMD ["sh", "-c", "mkdir -p /home/appuser/.nightscout_easyview && cp /etc/secrets/secrets.yaml /home/appuser/.nightscout_easyview/ && python uploader.py"]
