FROM python:3.12-slim

WORKDIR /app

# Install system deps for common DB drivers
RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev build-essential && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN python -m pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=5000
EXPOSE 5000

CMD ["gunicorn", "-k", "eventlet", "-w", "1", "PRONA:app", "-b", "0.0.0.0:5000"]
