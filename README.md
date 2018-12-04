> A vimrc that Just Works™ for modern JavaScript development.

## Installing

First, install [`neovim`](https://neovim.io/) with [Python3 support](https://github.com/neovim/python-client).
If you're on ~OS X~ macOS and have [homebrew](https://brew.sh) installed,
you can issue this command: `brew install python3 neovim/neovim/neovim; pip3 install neovim`.

While most of the features available in this project will work in
regular vim, neovim's asynchronous plugin support means the editor is
much faster even when dealing with complex tasks like FlowType
autocomplete and linting.

The easiest way to download and use this configuration is to issue the
following command.

```
curl -o- https://raw.githubusercontent.com/zperrault/vimrc.js/master/install.sh | bash
```

