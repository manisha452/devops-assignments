FROM python:3.12-slim

# Don't write .pyc files; flush logs straight away
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Copy requirements first so the dependency layer is cached
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Run as a non-root user (bonus)
RUN useradd --create-home appuser && chown -R appuser /app
USER appuser

# The Flask app listens on port 5000
EXPOSE 5000

CMD ["python", "app.py"]
