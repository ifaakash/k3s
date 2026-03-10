FROM ubuntu:latest AS base-image

FROM base-image AS sshd-image

# Install SSH and Python (Ansible requires Python on the target node)
RUN apt-get update && apt-get install -y openssh-server python3 sudo

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:ansible' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose the SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
