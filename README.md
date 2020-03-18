# Pkg Template
This is a skeleton project for package generating repositories. Uses FPM, should be suitable for turning most types of artifacts and languages into a package that we can use.

> See [https://github.com/jordansissel/fpm/wiki](fpm)

## How to use

1. Clone this repo.
1. Update your origin remote.
1. Change the `NAME`, `VERSION`, `ARCH`, and `MAINT` variables at the top of [./Makefile](Makefile)
1. Source code goes into `./src`
1. Update [./.gitignore](.gitignore)

## Build
From repo root:

`$> make`

## Install
From repo root:

`$> make install`

## Development

> Be sure to update the VERSION variable in the [./Makefile](Makefile) as you go.

### Prereqs
Install FPM

`$> gem install fpm` or `$> bundle install`

### Working
From repo root:

`$> make dev`

> This will clean, build, and reinstall.
