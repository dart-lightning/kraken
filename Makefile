CC=dart
FMT=format
ARGS="--help"
PROBLEM=
NAME=kraken
OS=linux

default: fmt build

dep:
	$(CC) pub get

fmt:
	$(CC) $(FMT) .
	$(CC) analyze .

gen:
	$(CC) run build_runner build --delete-conflicting-outputs

clean:
	rm lib/src/**/*.g.dart

check:
	$(CC) test

build:
	$(CC) compile exe bin/cln_plugin.dart -o $(NAME)

release:
	$(CC) compile exe bin/cln_plugin.dart -o $(NAME)-$(OS)