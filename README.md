# Swift-Boiler

Swift-Boiler is a tool developed for iOS developers to speed up the process of implementing views, models, controllers, and many other common patterns found in an iOS project. Inspired by the swift syntax and the simplicity of the Rails generate tool, Swift-Boiler is a simple to use boiler plate code generator that will get you up running in no time.

## Installation

Via Homebrew:

### Install Swift-Boiler via [Homebrew](http://brew.sh):

```sh
$ brew update
$ brew install swift-boiler
```

### Install it with gem:

```sh
$ gem install swift-boiler
```

### Compile from source:

```sh
$ git clone git@github.com:Boilerplate-Factory/swift-boiler.git
$ cd swift-boiler
$ rake install
```

## Usage

Swift-Boiler has only one swift-boil binary, and the command follow this specific syntax:
<summary>swift-boil \<option\></summary>
```sh
$ swift-boil --help
```

<summary>swift-boil \<option\> \<template_path\> \<class_name\> \<options\> \<properties\></summary>
```sh
$ swift-boil -t /Desktop/mytemplate.mustache MyView label:UILabel firstView:UIView secondView:CustomView
$ swift-boil -t /Desktop/mytemplate.mustache MyView -d label:UILabel firstView:UIView secondView:CustomView
```

<summary>swift-boil \<command\> \<class_name\> \<options\> \<properties\></summary>
```sh
$ swift-boil v MyView label:UILabel 
$ swift-boil view MyView -d label:UILabel
```

### Commands:
- `view or v`: command to generate the boiler plate code for a view
- `model or m`: command to generate the boiler plate code for a model
- `controller or c`: command to generate the boiler plate code for a controller
- `tableViewCell or tvc`: command to generate the boiler plate code for a table view cell
- `singleton or s`: command to generate the boiler plate code for a singleton

### Options:
- `--help or -h`: shows usage details
- `--delegate or -d`: it indicates that Swift-Boiler should add a delegate to the class being generated
- `--template or -t`: allows user to specify a custom template to be used to generate code

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/\<username\>/swift-boiler.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

