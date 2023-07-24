# AASM RBS Generator
Easily generate `RBS` signatures of all the `AASM`-automatically generated methods and constants of your ruby classes.

## Description
If you have found this gem, you probably are adding a type system with `RBS` on top of your `Ruby` project or `Rails` application, and you are managing the state of some of your classes with the `AASM` gem.

If you have no idea about what `AASM` is, you should take a look at their [README]() first.

You should now know that when you `include AASM` on a Ruby class and you define states, events and transitions, your classes will automatically get a few things, including:
- a constant for every state
- instance methods for every state
- scopes for every state if the class is an `ActiveRecord` model
- instance methods for every event

The problem is that when writing `RBS` you should write the signatures for the previous things one-by-one and it can get really frustrating/boring when dealing with large classes.

With this small gem, you can now generate all those signatures automatically with a single command, and save time for doing something more meaningful.

## Installation
Add the following line to your application's `Gemfile`:

```rb
gem 'aasm_rbs'
```

Then, execute `bundle install` in order to load the gem's code.

## Usage
Generating the `RBS` signatures is as easy as launching the following command from the command-line:
```
bundle exec aasm_rbs ClassName
```

The generated signatures should appear in `stdout`.


