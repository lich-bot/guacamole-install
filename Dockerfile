# Testing automated Docker builds

# Use the official Debian base image
FROM debian:latest

# Update packages and install git t
RUN apt-get update && \
    apt-get install -y git && \

# Clone the Guacamole installer repository
RUN cd / && \
git clone https://github.com/itiligent/Guacamole-Install && \
cd Guacamole-Install && \
git checkout testing

# Run the Guacamole setup script
RUN chmod +x 1-setup.sh && \
    ./1-setup.sh

# Reset the working directory to root
WORKDIR /guac-setup

# Clean up unnecessary dependencies
RUN apt-get purge -y git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Command to run when the container starts
CMD ["/bin/bash"]
