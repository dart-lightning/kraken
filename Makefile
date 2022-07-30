CC=dart
FMT=format
ARGS="--help"
PROBLEM=
NAME=cln_plugin

default: fmt build

dep:
	$(CC) pub get

fmt:
	$(CC) $(FMT) .
	$(CC) analyze .

gen:
	$(CC) run build_runner build

clean:
	rm lib/src/**/*.g.dart

check:
	$(CC) test

build:
	$(CC) compile exe bin/cln_plugin.dart -o $(NAME)