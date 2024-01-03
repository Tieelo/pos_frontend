<template>
  <div class="static-button-row">
    <button @click="dummy">Rechnungen</button>
    <button @click="clearCart">Warenkorb leeren</button>
    <button @click="openStorno">SofortStorno</button>
    <button @click="checkout">Checkout</button>
  </div>
</template>

<script>
import axiosInstance from '@/api/axiosInstance'

export default {
  methods: {
    dummy() {
      // Dummy-Funktion, tut nichts
    },
    clearCart() {
      // POST-Anfrage an die API senden
      axiosInstance.post('/api/cart/return')
          .then(response => {
            // Handle success
            console.log('Warenkorb geleert', response);
          })
          .catch(error => {
            // Handle error
            console.error('Fehler beim Leeren des Warenkorbs', error);
          });
    },
    openStorno() {
      // Neues Fenster öffnen und Warenkorb abrufen
      const stornoWindow = window.open('', 'SofortStorno', 'width=600,height=400');
      axiosInstance.get('/api/cart/items')
          .then(response => {
            // Hier könnten Sie die Daten im neuen Fenster anzeigen
            stornoWindow.document.write(JSON.stringify(response.data));
          })
          .catch(error => {
            // Handle error
            console.error('Fehler beim Abrufen des Warenkorbs', error);
          });
    },
    checkout() {
      // Checkout-API aufrufen
      axiosInstance.post('/api/cart/sell')
          .then(response => {
            console.log('Einkauf erledigt', response);
          })
          .catch(error => {
            console.error('Fehler beim Checkout', error);
          })
    }
  }
}
</script>

<style>
.static-button-row button {
  margin: 5px;
  /* Weitere Styling-Optionen hier hinzufügen */
}
</style>