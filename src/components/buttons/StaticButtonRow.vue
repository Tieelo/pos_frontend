<template>
  <div class="static-button-row">
    <v-btn
        class="no-caps"
        color="blue"
        @click="dummy">Rechnungen</v-btn>
    <v-btn
        class="no-caps"
        color="red"
        @click="clearCart">Warenkorb leeren</v-btn>
    <v-btn
        class="no-caps"
        color="red"
        @click="openStorno">SofortStorno</v-btn>
    <v-btn
        class="no-caps"
        color="green"
        @click="checkout">Checkout</v-btn>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import axiosInstance from '@/api/axiosInstance'

export default defineComponent({
  setup(props, { emit }) {
    const dummy = () => {
      // Dummy function, does nothing
    };

    const clearCart = async () => {
      try {
        const response = await axiosInstance.post('/api/cart/return');
        console.log('Warenkorb geleert', response);
        emit('updateCart');
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
        emit('updateCart');
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
  grid-template-columns: repeat(4, 8em);
  gap: 2.9em;
  margin-bottom: 20px;
  margin-top: 160px;
}

.static-button-row button  {
  width: 15em;
  height: 2em;
  color: #2c3e50;
}

</style>