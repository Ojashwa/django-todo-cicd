FROM python:3.12

# Set working directory
WORKDIR /app

# Create and activate virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install setuptools
RUN pip install --upgrade pip setuptools

# Fix: Create a symlink to provide distutils
RUN ln -s /opt/venv/lib/python3.12/site-packages/setuptools/_distutils /opt/venv/lib/python3.12/site-packages/distutils

# Install Django 3.2 (or other dependencies via requirements.txt if you prefer)
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy project files
COPY . .

# Run migrations
RUN python manage.py migrate

# Expose port and start server
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
