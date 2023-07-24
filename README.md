# OmniAuth EPIC Games

OmniAuth EPIC Games - OAuth2 Strategy for OmniAuth

OmniAuth EPIC Games is an OAuth2 strategy for OmniAuth that allows you to authenticate users using EPIC Games. If you're not familiar with EPIC Games's OAuth2, we recommend you check out the EPIC Games API documentation for more details.

## Installation

To install OmniAuth EPIC Games, simply add the following line to your Gemfile:

```ruby
gem 'omniauth-epic-games'
```

Then run bundle install to install the gem.

## Usage

OmniAuth EPIC Games is a Rack middleware. If you're not familiar with OmniAuth, we recommend reading the documentation for detailed instructions. Here's an example of how to add the middleware to a Rails app in config/initializers/omniauth.rb:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :epic_games, ENV['EPIC_CLIENT_ID'], ENV['EPIC_CLIENT_SECRET']
end
```

By default, EPIC Games does not return a user's email address. You can request access to additional resources by setting scopes. For example, to get a user's email, you would set the scope to 'email'.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :epic_games, ENV['EPIC_CLIENT_ID'], ENV['EPIC_CLIENT_SECRET'], scope: 'basic_profile'
end
```

You can pass multiple scopes in the same string. For example, to get a user's EPIC Games account info, you would set the scope to 'email identify'.


```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :epic_games, ENV['EPIC_CLIENT_ID'], ENV['EPIC_CLIENT_SECRET'], scope: 'basic_profile'
end
```

You can also specify a callback URL by adding callback_url to the provider options.


```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :epic_games, ENV['EPIC_CLIENT_ID'], ENV['EPIC_CLIENT_SECRET'], scope: 'basic_profile', callback_url: 'https://someurl.com/users/auth/epic_games/callback'
end
```

## Prompt Options

You can specify the prompt options by setting the prompt option. The prompt option indicates whether the user should be prompted to reauthorize on sign in. Valid options are 'consent' and 'none'. Note that the user is always prompted to authorize on sign up.

## Contributing

If you find a bug or want to contribute to the project, we welcome bug reports and pull requests on GitHub.


## License

OmniAuth EPIC Games is available as open-source software under the [MIT License](http://opensource.org/licenses/MIT).
