# Hangman Ruby Playground

First of all I'm playing with Rails to discover how it works with random approaches. When I reach the point where I can do things as I desire, this will provide me everything I need to create the Hangman Man through an API! Keep looking on it! :smiley:

I did a side project to help accomplish when one the business rules I invented for this game! See more details on Excalidraw opening the file [drafts.excalidraw](docs/drafts.excalidraw):

- Project with [Sinatra](https://github.com/sinatra/sinatra) called [Runner #SaidNoOneEver](https://github.com/willianantunes/runner-said-no-one-ever/).

## Running the project

With Docker just issue the following:

    docker-compose up app

Or at the root folder, given you loaded `.env.development` into your current environment, execute the following:

    bundler install
    
Having `rails` globally installed, now you can do:

    rails db:migrate && rails server

With `HTTPie` (or `curl`) you can play with it (use port `8000` if Docker is in place):

    http :3000/api/v1/todos
    http POST :3000/api/v1/todos title=Mozart created_by=1
    http PUT :3000/api/v1/todos/1 title=Beethoven
    http DELETE :3000/api/v1/todos/1
    http POST :8000/api/v1/players name=Jafar email=jafar@agrabah.com
    http GET :8000/api/v1/players

In order to run tests:

    docker-compose up tests

Or the following:

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

If you worked with [Entity Framework](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/?tabs=dotnet-core-cli) or [Django](https://docs.djangoproject.com/en/3.1/topics/migrations/) concerning this topic, here you'll see the same thing but with a different approach. Like your model has no explicit attributes, only validations for example. You can only see its attributes analyzing [schema.rb](/db/schema.rb). So I understand a good way to work with it is first you generate you model, like the following:

    rails g model Player name:string email:string birthday:date gender:string

This will generate the following files (I'm using `RSpec`):

    db/migrate/YYYYMMDDHHMMSS_create_players.rb
    app/models/player.rb
    spec/models/player_spec.rb

You can edit the migration `YYYYMMDDHHMMSS_create_players.rb` and leave like that:

```ruby
class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, limit: 70, null: false
      t.string :email, limit: 320, null: false
      t.date :birthday
      t.string :gender, limit: 1

      t.timestamps
    end
  end
end
```

Then you can run `rails db:migrate` and it's all done.

Important: You can't keep all the generating models process from the command line, that mean that you have to alter the migration file for some tasks like configure a column as not null, default value and some other configuration.


Concerning my hangman modeling, I created executing the following commands:

    rails g model Player name:string{70} email:string{320} birthday:date gender:string{1}
    rails g model Game in_progress:boolean defined_word:string{45} attempts:integer perfect_victory:boolean number_of_tries:integer current_situation:string player:belongs_to
    rails g model Guess chosen_letter:string{1} winner:boolean game:belongs_to
    rails g model Hit word_position:integer guess:belongs_to

I had to edit some files, for example I updated `YYYYMMDDHHMMSS_create_games.rb` in order to not allow the same player create a game with a previous word he used including some other constraints:

```ruby
class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.boolean :in_progress, default: true, null: false
      t.string :defined_word, limit: 45, null: false
      t.integer :attempts, null: false
      t.boolean :perfect_victory
      t.integer :number_of_tries, default: 0
      t.string :current_situation, null: false
      t.belongs_to :player, null: false, foreign_key: true

      t.timestamps
    end

    add_index(:games, [:defined_word, :player_id], unique: true)
  end
end
```

### Changing from SQLite to PostgreSQL

Just issue the command below:

    rails db:system:change --to=postgresql

And the following files will be updated:

    config/database.yml
    Gemfile

To install `pg` gem, I had to do the following:

    https://stackoverflow.com/a/20482221/3899136

```text
libpq is keg-only, which means it was not symlinked into /usr/local,
because conflicts with postgres formula.

If you need to have libpq first in your PATH run:
  echo 'export PATH="/usr/local/opt/libpq/bin:$PATH"' >> /Users/willianantunes/.bash_profile

For compilers to find libpq you may need to set:
  export LDFLAGS="-L/usr/local/opt/libpq/lib"
  export CPPFLAGS="-I/usr/local/opt/libpq/include"

For pkg-config to find libpq you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/libpq/lib/pkgconfig"
```

### Scaffolding controllers

In order to get a full CRUD controller, sample command I used:

    rails generate scaffold_controller player name:string{70} email:string{320} birthday:date gender:string  --api --skip

Natively it lacks pagination support. 

### Updating your Gemfile.lock through Docker

As I'm using remote interpreter, I'll do everything over it. As a means to accomplish what I mention you can do:

    docker-compose run --rm remote-interpreter bundle install

## Interesting links

Nice projects to look over:

- [rootstrap/rails_api_base](https://github.com/rootstrap/rails_api_base)
- [radar/twist-v2](https://github.com/radar/twist-v2)
- [downgba/rack-healthcheck](https://github.com/downgba/rack-healthcheck)

Articles:

- [My thoughts on Hanami](https://ryanbigg.com/2018/03/my-thoughts-on-hanami)
- [Upgrading GitHub to Ruby 2.7](https://github.blog/2020-08-25-upgrading-github-to-ruby-2-7/)
- [Build a RESTful JSON API With Rails 5 - Part One](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one)
- [Build a RESTful JSON API With Rails 5 - Part Two](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-two)
- [Build a RESTful JSON API With Rails 5 - Part Three](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-three)
- [Ruby on Rails Developer Series: Spinning Up a JSON API in Minutes](https://rollout.io/blog/ror-developer-series-spinning-up-a-json-api-in-minutes/)
- [Rails: /app vs /lib](https://devblast.com/b/rails-app-vs-lib)
- [What goes in Rails lib/](https://medium.com/extreme-programming/what-goes-in-rails-lib-92c74dfd955e)
- [How to Use Scopes in Ruby on Rails](https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/)
- [The smart way to check health of a Rails app](https://blog.arkency.com/2016/02/the-smart-way-to-check-health-of-a-rails-app/)
- [How to have a working ‘/health’ endpoint while Rails is 500ring](https://medium.com/@goncalvesjoao/how-to-have-a-working-health-endpoint-while-rails-is-500ring-509efc1da42c)

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
- [Project: RSpec Expectations 3.9 / Built in matchers](https://relishapp.com/rspec/rspec-expectations/v/3-9/docs/built-in-matchers)
- [The Definitive RSpec Tutorial With Examples](https://www.rubyguides.com/2018/07/rspec-tutorial/)
- [Factory Bot Getting Started](https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md)
- [Tutorial: Docker Compose as a remote interpreter](https://www.jetbrains.com/help/ruby/using-docker-compose-as-a-remote-interpreter.html)

Videos:

- [RubyMine & Docker Compose](https://youtu.be/BHniRaZ0_JE)

Issues:

- [Docker Compose service as remote interpreter can't install debugger gems (debase)](https://intellij-support.jetbrains.com/hc/en-us/community/posts/360009798720-Docker-Compose-service-as-remote-interpreter-can-t-install-debugger-gems-debase-)
