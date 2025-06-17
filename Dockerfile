ARG PORT=443

FROM cypress/browsers:latest

# Install necessary dependencies including pipx
RUN apt-get update && apt-get install -y python3 python3-pip && pip install pipx

# Install requirements using pipx
COPY requirements.txt  .
RUN pipx install -r requirements.txt  

# Copy the rest of the application
COPY . .

# Start the app using uvicorn
CMD uvicorn main:app --host 0.0.0.0 --port $PORT
