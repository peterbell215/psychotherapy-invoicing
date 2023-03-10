// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')
console.log('Visit the guide for more information: ', 'https://vite-ruby.netlify.app/guide/rails')

import axios from 'axios'

// Import Bootstrao and our custom CSS
import './application.scss'

// Import all of Bootstrap's JS
import * as bootstrap from 'bootstrap'

import { createInertiaApp } from '@inertiajs/inertia-svelte'
import { InertiaProgress } from '@inertiajs/progress'

const modules = import.meta.glob('../modules/**/*.svelte')

const csrfToken = document.querySelector('meta[name=csrf-token]').content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

InertiaProgress.init()

createInertiaApp({
    resolve: name => modules[`../modules/${name}.svelte`](),
    setup({ el, App, props }) {
        new App({ target: el, props })
    },
})
