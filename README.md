# vimrc-settings
This is a repository which contains vim settings based on my own minimalistic preferences.

Currently it only contains a .vimrc file but I will look into creating a ~/.vim folder in future as I may want to load in my own custom colour schemes.

```
# discard your local changes completely
git reset --hard

# cleaning up any local changes / untracked files that would have been overwritten, the pull will finally work
git pull
```

# git-prompt cheat sheet

```bash
(*)   # unstaged changes
(+)   # staged changes
($)   # stashed changes
(%)   # untracked files
(<)   # indicates you are behind HEAD
(>)   # indicates you are ahead of HEAD
(<>)  # indicates you have diverged
(=)   # indicates there is no difference
```
