FROM python:3.12-slim

# Set working directory
WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y gcc

# Create and activate virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip & install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy app source code
COPY . .

# Run migrations
RUN python manage.py migrate

# Expose port & run app
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
