<script lang="ts">
    import { inertia, Link } from '@inertiajs/inertia-svelte'
</script>

<main>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
        <div class="container-fluid">
            <p class="navbar-brand">Invoicing App</p>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <Link href="/clients" class="nav-link">Clients</Link>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <article>
        <slot />
    </article>
</main>
