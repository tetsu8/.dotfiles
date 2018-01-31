del /q %userprofile%\_vimrc
del /q %userprofile%\_gvimrc
del /q %userprofile%\.toml
del /q %userprofile%\.vsvimrc


mklink %userprofile%\_vimrc %userprofile%\.dotfiles\win\_vimrc
mklink %userprofile%\_gvimrc %userprofile%\.dotfiles\win\_gvimrc
mklink %userprofile%\.toml %userprofile%\.dotfiles\win\.toml
mklink %userprofile%\.vsvimrc %userprofile%\.dotfiles\win\.vsvimrc

pause
