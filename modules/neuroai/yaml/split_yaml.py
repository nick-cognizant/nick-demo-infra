import sys
import os

# Fetch the YAML file from command line arguments
file_path = sys.argv[1]

with open(file_path, 'r') as f:
    content = f.read().split('---')

# Get the directory of the original file
output_dir = os.path.dirname(file_path)

for index, yaml in enumerate(content):
    yaml = yaml.strip()
    if yaml:
        with open(os.path.join(output_dir, f'{os.path.basename(file_path).replace(".yaml", "")}{index}.yaml'), 'w') as f:
            f.write(yaml)
