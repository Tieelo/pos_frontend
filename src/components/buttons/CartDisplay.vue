<template>
  <div class="cart-display">
    <ul class="cart-items">
      <li v-for="cartItem in cartItems" :key="cartItem.item.id" class="cart-item">
        {{ cartItem.item.name }} x {{ cartItem.amount }} - {{ cartItem.item.price }}€
      </li>
    </ul>
    <div class="cart-summary">
      <p>Total Items: {{ itemCount }}</p>
      <p>Total Price: {{ totalPrice }}€</p>
    </div>
  </div>
</template>

<script lang="ts">
import {ref, watch} from "vue";
import axiosInstance from "@/api/axiosInstance";

export default {
  setup() {
    const cartItems = ref<any[]>([]);
    const totalPrice = ref<number>(0);
    const itemCount = ref<number>(0);

    const fetchCartDataFrom = async (endpoint: string): Promise<any> => {
      try {
        const response = await axiosInstance.get(endpoint);
        return response.data;
      } catch (error) {
        console.error(`Error when fetching data from ${endpoint}`, error);
      }
    };

    const fetchCartData = async () => {
      cartItems.value = await fetchCartDataFrom("/api/cart/items");
      totalPrice.value = await fetchCartDataFrom("/api/cart/total");
      itemCount.value = await fetchCartDataFrom("/api/cart/count");
    };

    // Watch for changes in cartItems and refetch data when it changes
    watch(cartItems, fetchCartData, {deep: true});

    // Fetch data on setup
    fetchCartData();

    return {
      cartItems,
      totalPrice,
      itemCount,
    };
  },
};
</script>

<style>

.cart-display {
  display: flex;
  flex-direction: column;
  flex: 1px;
  margin-top: 50px;
  margin-left: 50px;

}

.cart-items {
  color: #4CAF50;
  margin-bottom: 50px;
}

.cart-item {
}

.cart-summary {
  /* Styling for cart summary section */
}
</style>