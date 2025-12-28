#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dot"
REPO_URL="git@github.com:jwaspin/dot.git"

echo ">>> Starting Bootstrap for Debian..."

INSTALL_DOCKER="auto"

IS_RPI="false"
if [ -f /proc/device-tree/model ]; then
    model=$(tr -d '\0' < /proc/device-tree/model 2>/dev/null || true)
    arch=$(uname -m 2>/dev/null || true)
    if echo "$model" | grep -qi "raspberry" && echo "$arch" | grep -Eqi '^(arm|aarch64)'; then
        IS_RPI="true"
    fi
fi

if [ "$INSTALL_DOCKER" = "auto" ]; then
    if [ -c /dev/tty ]; then
        if [ "$IS_RPI" = "true" ]; then
            printf ">>> Raspberry Pi detected — Docker is not recommended on Pi.\n" > /dev/tty
            read -r -p "Install Docker anyway? [y/N]: " resp </dev/tty
        else
            read -r -p "Install Docker (recommended on non-Pi systems)? [y/N]: " resp </dev/tty
        fi
        case "$resp" in
            [Yy]* ) INSTALL_DOCKER="yes" ;;
            * ) INSTALL_DOCKER="no" ;;
        esac
    else
        INSTALL_DOCKER="no"
    fi
fi

if [ "$IS_RPI" = "true" ]; then
    PI_SUFFIX=" (detected Raspberry Pi)"
else
    PI_SUFFIX=""
fi
echo ">>> Docker install policy: ${INSTALL_DOCKER}${PI_SUFFIX}"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo ">>> Cloning dotfiles to $DOTFILES_DIR..."
    if ! command -v git &> /dev/null; then
        true
    fi
else
    echo ">>> Dotfiles already present at $DOTFILES_DIR"
fi

if [ -x "$(command -v apt-get)" ]; then
    echo ">>> Updating apt and installing dependencies..."
    for f in /etc/apt/sources.list.d/*; do
        if [ -f "$f" ]; then
            if grep -qi 'download.docker.com' "$f" 2>/dev/null; then
                sudo rm -f "$f"
            fi
        fi
    done
    sudo sed -i.bak '/download.docker.com/d' /etc/apt/sources.list || true
    sudo apt-get update
    sudo apt-get install -y git tmux vim python3 python3-pip build-essential curl \
        ca-certificates gnupg lsb-release

    if [ "${INSTALL_DOCKER}" = "no" ]; then
        echo ">>> Skipping Docker install (policy: ${INSTALL_DOCKER})."
    else
        if ! command -v docker &> /dev/null; then
            echo ">>> Installing Docker..."
            sudo install -m 0755 -d /etc/apt/keyrings

            DOCKER_DISTRO="debian"
            DOCKER_BASE_URL="https://download.docker.com/linux/${DOCKER_DISTRO}"
            curl -fsSL "${DOCKER_BASE_URL}/gpg" | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            sudo chmod a+r /etc/apt/keyrings/docker.gpg

            if [ -f /etc/os-release ]; then
                . /etc/os-release
                CODENAME="${VERSION_CODENAME:-$(lsb_release -cs)}"
            else
                CODENAME="$(lsb_release -cs)"
            fi
            RELEASE_URL="${DOCKER_BASE_URL}/dists/${CODENAME}/Release"
            if ! curl -fsS --head "${RELEASE_URL}" >/dev/null 2>&1; then
                echo ">>> Docker repository has no Release for '${CODENAME}', falling back to 'bookworm'"
                CODENAME="bookworm"
            fi

            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] ${DOCKER_BASE_URL} ${CODENAME} stable" |
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

            sudo apt-get update
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo systemctl enable --now docker || true
            if [ -c /dev/tty ]; then
                sudo docker run --rm hello-world || true
            fi
            sudo usermod -aG docker "$USER"
            echo ">>> Added $USER to docker group; log out and back in to use docker without sudo."
        else
            echo ">>> Docker already installed."
        fi
    fi
else
    echo "!! apt-get not found. This script currently supports Debian-based systems."
    exit 1
fi

if [ ! -d "$DOTFILES_DIR" ]; then
    echo ">>> Cloning dotfiles to $DOTFILES_DIR..."
    git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# Link OS-specific bash configuration
repo_root="$DOTFILES_DIR"
ln -sfn "$repo_root/files/bash/linux/bashrc" "$HOME/.bashrc"
ln -sfn "$repo_root/files/bash/linux/bash_profile" "$HOME/.bash_profile"
ln -sfn "$repo_root/files/bash/linux/bash_aliases" "$HOME/.bash_aliases"
echo ">>> Linked bash configs for Linux."

echo ">>> Running Python installer..."
python3 "$DOTFILES_DIR/scripts/install_common.py"

echo ">>> Linux Bootstrap Complete!"

