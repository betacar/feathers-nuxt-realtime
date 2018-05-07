# encoding: utf-8
# Presentation
# Feathers: fundamentals
# Feathers: client
# Feathers: real-time
# Nuxt: fundamentals
# Nuxt and Feathers
# Feathers-Vuex
# Demo

section "Feathers and Nuxt JS: the last real-time™ Jedis" do
  # Slide 02
  center <<-EOS
    \e[1mCarlos Betancourt Carrero\e[0m
    Director of Product Engineering @ uBiome

    @betacar
  EOS
end

section "Feathers JS" do
  # Slide 04
  block <<-EOS
    Set of tools and an architecture pattern that make it easy to create
    scalable REST APIs and real-time applications:

      * Services oriented.
      * Universal: browser, React Native and server side with Node.js.
      * REST and Web Sockets (Socket.io and Primus) transports support out of the box.
      * Datastore agnostic.
      * Flexible authentication plugins.
  EOS

  # Slide 05
  code :sh, <<-EOS
    $ npm install -g @feathersjs/cli
    $ mkdir <app_name>
    $ cd $_
    $ feathers generate app
  EOS

  code :sh, <<-EOS
    project
    ├── LICENSE
    ├── README.md
    ├── config
    │   ├── default.json
    │   └── production.json
    ├── package.json
    ├── public
    │   ├── favicon.ico
    │   └── index.html
    ├── src
    │   ├── app.hooks.js
    │   ├── app.js
    │   ├── channels.js
    │   ├── hooks
    │   │   └── logger.js
    │   ├── index.js
    │   ├── middleware
    │   │   └── index.js
    │   └── services
    │       └── index.js
    ├── test
    │   └── app.test.js
    └── yarn.lock
  EOS

  code :sh, <<-EOS
    $ featgers generate service
  EOS

  # Slide 06
  code :js, <<-EOS
    import createService from 'feathers-memory';
    import hooks from './tweets.hooks';

    export default app => {
      const paginate = app.get('paginate');

      const options = {
        name: 'tweets',
        paginate
      };

      // Initialize our service with any options it requires
      app.use('/api/v1/tweets', createService(options));

      // Get our initialized service so that we can register hooks and filters
      const service = app.service('api/v1/tweets');

      service.hooks(hooks);
    };
  EOS

  # Slide 07
  center "Feathers JS: client"

  # Slide 08
  block <<-EOS
    It allows you to connect to a Feathers JS application, automatically consuming
    services and its events.

      * Can use either REST or Web Sockets (but not both).
      * Supports multiple authentication methods, as server side Feathers JS.
  EOS

  # Slide 09
  code :js, <<-EOS
    import Feathers from '@feathersjs/client';
    import socketio from '@feathersjs/socketio-client';
    import io from 'socket.io-client';

    const socket = io(<FEATHERS_HOST>, {
      transports: ['websocket'],
      upgrade: false
    });

    const feathersClient = Feathers().configure(socketio(socket));

    export default feathersClient;
  EOS

  # Slide 10
  center "Feathers JS: real-time™ events"

  # Slide 11
  block <<-EOS
    * Feathers services automatically send created, updated, patched,
      and removed events when a create, update, patch or remove service method returns.
    * Only Web Socket transport support them.
    * Can be streamed using channels.
  EOS

  # Slide 12
  code :js, <<-EOS
    // On any real-time connection, add it to the `everybody` channel
    app.on('connection', connection => app.channel('everybody').join(connection));

    // Publish all events to the `everybody` channel
    app.publish(() => app.channel('everybody'));

    app.service('api/v1/tweets').publish(() => app.channel('authenticated'));
  EOS

  # Slide 13
  center "More info: https://docs.feathersjs.com/"
end

section "Nuxt JS" do
  # Slide 15
  block <<-EOS
    Framework for creating Universal Vue.js Applications. Focused on UI rendering
    while abstracting away the client/server distribution.

      * Heavily inspired by it's React cousing: NextJS.
      * Server side rendering (Universal SSR).
      * Directory based automatic routing.
      * Compatibility with standard Vue.js plugins.
      * No Webpack configuration insanity. +
      * Automatic code splitting.
      * Request middleware.
      * And many other features!

      + Except if you want to extend Nuxt's build config.
  EOS

  # Slide 16
  block <<-EOS
    It includes:

      * Vue 2.
      * vue-router.
      * vuex.
      * Vue server renderer (when the 'spa' is not active).
      * vue-meta.
      * vue-loader.
      * webpack.
      * babel-loader.
      * Minified and gzipped on 57kB only!
  EOS

  # Show Nuxt schema image
end

section "Feathers and Nuxt JS" do
  # Slide 18
  block <<-EOS
    * Why?
    * How?
    * ...
    * Profit!!!1!!one
  EOS

  # Slide 19
  code :sh, <<-EOS
    $ npx create-nuxt-app <project-name>
    > Generating Nuxt.js project in ~/Code/JavaScript/<project-name>
    ? Project name <project-name>
    ? Project description My luminous Nuxt.js project
    ? Use a custom server framework feathers
    ...
    ? Choose rendering mode Universal
    ? Use axios module no
    ? Use eslint yes
    ...
    ? Choose a package manager yarn
    Initialized empty Git repository in ~/Code/JavaScript/<project-name>/.git/
    ...

    ✨  Done in 39.78s.
  EOS

  # Slide 20
  code :sh, <<-EOS
    project
    ├── README.md
    ├── assets
    │   └── README.md
    ├── components
    │   ├── Logo.vue
    │   └── README.md
    ├── layouts
    │   ├── README.md
    │   └── default.vue
    ├── middleware
    │   └── README.md
    ├── nuxt.config.js
    ├── package.json
    ├── pages
    │   ├── README.md
    │   └── index.vue
    ├── plugins
    │   └── README.md
    ├── server
    │   ├── config
    │   │   ├── default.json
    │   │   └── production.json
    │   ├── index.js
    │   └── middleware
    │       ├── index.js
    │       └── nuxt.js
    ├── static
    │   ├── README.md
    │   └── favicon.ico
    ├── store
    │   └── README.md
    └── yarn.lock
  EOS

  # Slide 21
  center "Nuxt Middleware on Feathers"

  # Slide 22
  code :js, <<-EOS
    // your-app/src/middleware/nuxt.js

    const { Nuxt, Builder } = require('nuxt');
    const config = require('../../nuxt.config');

    const nuxt = new Nuxt(config);

    if (config.dev) {
      new Builder(nuxt).build()
        .then(() => process.emit('nuxt:build:done'))
        .catch((error) => {
          console.error(error);
          process.exit(1);
        });
    } else {
      process.nextTick(() => process.emit('nuxt:build:done'));
    }

    module.exports = nuxt;
  EOS

  # Slide 23
  code :js, <<-EOS
    // Mime-type middleware request
    // your-app/src/middleware/index.js

    // ...
    const { render } = require('./nuxt'); // <- Require the middleware

    module.exports = function () {
      const app = this;

      app.use((req, res, next) => {
        switch (req.accepts('html', 'json')) {
          case 'json': {
            // Pass the request to Feathers
            next();
            break;
          }
          default: {
            // Pass the request Nuxt
            render(req, res, next);
          }
        }
      });
    };
  EOS

  # Slide 24
  code :js, <<-EOS
    // Route path based middleware
    import nuxt from './nuxt';

    export default function () {
      const app = this;

      app.use((req, res, next) => {
        switch (true) {
        case req.headers['content-type'] === 'application/json':
        case /^\/api/.test(req.path):
          next();
          break;
        default:
          return nuxt.render(req, res, next);
        }
      });
    };
  EOS

  # Slide 25
  code :js, <<-EOS
    // your-app/src/index.js

    const app = require('./app');
    const port = app.get('port');

    process.on('unhandledRejection', (reason, p) => {
      console.error('Unhandled Rejection at: Promise ', p, reason);
    });

    process.on('nuxt:build:done', (err) => {
      if (err) {
        console.error(err);
      }
      const server = app.listen(port);

      server.on('listening', () => {
        console.info(`Feathers application started on ${app.get('host')}:${port}`);
      });
    });
  EOS

  # Slide 26
  center "More info: https://blog.feathersjs.com/ssr-vuejs-app-with-feathers-and-nuxt-bb7dfd3e6397"
end

section "feathers-vuex" do
  # Slide 28
  block <<-EOS
    First class integration of the Feathers Client and Vuex. It implements many Redux best practices
    under the hood, eliminates a lot of boilerplate code, and still allows you to easily customize the Vuex store.
  EOS

  # Slide 29
  block <<-EOS
    * Powered by Vuex & Feathers
    * Realtime By Default
    * Actions with reactive data
    * Local queries
    * Fall-through caching
    * Feathers query syntax
    * $FeathersVuex vue plugin
    * Live queries
    * Per-service data modeling
    * Clone & commit
    * Vuex strict mode
    * Per-record defaults
    * Data level computes
    * Relation support
  EOS

  # Slide 30
  code :js, <<-EOS
    import Vue from 'vue';
    import Vuex from 'vuex';
    import feathersVuex from 'feathers-vuex';
    import feathersClient from '../feathers-client';

    const { service, auth, FeathersVuex } = feathersVuex(feathersClient, { idField: '_id' });

    Vue.use(Vuex);
    Vue.use(FeathersVuex);

    export default new Vuex.Store({
      plugins: [
        service('tweets'),

        // Specify custom options per service
        service('/api/tweets', {
          idField: '_id', // The field in each record that will contain the id
          nameStyle: 'path', // Use the full service path as the Vuex module name, instead of just the last section
          namespace: 'custom-namespace', // Customize the Vuex module name.  Overrides nameStyle.
          autoRemove: true, // Automatically remove records missing from responses (only use with feathers-rest)
          enableEvents: false, // Turn off socket event listeners. It's true by default
          addOnUpsert: true, // Add new records pushed by 'updated/patched' socketio events into store, instead of discarding them. It's false by default
          skipRequestIfExists: true, // For get action, if the record already exists in store, skip the remote request. It's false by default
          modelName: 'OldTask' // Default modelName would have been 'Task'
        }),

        // Add custom state, getters, mutations, or actions, if needed.  See example in another section, below.
        service('things', {
          state: {},
          getters: {},
          mutations: {},
          actions: {}
        }),

        // Setup the auth plugin.
        auth({ userService: 'users' })
      ]
    })
  EOS

  # Slide 31
  center "More info: https://github.com/feathers-plus/feathers-vuex"

  # Slide 32
  center "Ok. Enough chit chat. Show me the magic! ✨ "
end

section "Demo time!" do
end

section "That's all, thanks!" do
end

__END__
