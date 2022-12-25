<script>
    import { onMount } from 'svelte'

    let clients = []

    onMount(() => {
        fetch('/clients.json')
            .then(response => response.json())
            .then(result => clients = result)
    })
</script>

<h1>Clients</h1>

<table class="table table-hover">
    <thead>
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Address</th>
    </tr>
    </thead>
    <tbody>
        {#each clients as client (client.id)}
            <tr>
                <td>{client.name}</td>
                <td>{client.address1}</td>
            </tr>
        {:else}
            <tr>Loading...</tr>
        {/each}
    </tbody>
</table>

<br>