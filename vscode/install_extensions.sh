# Source
# https://github.com/karaage0703/vscode-dotfiles/blob/master/install-vscode-extensions.sh

pkglist = (
    # todo: automate updating current extensions list here
    # honestly i could just use vscode's settings sync to make this easy for myself,
    # but sometimes i like to do it myself ;)
    13xforever.language-x86-64-assembly
    arrterian.nix-env-selector
    astro-build.astro-vscode
    bbenoist.nix
    donjayamanne.python-environment-manager
    esbenp.prettier-vscode
    formulahendry.auto-rename-tag
    github.copilot
    github.copilot-chat
    golang.go
    jetpack-io.devbox
    ms-azuretools.vscode-docker
    ms-dotnettools.csdevkit
    ms-dotnettools.csharp
    ms-dotnettools.vscode-dotnet-runtime
    ms-dotnettools.vscodeintellicode-csharp
    ms-python.black-formatter
    ms-python.isort
    ms-python.python
    ms-python.vscode-pylance
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-wsl
    ms-vscode-remote.vscode-remote-extensionpack
    ms-vscode.atom-keybindings
    ms-vscode.remote-explorer
    ms-vscode.remote-server
    raillyhugo.one-hunter
    svelte.svelte-vscode
    tonybaloney.vscode-pets
    visualstudiotoolsforunity.vstuc
    wix.vscode-import-cost
)


for i in ${pkglist[@]}; do
  code --install-extension $i
done