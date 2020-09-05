# Hangman Ruby Playground

First of all I'm playing with Rails to discover how it works with random approaches. When I reach the point where I can do things as I desire, this will provide me everything I need to create the Hangman Man through an API! Keep looking on it! :smiley:

## Running the project

At the root folder, execute the following:

    bundler install
    
Having `rails` globally installed, now you can do:

    rails server

With `HTTPie` (or `curl`) you can play with it:

    http :3000/todos
    http POST :3000/todos title=Mozart created_by=1
    http PUT :3000/todos/1 title=Beethoven
    http DELETE :3000/todos/1

In order to run tests:

    bundle exec rspec

## What I learned so far

### Creating the project

After issuing `gem install rails`, at the root folder I did:

    rails new . --skip-git --skip-action-mailer --skip-action-mailbox \
    --skip-action-text --skip-active-storage --skip-test --api

Important things:

- I had to exclude `public` folder and its content (in my case, only `robots.txt`), as I'm developing an [API-only application](https://guides.rubyonrails.org/api_app.html);
- As you saw, I used `--skip-test` because I configured RSpec afterwards.

### Creating models and migrations

If you worked with [Entity Framework](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/?tabs=dotnet-core-cli) or [Django](https://docs.djangoproject.com/en/3.1/topics/migrations/) concerning this topic, here you'll see the same thing but with a different approach.  Like your model has no explicit attributes, only validations for example. You can only see its attributes analyzing [schema.rb](/db/schema.rb. So I understand a good way to work with it is first you generate you model, like the following:

    rails g model Player name:string email:string birthday:date gender:string

This will generate the following files (I'm using `RSpec`):

    db/migrate/20200905152907_create_players.rb
    app/models/player.rb
    spec/models/player_spec.rb

You can edit the migration `20200905152907_create_players.rb` and leave like that:

```ruby
class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, limit: 255
      t.string :email, limit: 320
      t.date :birthday
      t.string :gender, limit: 1

      t.timestamps
    end
  end
end
```

Then you can run `rails db:migrate` and it's all done.

## Interesting links

Nice projects to look over:

- [rootstrap/rails_api_base](https://github.com/rootstrap/rails_api_base)
- [radar/twist-v2](https://github.com/radar/twist-v2)

Articles:

- [My thoughts on Hanami](https://ryanbigg.com/2018/03/my-thoughts-on-hanami)
- [Upgrading GitHub to Ruby 2.7](https://github.blog/2020-08-25-upgrading-github-to-ruby-2-7/)
- [Build a RESTful JSON API With Rails 5 - Part One](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one)
- [Build a RESTful JSON API With Rails 5 - Part Two](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-two)
- [Build a RESTful JSON API With Rails 5 - Part Three](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-three)


Presentations:

- [Rails vs. Phoenix vs. Hanami](https://speakerdeck.com/wintermeyer/rails-vs-phoenix-vs-hanami)

Discussions:

- [Why Hanami will never unseat Rails](https://news.ycombinator.com/item?id=16551850)
- [Is Ruby worth learning in 2020?](https://www.reddit.com/r/ruby/comments/f1sx71/is_ruby_worth_learning_in_2020/)
- [Was working on a an app with next.js + apollo + docker + ruby-graphql. Finally ended up pulling all that out and just went with straight Rails. Such a breath of fresh air. Building features is way faster, the dev server/build cycle is like 10x faster, we’re 10x happier.
](https://twitter.com/holman/status/1225919360385994753)
- [Why I Believe Rails is Still Relevant in 2019](https://www.reddit.com/r/ruby/comments/ay4yu2/why_i_believe_rails_is_still_relevant_in_2019/)

Documentations:

- [Project: RSpec Rails 4.0 / Directory Structure](https://relishapp.com/rspec/rspec-rails/docs/directory-structure)
- [Factory Bot Getting Started](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)
