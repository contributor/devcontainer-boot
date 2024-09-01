clone REPO BRANCH:
    git clone https://github.com/contributor/{{REPO}} --bare ../.git
    cd .. \
        && git worktree add {{BRANCH}} {{BRANCH}} \
        && git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* \
        && git fetch