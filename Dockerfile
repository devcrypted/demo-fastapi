FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy only necessary files
COPY main.py ./

# Expose correct port
EXPOSE 80

# Run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
