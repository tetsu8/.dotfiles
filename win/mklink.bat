del /q %userprofile%\_vimrc
del /q %userprofile%\_gvimrc
del /q %userprofile%\dein.toml


mklink %userprofile%\_vimrc %userprofile%\.dotfiles\win\_vimrc
mklink %userprofile%\_gvimrc %userprofile%\.dotfiles\win\_gvimrc
mklink %userprofile%\dein.toml %userprofile%\.dotfiles\win\dein.toml

pause