# Swift-Boiler

Swift-Boiler is a tool developed for iOS developers to speed up the process of implementing views, models, controllers, and many other common patterns found in an iOS project. Inspired by the swift syntax and the simplicity of the Rails generate tool, Swift-Boiler is a simple to use boiler plate code generator that will get you up running in no time.

## Installation

### Install Swift-Boiler:

```sh
$ gem install swift-boiler
```

## Usage

Commands follow this specific syntax:

```sh
$ swift-boil --help
$ swift-boil v MyView mainlabel:UILabel firstView:UIView secondView:CustomView
$ swift-boil view MyView -d mainlabel:UILabel firstView:UIView secondView:CustomView
```

<summary>To use a custom template use:</summary>

```sh
$ swift-boil -t /Desktop/mytemplate.mustache MyView toplabel:UILabel bottomlabel:UILabel
$ swift-boil -t /Desktop/mytemplate.mustache MyView -d toplabel:UILabel bottomlabel:UILabel
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

Bug reports and pull requests are welcome on GitHub at our [Bug Section](https://github.com/Boilerplate-Factory/swift-boiler/issues).


## License

The gem is available as open source under the terms of the [MIT License](https://github.com/Boilerplate-Factory/swift-boiler/blob/master/LICENSE.txt).

