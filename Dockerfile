FROM python:3.11-slim

# Set work directory
WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y gcc libpq-dev curl

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Run migrations (optional if handled in docker-compose command)
# RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
