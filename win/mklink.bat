del /q %userprofile%\_vimrc
del /q %userprofile%\_gvimrc
del /q %userprofile%\.toml
del /q %userprofile%\.vsvimrc


mklink %userprofile%\_vimrc %userprofile%\.dotfiles\.vimrc
mklink %userprofile%\_gvimrc %userprofile%\.dotfiles\.gvimrc
mklink %userprofile%\.toml %userprofile%\.dotfiles\.toml
mklink %userprofile%\.vsvimrc %userprofile%\.dotfiles\win\.vsvimrc

pause
