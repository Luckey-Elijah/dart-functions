# `dartfn`

`dartfn` is a simple experiment to make single-file dart scripts more
accessible as ordinary scripts. This leverages `oh-my-zsh` plugins to be able to
execute dart programs.

## Requirements:

- Have [`zsh` and `oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh) installed.
- Have [`dart` SDK](https://dart.dev/get-dart) installed.

## Installing:

1. Clone this repo any where on your machine
2. Copy/move the `dart-functions` directory and it's contents into `$ZSH_CUSTOM/plugins`
    the full path for may look like
    `/Users/some-user/.oh-my-zsh/custom/plugins/dart-functions/dart-functions.plugin.zsh`
3. In your `.zshrc`
    - set `DART_FUNCTIONS` to the folder/directory that will hold your dart scripts
    - update your `plugins=( dart-functions )`
4. Run `exec zsh` to update your environment.

## Usage

No you can add `.dart` files to the `$DART_FUNCTIONS` directory.
If you create a `$DART_FUNCTIONS/hello.dart` that is:

```dart
void main(List<String> args) {
  print('Hi, mom!');
  print('length: ${args.length}');
  print('args: $args');
}
```

You can now run it by pre-fixing the file name (less the `.dart` extension) with `dfn`.

```shell
$ dfn hello
Hi, mom!
length: 0
args: []
```

Argument after the file name are forwarded to the dart script arguments:

```shell
$ dfn hello this is "several args"
Hi, mom!
length: 3
args: [this, is, several args]
```

## Caveats

Dart file names should not contain white space. This is not tested.
