# ------------------------------------------------------------------------------
# IMPORTANT:
# This image uses the base image associated with the software spec:
#    'runtime-24.1-py3.11-cuda'
#
# You must pull this base image from the IBM Cloud Pak for Data (CPD) container
# registry before building this Docker image.
#
# Please follow the documented steps provided by CPD to authenticate and pull
# the base image into your local or enterprise registry.
# ------------------------------------------------------------------------------

# Replace with the base image used in the runtime definition associated with the software spec "runtime-24.1-py3.11-cuda"
FROM runtime-24.1-py3.11-cuda

# Install system tools if needed
USER root:root
RUN microdnf install -y jq

# Create venv in /opt/venv using system Python
RUN python3.11 -m venv /opt/venv

# Ensure pip from the venv is used
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install dependencies from requirements.txt
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Switch to non-root user for runtime
USER wsuser:wscommon
WORKDIR /app

# Copy the application code
COPY . .

# Start the app with gunicorn (runs inside venv automatically because of PATH)
CMD ["gunicorn", "-c", "gunicorn_conf.py", "app:app"]
