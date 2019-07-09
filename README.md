# entropy
Using our scripts, you will be able nto compute the shannon entropy of the list of commits of a build

# Input dataset:
csv file that contain: build_id, projet_name(Project name on GitHub), push_commits

# Create two repositories:
mkdir rep log_dataset

# To collect dataset using git log, execute :
./log_script.sh input

After result of the collection,
# Execute this script to adapt the result
./adapting_dataset.sh


