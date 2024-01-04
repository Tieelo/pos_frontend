<template>
  <div class="dynamic-item-button">
    <v-btn
        class="no-caps"
        @click="addItemToCart(item.id)">
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

.item-buttons-grid {
  display: grid;
  grid-template-columns: repeat(4, 15em);
  grid-auto-rows: minmax(auto, auto);
  gap: 1em 1em;
}

.item-buttons-grid button{
  width: 15em;
  height: 2em;
}



</style>