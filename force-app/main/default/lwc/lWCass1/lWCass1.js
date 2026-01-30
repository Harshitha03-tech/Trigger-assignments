import { LightningElement, api, wire } from 'lwc';
import getSteps from '@salesforce/apex/OnboardingChecklistController.getSteps';

import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class OnboardingChecklist extends LightningElement {
    @api recordId; // Account Id
    steps;

    wiredStepsResult; // used for refreshApex

    // ✅ Fetch onboarding steps using wire apex
    @wire(getSteps, { accountId: '$recordId' })
    wiredSteps(result) {
        this.wiredStepsResult = result;

        if (result.data) {
            this.steps = result.data;
        } else if (result.error) {
            this.steps = undefined;
            this.showToast('Error', 'Failed to load steps', 'error');
            console.error(result.error);
        }
    }

    // ✅ Update step checkbox using LDS
    handleCheckboxChange(event) {
        const stepId = event.target.dataset.id;
        const completedValue = event.target.checked;

        const fields = {
            Id: stepId,
            Completed__c: completedValue
        };

        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.showToast('Success', 'Step updated successfully', 'success');

                // refresh list after update
                return refreshApex(this.wiredStepsResult);
            })
            .catch((error) => {
                this.showToast('Error', 'Update failed', 'error');
                console.error(error);
            });
    }

    // ✅ Toast Helper
    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}
