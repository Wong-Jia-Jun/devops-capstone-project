#!/bin/bash
echo "****************************************"
echo " Setting up Capstone Environment"
echo "****************************************"

# Detect the operating system
OS=$(uname -s)

echo "Using Python 3.10 for setup"

echo "Creating a Python virtual environment"
if [ "$OS" == "Linux" ]; then
    python3.10 -m venv ~/venv
elif [[ "$OS" == "MINGW64_NT"* || "$OS" == "MSYS_NT"* ]]; then
    python3.10 -m venv ~/venv
fi

echo "Configuring the developer environment..."
if [ "$OS" == "Linux" ]; then
    echo "# DevOps Capstone Project additions" >> ~/.bashrc
    echo "export GITHUB_ACCOUNT=$GITHUB_ACCOUNT" >> ~/.bashrc
    echo 'export PS1="\[\e]0;\u:\W\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ "' >> ~/.bashrc
    echo "source ~/venv/bin/activate" >> ~/.bashrc
elif [[ "$OS" == "MINGW64_NT"* || "$OS" == "MSYS_NT"* ]]; then
    echo "# DevOps Capstone Project additions" >> ~/.bash_profile
    echo "export GITHUB_ACCOUNT=$GITHUB_ACCOUNT" >> ~/.bash_profile
    echo 'export PS1="\[\e]0;\u:\W\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ "' >> ~/.bash_profile
    echo "source ~/venv/Scripts/activate" >> ~/.bash_profile
fi

echo "Installing Python dependencies..."
if [ "$OS" == "Linux" ]; then
    source ~/venv/bin/activate && python3.10 -m pip install --upgrade pip wheel
    source ~/venv/bin/activate && pip install -r requirements.txt
elif [[ "$OS" == "MINGW64_NT"* || "$OS" == "MSYS_NT"* ]]; then
    source ~/venv/Scripts/activate && python3.10 -m pip install --upgrade pip wheel
    source ~/venv/Scripts/activate && pip install -r requirements.txt
fi

echo "Starting the Postgres Docker container..."
make db

echo "Checking the Postgres Docker container..."
docker ps

echo "****************************************"
echo " Capstone Environment Setup Complete"
echo "****************************************"
echo ""
echo "Use 'exit' to close this terminal and open a new one to initialize the environment"
echo ""
