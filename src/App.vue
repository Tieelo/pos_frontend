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

<script>
import StaticButtonRow from './components/buttons/StaticButtonRow.vue';
import DynamicButtonGroup from './components/buttons/DynamicButtonGroup.vue';
import DynamicItemButton from './components/buttons/DynamicItemButton.vue';
import CartDisplay from './components/buttons/CartDisplay.vue';
import axiosInstance from '@/api/axiosInstance';
export default {

  components: {
    StaticButtonRow,
    DynamicButtonGroup,
    DynamicItemButton,
    CartDisplay
  },

  data() {
    return {
      items: [],
    };
  },

  created() {
    // Ensure to replace 'groupId' with your actual groupId
    this.fetchItems('groupId');
  },

  methods: {

    fetchItems(groupId) {
      axiosInstance.get(`/api/inventory/items?groupId=${groupId}`)
          .then(response => {
            this.items = response.data;
            console.log(response.data);
          })
          .catch(error => {
            console.error('Fehler beim Abrufen der Items', error);
          });
    },

    updateItems(fetchedItems) {
      this.items = fetchedItems;
    },

    fetchCartData() {
      // Fetch updated cart data
      // This method would be called after an item is added to the cart
      // You should implement the logic to fetch and update the cart data here
    }
  }
};
</script>

<style>
.item-buttons-grid {
  display: grid;
  grid-template-columns: repeat(4, 10em);
  grid-auto-rows: minmax(auto, auto);
  gap: 1em 1em;/* adjust as needed, this will place space around items */
}
.item-buttons-grid button {
  width: 10em;
  height: 2em;
}
</style>