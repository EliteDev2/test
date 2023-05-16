#!/data/data/com.termux/files/usr/bin/bash

# Set the repository owner and name
repo_owner="OWNER"
repo_name="REPO"

# Set the desired installation directory
install_dir="/data/data/com.termux/files/home"

# Get the latest release tag
latest_tag=$(curl -s "https://api.github.com/repos/${repo_owner}/${repo_name}/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Construct the download URL
download_url="https://github.com/${repo_owner}/${repo_name}/archive/${latest_tag}.zip"

# Create a temporary directory
temp_dir=$(mktemp -d)

# Download the release archive
echo "Downloading ${latest_tag}..."
curl -L ${download_url} -o ${temp_dir}/${latest_tag}.zip

# Unzip the release archive
echo "Unzipping ${latest_tag}..."
unzip -q ${temp_dir}/${latest_tag}.zip -d ${temp_dir}

# Move the contents to the installation directory
echo "Moving files to ${install_dir}..."
mv ${temp_dir}/${repo_name}-${latest_tag}/* ${install_dir}

# Clean up temporary files
echo "Cleaning up..."
rm -rf ${temp_dir}

echo "Installation complete!"
