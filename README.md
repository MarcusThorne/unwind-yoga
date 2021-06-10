# Unwind Yoga

To run locally you'll need:


[Ruby 2.6.6](https://www.ruby-lang.org/en/documentation/installation/#managers)
```
ruby -v
```

[Bundler](https://bundler.io)
```
bundler -v
```

[PostgreSQL](https://www.postgresql.org/download/)
```
which psql
```

[NVM](https://github.com/nvm-sh/nvm)
```
nvm -v
```

[Yarn](https://classic.yarnpkg.com/en/docs/install/#mac-stable)
```bash
yarn -v
```

---

Clone the repo
```
git clone https://github.com/Calmnus/unwind.yoga.git
```

Install gems
```
bundle install
```

Install Yarn packages
```
yarn install --check-files
```

Migrate the database
```
rails db:migrate
```

Seed the database
```
rails db:seed
```

Start the server
```
rails s
```