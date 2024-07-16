# StimulusBuilder

Manually adding Stimulus Attributes to HTML elements was something that I didn't like because:

- they were hard to notice and track in the view files
- had to write them manually without any structure
- didn't look good clubbed with other attributes

So, I decided to write this gem to provide a syntax that translates to the Stimulus Attributes behind the scene.

## Usage

The gem takes inspiration from `ActionView::Helpers::FormBuilder` and tries to follow the syntax set by it.

### Connecting controllers

```erb
<%= stimulated.div do |component| %>
  <% component.connect(:reference) %>
<% end %>
```

will output:

```html
<div data-controller="reference"></div>
```

The `#connect` method accepts strings as well:

```erb
<% component.connect("clipboard") %>
```

Using strings, you can also specify a namespaced controller:

```erb
<%= stimulated.div do |component| %>
  <% component.connect("users/list_item") %>
<% end %>
```

which will output:

```html
<div data-controller="users--list-item"></div>
```

If your controller consists of multiple words, you can use `snake_case` notation via symbols:

```erb
<%= stimulated.div do |component| %>
  <% component.connect(:date_picker) %>
<% end %>
```

or via strings:

```erb
<%= stimulated.div do |component| %>
  <% component.connect("date_picker") %>
<% end %>
```

both will output:

```html
<div data-controller="date-picker"></div>
```

#### Connecting multiple controllers

```erb
<%= stimulated.div do |component| %>
  <% component.connect(:clipboard) %>
  <% component.connect(:list_item) %>
<% end %>
```

will output:

```html
<div data-controller="clipboard list-item"></div>
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "stimulus_builder"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install stimulus_builder
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
