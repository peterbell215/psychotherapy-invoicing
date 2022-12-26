import {ClientData} from "./ClientData";

// @ts-ignore
export class Client extends ClientData {
    static async fetchClients() : Promise<Array<Client>> {
        const res = await fetch(`/clients.json`);
        const data = await res.json();

        return data.map(clientInJson => Client.from(clientInJson));
    }

    // Create an object from the JSON sent by the backend
    static from(json){
        return Object.assign(new Client(), json);
    }

    fullAddress() : string {
        return `${this.address1}, ${(this.address2) ? `${this.address2}, ` : ''} ${this.town}, ${this.postcode}`;
    }
}
