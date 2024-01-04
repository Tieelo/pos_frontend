<template>
  <div class="dynamic-item-button">
    <v-btn @click="addItemToCart(item.id)">
      {{ item.name }}
    </v-btn>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from 'vue';
import axiosInstance from "@/api/axiosInstance";

interface Item {
  id: string | number,
  name: string,
  // Include other properties of the item
}

export default defineComponent({
  props: {
    item: {
      type: Object as PropType<Item>,
      required: true
    },
  },
  setup(props, { emit }) {

    const addItemToCart = async (itemId: string | number) => {
      const body = [itemId, 1];
      try {
        const response = await axiosInstance.post('/api/cart/fill', body);
        console.log('Item hinzugefügt', response);
        emit('itemAdded', itemId); // Emit an event for the parent component to handle
      } catch (error) {
        console.error('Fehler beim Hinzufügen des Items', error);
      }
    };

    return {
      addItemToCart
    };
  }
})
</script>

<style>

</style>