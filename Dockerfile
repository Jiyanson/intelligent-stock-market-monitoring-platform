FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /code

# System dependencies (cached unless this layer changes)
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies FIRST (cached unless requirements change)
COPY requirements.txt dev-requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt -r dev-requirements.txt

# Copy app code LAST (only invalidates cache when code changes)
COPY ./app ./app

# Copy other necessary files if they exist
COPY alembic.ini* ./

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
