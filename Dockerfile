# Use official Python image
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install gunicorn
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt gunicorn

# Copy project files
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Run migrations
RUN python manage.py migrate

EXPOSE 8000

# Start Gunicorn server
CMD ["gunicorn", "django-todo-cicd.wsgi:application", "--bind", "0.0.0.0:8000"]
