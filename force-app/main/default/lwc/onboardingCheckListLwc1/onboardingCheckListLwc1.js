import { LightningElement, api, wire, track } from 'lwc';
import getSteps from '@salesforce/apex/OnboardingChecklistController.getSteps';

import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

// Datatable columns
const COLUMNS = [
    { label: 'Step Name', fieldName: 'Name', type: 'text' },
    {
        label: 'Completed',
        fieldName: 'Completed__c',
        type: 'boolean',
        editable: true
    }
];

export default class OnboardingChecklistLwc1 extends LightningElement {
    @api recordId; // Account Id (automatically comes from Account page)

    columns = COLUMNS;

    @track steps;
    error;
    wiredResult; // store wired response for refresh

    // Wire Apex
    @wire(getSteps, { accountId: '$recordId' })
    wiredSteps(result) {
        this.wiredResult = result;

        if (result.data) {
            this.steps = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.steps = undefined;
        }
    }

    // Handle checkbox update in datatable
    async handleCellChange(event) {
        const changedFields = event.detail.draftValues; // contains edited rows

        // We only allow one edit at a time
        const record = changedFields[0];

        const fields = {};
        fields['Id'] = record.Id;
        fields['Completed__c'] = record.Completed__c;

        const recordInput = { fields };

        try {
            await updateRecord(recordInput);

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Step updated successfully!',
                    variant: 'success'
                })
            );

            // Clear draft values
            this.template.querySelector('lightning-datatable').draftValues = [];

            // Refresh list
            await refreshApex(this.wiredResult);
        } catch (err) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating step',
                    message: err.body ? err.body.message : err.message,
                    variant: 'error'
                })
            );
        }
    }

    // Helper getters
    get errorMessage() {
        return this.error?.body?.message || 'Unknown error';
    }

    get isEmpty() {
        return this.steps && this.steps.length === 0;
    }
}