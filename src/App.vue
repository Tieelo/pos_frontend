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
      items: [], // Items to be displayed as buttons
    };
  },
  methods: {
    fetchItems(groupId) {
      axiosInstance.get(`/api/inventory/items?groupId=${groupId}`)
          .then(response => {
            this.items = response.data;
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
#app {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.header {
  /* Styles for the header */
}

.main-content {
  display: flex;
  flex-grow: 1;
}

.cart-display {
  flex: 1;
  /* Styles specific to the cart display */
}

.button-section {
  flex: 2;
  display: flex;
  flex-direction: column;
}

.static-button-row {
  /* Styles specific to the static button row */
}

.dynamic-button-group {
  /* Styles specific to the dynamic button group */
}

.item-buttons-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  gap: 10px;
  /* Styles for the container of item buttons */
}

.footer {
  /* Styles for the footer */
}
</style>