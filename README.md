# Feathers and Nuxt JS: the last real-time™ Jedis

This is a presentation I did for the May 2018 Santiago Noders JS meet-up.


## How to run the slides

First of all, clone this repo.

```shell
$ git clone git@github.com:betacar/feathers-nuxt-realtime.git
```

Since we're geeks, this uses [fxn/tkn](https://github.com/fxn/tkn)'s as presentation viewer, which is, essentially, a Ruby script. So, you'll need [Ruby 2.X](https://www.ruby-lang.org/en/downloads/), and [Bundler](https://bundler.io/) to install the gems. After install them, simply do the following:

```shell
$ cd feathers-nuxt-realtime
$ bundle install
...
$ bundle exec bin/tkn feathers_nuxt_real_time.rb
```


## Keyboard Controls and Remotes

* To go forward press any of `<space bar>`, `n`, `k`, `l`, Right, PageDown (but see below).

* To go backwards press any of `b`, `p`, `h`, `j`, Left, PageUp (but see below).

* First slide: `^`.

* Last slide: `$`.

* Go to slide: `g` (accepts a 1-based index, `t` for tallest, and `w` for widest, useful for checking font size).

* Search for slide: `/`.

* Toggle status: `s`.

* Run `$SHELL` inside the presentation (console): `c` (resume with Ctrl-D).

* Quit: `q`.

Searching accepts a regular expression. A nice trick to enable a modifier in a particular search is to use the

    (?imx−imx:...)

syntax. For example to look for "const" in a case-insensitive way just enter

    Search for: (?i:const)


## Demo code

You can it [here](https://github.com/betacar/feathers-nuxt-jedis).


## License

Released under the MIT License.
