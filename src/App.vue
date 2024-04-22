<template>
  <div id="POS">
    <div class="header">
      <h1>PoS Kassensystem</h1>
    </div>

    <div class="main-content">
      <div class="cart-display">
        <CartDisplay
            :cartItems="cartItems"
            :totalPrice="totalPrice"
            :itemCount="itemCount"
        />
      </div>

      <div class="button-section">
        <StaticButtonRow class="static-button-row" @updateCart="fetchCartData"/>
        <div class="divider"></div>
        <DynamicButtonGroup class="dynamic-button-group" @items-fetched="updateItems" />

        <div class="item-buttons-grid">
          <DynamicItemButton
              v-for="item in items"
              :key="item.id"
              :item="item"
              @itemAdded="fetchCartData"
              class="own-button"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import {defineComponent, onMounted, ref} from 'vue';
import StaticButtonRow from './components/buttons/StaticButtonRow.vue';
import DynamicButtonGroup from './components/buttons/DynamicGroupButton.vue';
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
    const cartItems = ref<any[]>([]);
    const totalPrice = ref<number>(0);
    const itemCount = ref<number>(0);

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
    const fetchCartDataFrom = async (endpoint: string) => {
      try {
        const response = await axiosInstance.get(endpoint);
        return response.data;

      } catch (error) {
        console.error(`Error fetching from ${endpoint}`, error);
        return null;
      }
    }

    const fetchCartData = async () => {
      // Fetch updated cart data
      // This method would be called after an item is added to the cart
      // You should implement the logic to fetch and update the cart data here
      cartItems.value = await fetchCartDataFrom("/api/cart/items");
      totalPrice.value = await fetchCartDataFrom("/api/cart/total");
      itemCount.value = await fetchCartDataFrom("/api/cart/count");
    };

    onMounted(() => {
      fetchItems('groupId');  // replace 'groupId' with your actual groupId value
      fetchCartData();
    });

    return {
      items,
      updateItems,
      cartItems,
      totalPrice,
      itemCount,
      fetchCartData
    };
  },
});
</script>

<style scoped>

.main-content {
  display: flex;
}

.button-section {
  display: flex;
  flex-direction: column;
  flex: 5;
}


.item-buttons-grid button {
  width: 20em;
  height: 2em;
}

</style>