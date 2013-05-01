# asset\_pipeline\_routes

[![Build Status](https://travis-ci.org/nicolai86/asset_pipeline_routes.png?branch=master)](https://travis-ci.org/nicolai86/asset_pipeline_routes)

`asset_pipeline_routes` defines a `r` shorthand function which you can use inside your javascript assets.

## What it does

Assuming you got a `routes.rb` with:

``` ruby
resources :users # => yields multiple routes, e.g. /users/:id(.:format)
```

Inside your javascript assets you can now write:

``` javascript
r(users_path)        // => yields '/users'
r(user_path)         // => yields '/users/{{id}}'
r(user_path, userId) // => yields '/users/'+userId
```

It works with coffeescript as well:

``` coffeescript
promise = $.rails.ajax({
  url: r(user_path, userId)
})
```

If you are compiling client side templates with the rails asset pipeline this works inside templates as well, e.g.

``` hamlbars
%form{ action: r(user_path) }
```
will generate
``` html
<form action='/users/{{id}}'></form>
```

## Upgrading Notes

*v0.2* introduced code breaking changes!
**THIS WILL NO LONGER WORK**

``` erb
// inside application.js.erb
var url = '<%= r.user_path 42 %>';
```

Instead, you can now drop the `.erb` extension and use r inline:

``` javascript
var url = r(user_path, 42);
```

# License
Copyright © 2011-2013 Raphael Randschau <nicolai86@me.com>

asset\_pipeline\_routes is distributed under an MIT-style license. See LICENSE for details.