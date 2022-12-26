export async function fetchIndex<Type>(c: new () => Type): Promise<Array<Type>> {
    function from(json) { return Object.assign(new c(), json); }

    const res = await fetch(`/clients.json`);
    const data = await res.json();

    return data.map(dataInJson => from(dataInJson));
}
