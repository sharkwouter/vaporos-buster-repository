#!/bin/bash
cd "$(dirname "$0")"

WORKDIR="${PWD}"
REPODIR="${PWD}/repo"
DISTS="buster brewmaster"

# Add packages for each configured distribution to the repo
for dist in ${DISTS}; do
PACKAGEDIR="${PWD}/packages-${dist}"
	#add deb packages
	reprepro -Vb ${REPODIR} includedeb ${dist} ${PACKAGEDIR}/*.deb

	#include source files
	for dsc in `ls ${PACKAGEDIR}/*.dsc`; do
		reprepro -Vb ${REPODIR} includedsc ${dist} ${dsc}
	done
done

${PWD}/update-testing-repo.sh
