# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /net

# INSTALL FLASK
RUN pip install flask

COPY sample.py .

# Expose container port
EXPOSE 5000

# Run the app
CMD ["python", "sample.py"]
