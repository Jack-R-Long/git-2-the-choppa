# git-2-the-choppa

`git-2-the-choppa` is a bash script to assist you in managing multiple git repositories. It allows you to quickly check for new commits and new branches in all repositories present in the current directory.

## Features

- Check for new commits and new branches across all repositories in the current directory.
- Verbose mode for detailed output.
- Help message for quick reference.

## Installation

Clone this repository and install the script using the `Makefile` included:

```sh
git clone https://github.com/Jack-R-Long/git-2-the-choppa.git
cd git-2-the-choppa
make install
```

## Adding to path

After installation, add the script directory to your PATH to use it globally. You can do this by adding the following line to your .bash_profile, .bashrc, or .zshrc:

```sh
export PATH="$HOME/git-choppa:$PATH"
```

Then, source your profile:

```sh
# For Bash
source ~/.bash_profile
# or
source ~/.bashrc

# For Zsh
source ~/.zshrc
```

## Usage

Navigate to the directory containing the git repository(s) and run the script:

```sh
git-2-the-choppa.sh
```

#### Options

- `-v`, `--verbose`:Enable verbose mode for detailed output
- `-h`, `--help`:Display the help message

## Uninstall

To uninstall the script, navigate to the script's directory and run:

```sh
make uninstall
```

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

## License

TBD
