<template>
  <div class="dynamic-item-button">
    <button @click="addItemToCart(item.id)">
      {{ item.name }}
    </button>
  </div>
</template>

<script>
import axiosInstance from "@/api/axiosInstance";

export default {
  props: {
    item: {
      type: Object,
      required: true
    }
  },

  methods: {
    addItemToCart(itemId) {
      const body = [itemId, 1];
      axiosInstance.post('/api/cart/fill', body)
          .then(response => {
            console.log('Item hinzugefügt', response);
            this.$emit('itemAdded', itemId); // Emit an event for the parent component to handle
          })
          .catch(error => {
            console.error('Fehler beim Hinzufügen des Items', error);
          });
    }
  }
}
</script>

<style>
.dynamic-item-button button {
  margin: 5px;
  /* Add additional styles here */
}
</style>