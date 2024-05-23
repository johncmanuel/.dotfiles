#!/bin/bash

# Source
# https://github.com/karaage0703/vscode-dotfiles/blob/master/install-vscode-extensions.sh
# to show installed extensions, run `code --list-extensions`
# if you want versions, run `code --list-extensions --show-versions`

pkglist=(
  arrterian.nix-env-selector@1.0.11
  astro-build.astro-vscode@2.10.2
  bbenoist.nix@1.0.1
  donjayamanne.python-environment-manager@1.2.4
  esbenp.prettier-vscode@10.4.0
  formulahendry.auto-rename-tag@0.1.10
  github.copilot@1.194.0
  github.copilot-chat@0.15.2
  golang.go@0.41.4
  jetpack-io.devbox@0.1.5
  ms-azuretools.vscode-docker@1.29.1
  ms-dotnettools.csdevkit@1.6.8
  ms-dotnettools.csharp@2.30.28
  ms-dotnettools.vscode-dotnet-runtime@2.0.5
  ms-dotnettools.vscodeintellicode-csharp@2.1.11
  ms-python.black-formatter@2024.2.0
  ms-python.isort@2023.10.1
  ms-python.python@2024.6.0
  ms-python.vscode-pylance@2024.5.1
  ms-vscode-remote.remote-ssh@0.110.1
  ms-vscode-remote.remote-ssh-edit@0.86.0
  ms-vscode-remote.remote-wsl@0.88.2
  ms-vscode-remote.vscode-remote-extensionpack@0.25.0
  ms-vscode.atom-keybindings@3.3.0
  ms-vscode.remote-explorer@0.4.3
  ms-vscode.remote-server@1.5.1
  raillyhugo.one-hunter@1.4.0
  svelte.svelte-vscode@108.4.1
  tonybaloney.vscode-pets@1.25.1
  visualstudiotoolsforunity.vstuc@1.0.1
  wix.vscode-import-cost@3.3.0
)

for i in ${pkglist[@]}; do
  code --install-extension $i
done