<template>
  <div class="static-button-row">
    <button @click="dummy">Rechnungen</button>
    <button @click="clearCart">Warenkorb leeren</button>
    <button @click="openStorno">SofortStorno</button>
    <button @click="checkout">Checkout</button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import axiosInstance from '@/api/axiosInstance'

export default defineComponent({
  setup() {
    const dummy = () => {
      // Dummy function, does nothing
    };

    const clearCart = async () => {
      try {
        const response = await axiosInstance.post('/api/cart/return');
        console.log('Warenkorb geleert', response);
      } catch (error) {
        console.error('Fehler beim Leeren des Warenkorbs', error);
      }
    };

    const openStorno = async () => {
      const stornoWindow = window.open('', 'SofortStorno', 'width=600,height=400');
      try {
        const response = await axiosInstance.get('/api/cart/items');
        stornoWindow.document.write(JSON.stringify(response.data));
      } catch (error) {
        console.error('Fehler beim Abrufen des Warenkorbs', error);
      }
    };

    const checkout = async () => {
      try {
        const response = await axiosInstance.post('/api/cart/sell');
        console.log('Einkauf erledigt', response);
      } catch (error) {
        console.error('Fehler beim Checkout', error);
      }
    };

    return {
      dummy,
      clearCart,
      openStorno,
      checkout
    };
  }
})
</script>

<style>
.static-button-row {
  display: flex;
  justify-content: space-between;
}

.static-button-row button {

}
</style>