# Use official Python image
 FROM python:3.11_slim

# Set working directory
WORKDIR /net

# INSTALL FLASK
RUN  pip insatll flask

#COPY sample.py
    
#EXPOSE conatiner port
EXPOSE 8090

# Run the app
CMD ["python", "sample.py"]
