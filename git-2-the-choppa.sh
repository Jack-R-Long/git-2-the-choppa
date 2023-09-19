#!/bin/bash

# Print help message
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
  echo "Usage: ./git-2-the-choppa.sh [-v|--verbose]"
  echo " "
  echo "Options:"
  echo "  -v, --verbose   Print detailed messages while checking repositories"
  echo "  -h, --help      Display this help message"
  echo " "
  echo "Description:"
  echo "  This script checks all git repositories in the current directory"
  echo "  for new commits and new remote branches. A summary report will be printed"
  echo "  at the end, with a detailed report available when the verbose option is used."
  exit 0
fi

VERBOSE=0
NEW_COMMITS_SUMMARY=()
NEW_BRANCHES_SUMMARY=()

# Check for verbose flag
if [[ "$1" == "-v" ]] || [[ "$1" == "--verbose" ]]; then
  VERBOSE=1
fi

for dir in */; do
  cd "$dir" || continue

  # Check if the directory is a git repository
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    if [[ $VERBOSE -eq 1 ]]; then
      echo "Checking repository: '$dir'"
    fi
    
    # Fetch the latest changes from the remote repository
    git fetch

    # Get the list of all remote branches
    remote_branches=$(git branch -r | grep -v 'HEAD')

    for remote_branch in $remote_branches; do
      # Get the local branch name corresponding to the remote branch
      local_branch=${remote_branch#origin/}

      # Check if the local branch exists
      if git show-ref --verify refs/heads/$local_branch > /dev/null 2>&1; then
        # Get the latest commit SHA in the local and remote branches
        local_commit=$(git rev-parse $local_branch)
        remote_commit=$(git rev-parse $remote_branch)

        # Compare the local and remote commits
        if [ "$local_commit" != "$remote_commit" ]; then
          if [[ $VERBOSE -eq 1 ]]; then
            echo "New commits are available in repository '$dir' on branch '$local_branch'"
          fi
          NEW_COMMITS_SUMMARY+=("Repository '$dir' - New commits on branch '$local_branch'")
        else
          if [[ $VERBOSE -eq 1 ]]; then
            echo "No new commits in repository '$dir' on branch '$local_branch'"
          fi
        fi
      else
        if [[ $VERBOSE -eq 1 ]]; then
          echo "Local branch '$local_branch' does not exist in repository '$dir'"
        fi
        NEW_BRANCHES_SUMMARY+=("Repository '$dir' - New remote branch detected: '$local_branch'")
      fi
    done
  else
    if [[ $VERBOSE -eq 1 ]]; then
      echo "'$dir' is not a git repository"
    fi
  fi

  cd ..
done

# Print Summary
echo -e "\n\nSummary Report:"
echo -e "---------------"
if [ ${#NEW_COMMITS_SUMMARY[@]} -eq 0 ]; then
  echo -e "No new commits detected in any repository."
else
  echo -e "New commits detected in the following repositories and branches:"
  for summary in "${NEW_COMMITS_SUMMARY[@]}"; do
    echo -e "  - $summary"
  done
fi

if [ ${#NEW_BRANCHES_SUMMARY[@]} -eq 0 ]; then
  echo -e "No new remote branches detected in any repository."
else
  echo -e "New remote branches detected in the following repositories:"
  for summary in "${NEW_BRANCHES_SUMMARY[@]}"; do
    echo -e "  - $summary"
  done
fi

