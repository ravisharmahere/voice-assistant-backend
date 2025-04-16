# Stage 1: Build
FROM python:3.11-slim AS builder
WORKDIR /app

# Install build dependencies
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Stage 2: Runtime
FROM python:3.11-slim
WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /root/.local /root/.local
COPY --from=builder /app .

# Set PATH
ENV PATH=/root/.local/bin:$PATH

# Expose port and define default command
EXPOSE 3001
CMD ["python", "agent.py", "start"]
