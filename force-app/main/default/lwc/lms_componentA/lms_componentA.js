import { LightningElement,wire } from 'lwc';
import{publish,MessageContext} from 'lightning/messageService';
import componentCommunicationChannel from'@salesforce/messageChannel/componentCommunicationChannel__c';
export default class Lms_componentA extends LightningElement {
    @wire(MessageContext)
    messageContext;
    handleButtonClick() {
         const msgInput = this.template.querySelector('lightning-input').value;
        const payload = { message: msgInput };

        publish(this.messageContext, componentCommunicationChannel, payload);
    }
}
