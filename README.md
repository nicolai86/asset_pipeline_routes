# handlebars\_routes\_assets

Getting your Rails routes into the Rails 3.1 asset pipeline is really easy. Just
`include Rails.application.routes.url_helpers` and you have all your routes available.

But except for hard-coded links this won't help you, because all resource links need fragments to work, like `:id`. Without supplying them at compile-time you won't get anywhere.

Heh, you might think! Just call a resource route and pass in an fragment-mapping you'd think, like
`user_path('{{id}}')`. But sadly, this won't yield the desired result! Instead of `/users/{{id}}`, you'll be presented with `/users/%7B%7Bid%7D%7D`, because you're mapping just got html_escaped!

This is where handlebars\_routes\_assets comes to the rescue!

# What it does

It adds a helper object to your `Sprocket::Context`, called `r`. Using
`r` you can access all your routes you'd normally do, except that all those route fragments
are actually changed into Handlebars attribute bindings.

Here's an example, assuming you got a routes.rb with

    resources :users # => yields multiple routes, e.g. /users/:id(.:format)

in it. Then, in you're javascript file you'd call `r.users_path` instead of `users_path` to
get the Handlebars-version:

    r.user_path # => yields /users/{{id}}
    r.users_path # => yields /users

You can even hook up member- or collection routes, whatever you like. Just prefix your routes with `r.` and you can directly use them in your view!

Of course, this assumes you want Handlebars.js compatible attribute-bindings. Luckily, the auto-generated mappings should work for Mustache.JS as well ;)

# Addendum

Now, if you happen to use haml\_assets to be able to use HAML in your asset pipeline, you could easily create forms to be used in Backbone.js or similar - because you can add an url option which correctly binds to your context!