#!/bin/bash

# Define the directory containing your Helm charts
# This should be the top-level directory containing multiple Helm charts
CHARTS_DIR="."

# Function to handle each chart directory found
process_chart() {
    local chart_dir=$1
    echo "Processing chart in directory: $chart_dir"
    helm dependency build "$chart_dir"
}

# Export the function so it can be used by `find`
export -f process_chart

# Remove all Chart.lock files
find . -name 'Chart.lock' -delete

# Use `find` to locate all Chart.yaml files, indicating a Helm chart directory
# -type f ensures that it finds files
# -name specifies the name of the file to find
# -execdir runs the specified command in the directory where the file was found
find "$CHARTS_DIR" -type f -name 'Chart.yaml' -execdir bash -c 'process_chart "$(pwd)"' \;

echo "All charts processed."

