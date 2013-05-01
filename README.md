# asset\_pipeline\_routes

[![Build Status](https://travis-ci.org/leahpar/asset_pipeline_routes.png?branch=master)](https://travis-ci.org/leahpar/asset_pipeline_routes)

Getting your Rails routes into the Rails 3.2 asset pipeline is really easy. Just
`include Rails.application.routes.url_helpers` and you have all your routes available.

But except for hard-coded links this won't help you, because in production you have to pass in resource parameters at compile-time, where they are not available.

Heh, you might think! Just call a route helper and pass in a dynamic parameter mapping, like
`user_path('{{id}}')`. Sadly this won't yield the desired result! Instead of `/users/{{id}}`, you'll be presented with `/users/%7B%7Bid%7D%7D` because you're mapping just got html_escaped!

This is where asset\_pipeline\_routes comes to the rescue!

# What it does

Just like asset-path helper for your assets, asset_pipeline_routes adds `r`. You pass `r` the name of the route, and optionally url or path as second parameter.

Here's an example, assuming you got a routes.rb with

    resources :users # => yields multiple routes, e.g. /users/:id(.:format)

in it. Then, in you're javascript file you'd use it like this:

``` javascript
var userPath = r(user, path); # yields /users/{{id}}
var userUrl = r(user, url); # yields window.location.host/users/{{id}}
```

All `_path`-methods take an arbitrary argument which is used to evaluate the final route.
So if you want a regexp matching all users-show actions, you can do it just like this:

    # application.js.coffee.erb
    usersPath = '<%= r.user_path '\d+' %>' # => yields /users/\d+

Sometimes you want to generate the URL for a given resource on the client-side entirely. That's possible as well:

    # application.js.erb
    var editUserRoute = <%= r.edit_user_path_method %>; // => yields anonymous function in js
    var editUserPath = editUserRoute(42); // => yields '/users/42/edit'

    # or, if you prefer CoffeeScript:
    # application.js.coffee.erb
    editUserPath = <%= r.edit_user_path_method(:coffee) %>
    editUserPath = editUserRoute(42) # => yields '/users/42/edit'

Now you have total control over your Rails routes.

# Addendum

If you happen to use haml\_assets to be able to use HAML in your asset pipeline, you could easily create forms to be used in Backbone.js or similar - because you can add an url option which correctly binds to your context!

# License
Copyright © 2011 Raphael Randschau <nicolai86@me.com>

asset\_pipeline\_routes is distributed under an MIT-style license. See LICENSE for details.