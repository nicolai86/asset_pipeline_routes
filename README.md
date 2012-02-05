# asset\_pipeline\_routes

Getting your Rails routes into the Rails 3.2 asset pipeline is really easy. Just
`include Rails.application.routes.url_helpers` and you have all your routes available.

But except for hard-coded links this won't help you, because all resource links dynamic params at compile-time to work, like `{:id => 42}`. Without supplying them you won't get anywhere.

Heh, you might think! Just call a route helper and pass in a dynamic parameter mapping, like
`user_path('{{id}}')`. Sadly this won't yield the desired result! Instead of `/users/{{id}}`, you'll be presented with `/users/%7B%7Bid%7D%7D` because you're mapping just got html_escaped!

This is where asset\_pipeline\_routes comes to the rescue!

# What it does

It adds a helper object to your asset-pipeline called `r`. Using
`r` you can access all your routes you'd normally do, except that all those path fragments
can be changed to whatever you need them to.

Here's an example, assuming you got a routes.rb with

    resources :users # => yields multiple routes, e.g. /users/:id(.:format)

in it. Then, in you're javascript file you'd call `r.users_path`.  All path fragments are replaced with Mustache-style attribute bindings by default:

    # application.js.coffee.erb
    userPath = '<%= r.user_path %>' # => yields /users/{{id}}
    usersPath = '<%= r.users_path %>' # => yields /users

You can even hook up member- or collection routes, whatever you like really. Just prefix your routes with `r.` and you can directly use them in your asset-pipeline!

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
    editUserPath <%= r.edit_user_path_method(:coffee) %>
    editUserPath = editUserRoute(42) # => yields '/users/42/edit'

Now you have total control over your Rails routes.

# Addendum

If you happen to use haml\_assets to be able to use HAML in your asset pipeline, you could easily create forms to be used in Backbone.js or similar - because you can add an url option which correctly binds to your context!