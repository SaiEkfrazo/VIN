# Use an official Python runtime as a parent image
FROM python:3.9

# Set environment variables
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV ai_env 1

# Set the working directory in the container
WORKDIR /app

# Copy the local code to the container image
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install gunicorn

# Expose port 8000
EXPOSE 8000

# Define a command to start the Django application with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "aivolved.wsgi:application"]     
# CMD [ "python" , "manage.py", "runserver","0.0.0.0.8100"]
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8100"]

