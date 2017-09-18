#!/bin/bash

# Get the executing directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  EXEC_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$EXEC_DIR/$SOURCE"
done
EXEC_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
cd "$EXEC_DIR"

# Define BASH colours
RED='\033[0;31m'
LGREEN='\033[1;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # reset colour

# Update local git repo copies on the master branch
for DIR in "$EXEC_DIR/"*"/"; do


    echo -e "${WHITE}Pulling the branch '${CYAN}master${WHITE}' for '${YELLOW}$DIR${WHITE}'${NC}"
	cd $DIR
	
	CUR_BRANCH=$(git rev-parse --abbrev-ref HEAD)
	CHANGED=$(git diff-index --name-only HEAD --)
	
	if [ -n "$CHANGED" ]; then
		echo -e "${RED}ERROR: THE CURRENT REPO HAS LOCAL CHANGES > ABORT PULL${NC}"
		git status
	else
		if [ "$CUR_BRANCH" != "master" ]; then
			git checkout master
		fi
		
		git pull
	fi
	
	echo -e "\n"
done

cd $EXEC_DIR
echo -e "${LGREEN}Done!${NC}"
