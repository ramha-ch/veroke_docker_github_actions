# ✅ Use a lightweight base image
FROM python:3.9-slim

# ✅ Set working directory
WORKDIR /app

# ✅ Install system dependencies in one clean layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    default-libmysqlclient-dev \
    gcc \
    pkg-config && \
    rm -rf /var/lib/apt/lists/*

# ✅ Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ✅ Copy the app source code
COPY . .

# ✅ Optional: Use ENV for runtime port
ENV PORT=5000

# ✅ Expose the port (optional, Compose binds this)
EXPOSE ${PORT}

# ✅ Run the app
CMD ["python", "app.py"]

