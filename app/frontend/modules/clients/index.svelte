<script lang="ts">
    import { onMount } from 'svelte';
    import { Client } from "./Client";
    import { fetchIndex } from "../FetchData";

    let clients = [];

    onMount( async () => {
        clients = await fetchIndex(Client);
    } );
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
                <td>{client.fullAddress()}</td>
            </tr>
        {:else}
            <tr>Loading...</tr>
        {/each}
    </tbody>
</table>

<br>