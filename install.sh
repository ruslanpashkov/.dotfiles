#!/usr/bin/env bash

set -e

echo "Setting up dotfiles..."

cd ~/.dotfiles

if [ ! -d "dotbot" ]; then
    echo "Adding dotbot as a submodule..."
    git submodule add https://github.com/anishathalye/dotbot dotbot
fi

if [ ! -f "install" ]; then
    echo "Creating install script..."
    cat > "install" << 'EOF'
#!/usr/bin/env bash

set -e

CONFIG="install.conf.yaml"
DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"
EOF

    chmod +x install
fi

echo "Initializing submodules..."
git submodule update --init --recursive

echo "Setup completed! You can now run ./install"
