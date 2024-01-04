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
            console.log('Warenkorb geleert', response);
          })
          .catch(error => {
            console.error('Fehler beim Leeren des Warenkorbs', error);
          });
    },
    openStorno() {
      const stornoWindow = window.open('', 'SofortStorno', 'width=600,height=400');
      axiosInstance.get('/api/cart/items')
          .then(response => {
            stornoWindow.document.write(JSON.stringify(response.data));
          })
          .catch(error => {
            console.error('Fehler beim Abrufen des Warenkorbs', error);
          });
    },
    checkout() {
      axiosInstance.post('/api/cart/sell')
          .then(response => {
            console.log('Einkauf erledigt', response);
          })
          .catch(error => {
            console.error('Fehler beim Checkout', error);
          });
    }
  }
}
</script>

<style>
.static-button-row {
  display: flex;
  justify-content: space-between;
}

.static-button-row button {
  margin: 5px;
}
</style>