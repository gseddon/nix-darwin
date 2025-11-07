function magit() {
    git_root=$(git rev-parse --show-toplevel)
    emacsclient -nw -e "(magit-status \"''${git_root}\")"
}
