# README

#Copygram

This app is an instagram clone to test my ability to create a functional rails
app. Help was used from the devwalks tutorial on creating an instagram clones,
especially with the css, though I have added some of my own tricks. Extra features were added such as the ability to mark all
notifications read and individual notifications as read with AJAX. Also, an
infinite scroll feature was added for the root and browse sections although it
can be buggy. I hope to continually refactor and clean up the css as well as add more
features so that it more resembles instagram.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

Also, checkout a running implementation at [Copygram](https://shielded-plains-78697.herokuapp.com)
using email "example@test.org" and password "foobar". Alternatively, you can create
your own account.
