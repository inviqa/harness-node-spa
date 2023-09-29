# Node SPA Harness for [Workspace]

To use this harness:

1. Install [Workspace]
1. Run `ws create <projectName> inviqa/node-spa:<version>`
1. Change to the <projectName> directory: `cd <projectName>`
1. Create an initial commit, ensuring that `workspace.override.yml` is not added to git:
```bash
git init
git add .
git commit -m "Initial commit"
```
1. Store the `workspace.override.yml` contents in a suitable location (such as LastPass).

[Workspace]: https://github.com/my127/workspace v0.4.0+


This harness is currently unopinionated, in that it doesn't set up an initial packages.json,
nor currently linting configuration. Some of this may change in the future though.

Once `ws create` has exited, it will be expected to fail to start due to there being no packages.json.

You can use create-react-app to set up a React app e.g.:

Vite:
```
[ws exec] yarn create vite
```
create-vite expects a clean directory, so it is required to install it into another directory then move the contents it into the project directory.

Parcel:
```
[ws exec] yarn init
[ws exec] yarn add --dev parcel
```

It is expected that the packages.json defines the following scripts as tasks:

* `dev` - start a development webserver to serve the SPA. This can also use (if not built-in) nodemon to reload on file changes
* `build` - build the static assets, storing in ./build/. An index.html is expected to be produced
* `lint` - run lint checks
* `test:ci` - run tests. `test` is not used as it's handy for developemnt to combine `lint` into `test`, but in CI these are run in parallel

It is also expected to use `yarn` rather than `npm` (but this can be changed)

A `config.jq` JQ filter template resides in the project root directory, which
should be used to pass in environment-specific environment variables at runtime
in pipeline environments. This gets injected as a replacement for %CONFIG% in
the index.html.

Note, no sensitive values should be inserted, as it will render to visitors of
the site.

A recommended way to use this in React is in `public/index.html`:

```html
<div id="root" data-config="%CONFIG%"></div>
```

That way you can easily look it up from the element React is attaching to.

It can alternatively be stored as a JS global variable in a <script> block,
but it's a good idea to avoid in-line scripts altogether.
