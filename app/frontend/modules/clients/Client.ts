import { ClientData } from "./ClientData";

export class Client extends ClientData {
    fullAddress() : string {
        return `${this.address1}, ${(this.address2) ? `${this.address2}, ` : ''} ${this.town}, ${this.postcode}`;
    }
}
