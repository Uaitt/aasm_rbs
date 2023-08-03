# AASM RBS Generator

[![Gem Version](https://badge.fury.io/rb/aasm_rbs.svg)](https://badge.fury.io/rb/aasm_rbs) [![Gem Downloads](https://badgen.net/rubygems/dt/aasm_rbs)](https://rubygems.org/gems/aasm_rbs) [![Linters](https://github.com/Uaitt/aasm_rbs/actions/workflows/linters.yml/badge.svg)](https://github.com/Uaitt/aasm_rbs/actions/workflows/linters.yml) [![Specs](https://github.com/Uaitt/aasm_rbs/actions/workflows/specs.yml/badge.svg)](https://github.com/Uaitt/aasm_rbs/actions/workflows/specs.yml)

Easily generate RBS signatures for all the AASM automatically generated methods and constants of your ruby classes.

## Description
If you have found this gem, you probably are adding a type system with RBS on top of your Ruby project or Rails application, and you are managing the state of some of your classes with the AASM gem.

If you have no idea about what AASM is, I encourage you to take a look at their [README](https://github.com/aasm/aasm) first.

You should now know that when you `include AASM` inside of a Ruby class and you define states, events and transitions, your classes will automatically get a few things, including:
- a constant for every state
- instance methods for every state
- scopes for every state if the class is an `ActiveRecord` model and the [automatic scopes](https://github.com/aasm/aasm#automatic-scopes) feature was not disabled manually
- instance methods for every event

The problem is that when writing RBS you should write the signatures for the previous things one-by-one and it can get really frustrating/boring when dealing with large classes.

With this small gem, you can now generate all those signatures automatically with a single command, and save time for doing something more meaningful.

## Installation
Add the following line to your application's `Gemfile` in the `development` group:

```rb
gem 'aasm_rbs'
```

Then, execute `bundle install` in order to load the gem's code.

## Usage
At the moment AASM RBS only supports pure-ruby projects or Rails applications.

This gem assumes that your project is arranged with a traditional structure:
- If dealing with a Rails app, your classes should be in any folder nested inside of `app/` or `lib/`
- If dealing with a Ruby project, your actual classes should go inside of `lib/` and arranged as:
  ```
  lib/
  ├── foo/
  │   ├── bar.rb # contains Foo::Bar
  │   ├── baz.rb # contains Foo::Baz
  │── foo.rb # contains Foo
  ```

For more information about how to structure your projects, take a look at the following articles:
- [Autoloading and reloading constants](https://guides.rubyonrails.org/autoloading_and_reloading_constants.html) from the Rails guides
- [Exploring the structure of a Ruby gem](https://www.cloudbees.com/blog/exploring-structure-ruby-gems) fantastic article from cloudbees (a little bit old but still relevant)

Generating the RBS signatures is as easy as launching the following command from the command-line:
```
bundle exec aasm_rbs Namespace::ClassName
```

If your class is namespaced inside of other modules/classes, please pass the whole name as you see in the previous command to AASM RBS or it won't be able to infer the path.

The generated signatures will appear in `stdout`.


## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/license/mit/).
