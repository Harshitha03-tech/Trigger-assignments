import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import componentCommunicationChannel from'@salesforce/messageChannel/componentCommunicationChannel__c';
export default class ComponentB extends LightningElement {
    @wire(MessageContext)
    messageContext;

    subscription = null;
    receivedMessage = 'No message received received yet';

    connectedCallback() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                componentCommunicationChannel,
                (payload) => this.handleMessage(payload)
            );
        }
    }

    handleMessage(payload) {
        // Handle the message payload here
        console.log('Received payload:', payload);
        this.receivedMessage = payload.message;
    }
}
