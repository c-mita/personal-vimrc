##Usage

```
git clone git@github.com:xen-0/personal-vimrc.git --recursive

#for updates
git pull
git submodule update --init --recursive
```


###Linux
```
ln -s [repo] ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
dos2unix ~/.vim/bundles/opencl/syntax/opencl.vim
```
Add to ~/.bashrc
```
export TERM='xterm-256color'
```

###Windows
Open administrator command prompt:
```
mklink /D vimfiles [repo]
mklink _vimrc vimfiles\vimrc
```
