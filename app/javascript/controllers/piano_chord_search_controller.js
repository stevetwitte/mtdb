import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="piano-chord-search"
export default class extends Controller {
  connect() {
    this.selectedNotes = [];
  }

  key(event) {
    let targetElement;

    if (event.target.nodeName === 'SPAN') {
      targetElement = event.target.parentElement;
    } else {
      targetElement = event.target;
    }

    if (targetElement.classList.contains('selected')) {
      for (var i = this.selectedNotes.length - 1; i >= 0; i--) {
        if (this.selectedNotes[i] === targetElement.dataset.keyName) {
          this.selectedNotes.splice(i, 1);
          break;
        }
      }

      targetElement.classList.remove('selected');

    } else {

      this.selectedNotes.push(targetElement.dataset.keyName);
      targetElement.classList.add('selected');
    }

    if (this.selectedNotes.length >= 3) {
      this.submitSearch();
    }
  }

  submitSearch() {
    let form = document.querySelector('form');
    form.elements.query.value = this.selectedNotes.toString().replaceAll(',', ' ');
    form.requestSubmit();
  }
}
