#!/bin/bash

PROJECT_REPOSITORY_URL="https://github.com/$CI_PROJECT_NAMESPACE/$CI_PROJECT_NAME"

CHANGELOG_COMMIT_MESSAGE="chore(changelog): Updating changelog with version $RELEASE_VERSION [skip ci]"

#LATEST_RELEASE_TAG=$(git describe --tags $(git rev-list --tags --max-count=1))
#LATEST_RELEASE_VERSION=$(echo "$latestReleaseTag" | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/')

CHANGELOG_FILE=$(find * -type f \( -iname "changelog.*" -a \( -iname "*.md" -o -iname "*.adoc" \) \) | head -n 1)

CHANGELOG_ALREADY_UPDATE=$(echo "$(git log --oneline --fixed-strings --grep="$CHANGELOG_COMMIT_MESSAGE")")

if [ -z "$CHANGELOG_ALREADY_UPDATE" ]; then
    if [ ! -z "$CHANGELOG_FILE" ]; then
        echo "Updating the Changelog [$CHANGELOG_FILE]"

        rm -rf clog.tar.gz
        rm -rf clog

        # for macOS
        #curl -o clog.tar.gz -L https://github.com/clog-tool/clog-cli/releases/download/v${CLOG_TOOL_VERSION}/clog-v${CLOG_TOOL_VERSION}-x86_64-apple-darwin.tar.gz
        # for linux
        curl -o clog.tar.gz -L https://github.com/clog-tool/clog-cli/releases/download/v${CLOG_TOOL_VERSION}/clog-v${CLOG_TOOL_VERSION}-x86_64-unknown-linux-gnu.tar.gz

        tar -xf clog.tar.gz
        rm -rf clog.tar.gz
        chmod +x clog

        # if you want to add Chore on Changelog generator uncomment the line below
        #echo -e "[clog]\n\n[sections]\nChore = [\"chore\", \"core\"]" > .clog.toml

        ./clog -F -o $CHANGELOG_FILE --setversion $RELEASE_VERSION -r $PROJECT_REPOSITORY_URL

        rm -rf clog

        # if you want to add Chore on Changelog generator uncomment the line below
        #rm -rf .clog.toml

        echo "$(git status)"
        changes="$(git status --porcelain)"
        if [[ -n "$changes" ]]; then
            git add --all
            git commit -m "$CHANGELOG_COMMIT_MESSAGE"
            git push
        fi
    else
        echo "No Changelog file found"
    fi
else
    echo "Changelog already updated"
fi
