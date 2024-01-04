<template>
  <div id="app">
    <div class="header">
      <h1>PoS Kassensystem</h1>
    </div>
    <div class="main-content">
      <div class="cart-display">
        <CartDisplay />
      </div>
      <div class="button-section">
        <StaticButtonRow class="static-button-row" />
        <div class="divider"></div>
        <DynamicButtonGroup class="dynamic-button-group" @items-fetched="updateItems" />
        <div class="item-buttons-grid">
          <DynamicItemButton
              v-for="item in items"
              :key="item.id"
              :item="item"
              @itemAdded="fetchCartData"
          />
        </div>
      </div>
    </div>
    <div class="footer">
      <p>Total: 0.0€</p>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import StaticButtonRow from './components/buttons/StaticButtonRow.vue';
import DynamicButtonGroup from './components/buttons/DynamicButtonGroup.vue';
import DynamicItemButton from './components/buttons/DynamicItemButton.vue';
import CartDisplay from './components/buttons/CartDisplay.vue';
import axiosInstance from '@/api/axiosInstance';

interface Item {
  id: string | number;
  name: string;
  // Other properties for items
}

export default defineComponent({
  components: {
    StaticButtonRow,
    DynamicButtonGroup,
    DynamicItemButton,
    CartDisplay
  },

  setup() {
    const items = ref<Item[]>([]);

    const updateItems = (fetchedItems: Item[]) => {
      items.value = fetchedItems;
    };

    const fetchItems = async (groupId: string) => {
      try {
        const response = await axiosInstance.get(`/api/inventory/items?groupId=${groupId}`);
        items.value = response.data;
      } catch (error) {
        console.error('Fehler beim Abrufen der Items', error);
      }
    };

    const fetchCartData = () => {
      // Fetch updated cart data
      // This method would be called after an item is added to the cart
      // You should implement the logic to fetch and update the cart data here
    };

    fetchItems('groupId');  // replace 'groupId' with your actual groupId value

    return {
      items,
      updateItems,
      fetchCartData
    };
  },
});
</script>

<style scoped>
.main-content {
  display: flex;
}

.cart-display {
  flex: 1;
}

.button-section {
  display: flex;
  flex-direction: column;
  flex: 2;
}
</style>
<style>
.button-section   {
  display: grid;
}
.item-buttons-grid {
  display: grid;
  grid-template-columns: repeat(4, 8em);
  grid-auto-rows: minmax(auto, auto);
  gap: 1em 1em;/* adjust as needed, this will place space around items */
}
.item-buttons-grid button {
  width: 10em;
  height: 2em;
}
.dynamic-button-group button {
  width: 10em;
  height: 2em;
}
.dynamic-button-group {
  display: grid;
  grid-template-columns: repeat(4, 8em);
  grid-auto-rows: minmax(auto, auto);
  gap: 1em 1em;
}
.static-button-row {
  display: grid;
  grid-template-columns: repeat(4, 8em);
  gap: 1em 1em;
}
.static-button-row button  {
  width: 10em;
  height: 2em;
}
</style>