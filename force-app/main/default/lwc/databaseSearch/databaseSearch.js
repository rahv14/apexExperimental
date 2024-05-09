/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 01-31-2024
 * @last modified by  : Rahul V
 **/
import { LightningElement } from 'lwc';
import backicon from '@salesforce/resourceUrl/backicon';
import SwapVert from '@salesforce/resourceUrl/SwapVert';
import Preview from '@salesforce/resourceUrl/Preview';
export default class DatabaseSearch extends LightningElement {
  backimg = backicon;
  swapverticon = SwapVert;
  previewicon = Preview;

  /**
   * Represents a list of Institution references.
   *
   * @type {Array} searchlist
   * @property {string} ref - The reference ID.
   * @property {string} institutionname - The name of the institution.
   * @property {string} city - The city where the institution is located.
   * @property {string} country - The country where the institution is located.
   * @property {string} title - The institution title (e.g., professor).
   * @property {string} date - The date associated with the reference (e.g., '12-2-2023').
   */
  searchlist = [
    { ref: '123', institutionname: 'Colombia', city: 'New york', country: 'USA', title: 'professor', date: '12-2-2023' },
    { ref: '124', institutionname: 'Georgia', city: 'Athens', country: 'USA', title: 'professor', date: '12-2-2023' },
    { ref: '125', institutionname: 'Wisconson', city: 'Madison', country: 'USA', title: 'professor', date: '12-2-2023' }
  ];
}
