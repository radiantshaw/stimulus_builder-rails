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

### Attaching actions

```erb
<%= stimulated.div do |component| %>
  <% gallery = component.connect(:gallery) %>

  <%= stimulated.button do |button| %>
    <% button.on("click") { gallery.next } %>
  <% end %>
<% end %>
```

will output:

```html
<div data-controller="gallery">
  <button data-action="click->gallery#next"></button>
</div>
```

The `#connect` method returns a representation of the controller that's passed to it. Calling methods on this object inside the block passed to `#on`, and also passing the event will convert it to an action attribute.

#### Event shorthand

If you want to fallback to the default event, use the `#fire` method instead of `#on`:

```erb
<%= stimulated.button do |button| %>
  <% button.fire { gallery.next } %>
<% end %>
```

will generate:

```html
<button data-action="gallery#next"></button>
```

#### Global events

The second parameter to `#on` is where the event should be attached. It can either be `:window`, or `:document`:

```erb
<%= stimulated.div do |component| %>
  <% gallery = component.connect(:gallery) %>

  <% component.on("resize", :window) { gallery.layout } %>
<% end %>
```

will output:

```html
<div data-controller="gallery" data-action="resize@window->gallery#layout"></div>
```

#### Action options

Action options can be passed via hash parameters to `#on`:

```erb
<%= stimulated.div do |component| %>
  <% gallery = component.connect(:gallery) %>

  <% component.on("scroll", passive: false) { gallery.layout } %>

  <%= stimulated.img do |image| %>
    <% image.on("click", capture: true) { gallery.open }
  <% end %>
<% end %>
```

will output:

```html
<div data-controller="gallery" data-action="scroll->gallery#layout:!passive">
  <img data-action="click->gallery#open:capture">
</div>
```

#### Multiple actions

Calling `#on` more than once will append actions to the action attribute:

```erb
<%= stimulated.div do |component| %>
  <% field = component.connect(:field) %>
  <% search = component.connect(:search) %>

  <%= stimulated.input(type: "text") do |input| %>
    <% input.on("focus") { field.highlight } %>
    <% input.on("input") { search.update } %>
  <% end %>
<% end
```

will output:

```html
<div data-controller="field search">
  <input type="text" data-action="focus->field#highlight input->search#update">
</div>
```

#### Naming conventions

If the method calls on the controller representation object is more than one word, it'll `camelCase` it:

```erb
<%= stimulated.div do |component| %>
  <% profile = component.connect(:profile) %>

  <%= stimulated.button do |input| %>
    <% input.on("click") { profile.show_dialog } %>
  <% end %>
<% end
```

will output:

```html
<div data-controller="profile">
  <button data-action="click->profile#showDialog">
</div>
```

#### Action parameters

```erb
<%= stimulated.div do |component| %>
  <% item = component.connect(:item) %>
  <% spinner = component.connect(:spinner) %>

  <%= stimulated.button do |input| %>
    <% input.fire do %>
      <% item.upvote(id: "12345", url: "/votes", active: true) %>
    <% end %>
    <% input.fire { spinner.start } %>
  <% end %>
<% end
```

will output:

```html
<div data-controller="item spinner">
  <button data-action="item#upvote spinner#start"
    data-item-id-param="12345"
    data-item-url-param="/votes"
    data-item-active-param="true">
  </button>
</div>
```

### Referencing targets

The syntax to an element as a target for a controller is `[controller].[target_name] = [element]`.

For example:

```erb
<%= stimulated.div do |component| %>
  <% search = component.connect(:search) %>

  <%= stimulated.input(type: "text") do |input| %>
    <% search.query = input %>
  <% end %>

  <%= stimulated.div do |element| %>
    <% search.error_message = element %>
  <% end %>

  <%= stimulated.div do |element| %>
    <% search.results = element %>
  <% end %>
<% end %>
```

will output:

```html
<div data-controller="search">
  <input type="text" data-search-target="query">
  <div data-search-target="errorMessage"></div>
  <div data-search-target="results"></div>
</div>
```

#### Shared targets

You can add same element as a target for different controllers:

```erb
<%= stimulated.form_for(:users, url: "/users") do |form| %>
  <% search = form.connect(:search) %>
  <% checkbox = form.connect(:checkbox) %>

  <%= stimulated.check_box do |input| %>
    <% search.projects = input %>
    <% checkbox.input = input %>
  <% end %>

  <%= stimulated.check_box do |input| %>
    <% search.messages = input %>
    <% checkbox.input = input %>
  <% end %>
<% end %>
```

will output:

```html
<form action="/users" accept-charset="UTF-8" method="post" data-controller="search checkbox">
  <input type="checkbox" data-search-target="projects" data-checkbox-target="input">
  <input type="checkbox" data-search-target="messages" data-checkbox-target="input">
</form>
```

#### Naming conventions

When target names are more than one word, use `snake_case` for the method names on the `[controller]`:

```erb
<%= stimulated.div do |component| %>
  <% search = component.connect(:search) %>

  <% stimulated.span do |element| %>
    <% search.snake_case = element %>
  <% end %>
<% end %>
```

### Outlets

The `#use` method present on the element returns an object that is a logical representation of an outlet controller. We can then assign this outlet object to the controller where this outlet needs to be accessible by using the controller's `#[]=` method.

```erb
<div>
  <%= stimulated.div(class: "online-user") do |component| %>
    <% component.connect(:user_status)
  <% end %>
  <%= stimulated.div(class: "online-user") do |component| %>
    <% component.connect(:user_status)
  <% end %>
  <# ... %>
</div>

<%# ... %>

<%= stimulated.div(id: "chat") do |component| %>
  <% chat = component.connect(:chat) %>
  <% user_status = component.use(:user_status) %>

  <% chat[".online-user"] = user_status %>
<% end %>
```

The above will add a `data-chat-user-status-outlet=".online-user"` attribute on the `div#chat` element.

`#use` accepts a name of the controller to be used as an outlet, and it has the same naming convention rules as the `#connect` method. The only difference between the both is that the controller returned by the `#use` method is simpler than the one returned by the `#connect` method, _i.e._ it cannot be used to do anything else like setting up actions, or adding targets, etc.

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
