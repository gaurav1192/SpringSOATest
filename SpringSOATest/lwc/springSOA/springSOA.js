import { LightningElement, wire } from 'lwc';
import getRecentAccounts from '@salesforce/apex/SpringSOAController.getRecentAccounts';

export default class SpringSOA extends LightningElement {
    columnsList = [
        {label : 'Name', fieldName : 'Name'},
        {label : 'Created Date', fieldName : 'CreatedDate', type : 'date'}
    ];
    @wire(getRecentAccounts) accounts;

}