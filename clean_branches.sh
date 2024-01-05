#!/bin/bash

# Set the path to the project
project_directory="/path/to/your/project"

# Set the name of the main branch of the project
main_branch="branch"

# Change to the directory of the main worktree
cd "$project_directory/$main_branch"

# Get the list of all branches
all_branches=$(git branch --format '%(refname:short)')

# Loop through each branch
for branch in $all_branches; do
    # Check if the branch is associated with any active worktree
    if ! git worktree list --porcelain | grep -q "worktree $project_directory/$branch"; then
        # Branch is not associated with any active worktree
        echo "Deleting branch: $branch"
	# Do not force the deletion
	if ! git branch -d "$branch" 2>/dev/null; then
		echo "Warning: Unable to delete the branch '$branch'. It may have unmerged changes."
	fi
    fi
done

echo "Cleanup completed"
