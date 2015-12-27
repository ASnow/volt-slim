# volt-slim
Slim for Volt framework

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'volt-slim'
```

And then execute:

    $ bundle

## Usage

Create view with `slim` extension.

Write your slim like this

# Examples

Example 1
In:
```slim
tpl-title
  | App title
tpl-body
  | ...
  use-success-alert
  | ...
tpl-success-alert
  .alert
    Your alert
```
OUT:
```xml
<:Title>
  App title
<:Body>
  ...
  <:success-alert></:success-alert>
  ...
<:Success-alert>
  .alert
    Your alert
```

Example 2
IN:
```slim
tpl-body
  | ...
  .class1 class=(true ? 'true-class' : 'false-class' ) | text
  - array.each do |item|
    .item
      = item[:name]
  | ...
```
OUT:
```xml
<:Body>
  ...
  <div class="class1 {{ true ? 'true-class' : 'false-class' }}">
    | text
  </div>
  {{ array.each do |item| }}
    <div class="item">
      {{ item[:name] }}
    </div>
  {{ end }}
  ...
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ASnow/volt-slim.

