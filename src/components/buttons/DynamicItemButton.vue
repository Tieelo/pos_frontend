<template>
  <div class="dynamic-item-button">
    <button
        v-for="item in items"
        :key="item.id"
        @click="addItemToCart(item.id)"
    >
      {{ item.name }} ({{ item.price }})
    </button>
  </div>
</template>

<script>
import axios from 'axios';
import axiosInstance from "@/api/axiosInstance";

export default {
  props: {
    items: {
      type: Array,
      required: true
    }
  },
  methods: {
    addItemToCart(itemId) {
      const body = [itemId, 1]; // Assuming you always add one item at a time
      axiosInstance.post('/api/cart/fill', body)
          .then(response => {
            // Handle success, you might want to update the cart display or emit an event
            console.log('Item hinzugefügt', response);
            this.$emit('itemAdded', itemId); // Emit an event for the parent component to handle
          })
          .catch(error => {
            // Handle error
            console.error('Fehler beim Hinzufügen des Items', error);
          });
    }
  }
}
</script>

<style>
.dynamic-item-button button {
  margin: 5px;
  /* Weitere Styling-Optionen hier hinzufügen */
}
</style>