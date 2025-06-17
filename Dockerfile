ARG PORT=443

FROM cypress/browsers:latest

# Install dependencies (including python3, python3-venv, and python3-pip)
RUN apt-get update && apt-get install -y python3 python3-venv python3-pip

# Create a virtual environment
RUN python3 -m venv /venv

# Upgrade pip inside the virtual environment
RUN /venv/bin/pip install --upgrade pip

# Set environment variable to use the virtual environment's bin directory
ENV PATH="/venv/bin:$PATH"

# Copy the requirements file and install dependencies inside the venv
COPY requirements.txt  .
RUN pip install -r requirements.txt  

# Copy the rest of the application
COPY . .

# Start the app using uvicorn
CMD uvicorn main:app --host 0.0.0.0 --port $PORT
