<template>
  <div class="cart-display">
    <ul class="cart-items">
      <li v-for="cartItem in cartItems" :key="cartItem.item.id" class="cart-item">
        {{ cartItem.item.name }} x {{ cartItem.amountInCart }} - {{ cartItem.item.price }}€
      </li>
    </ul>
    <div class="cart-summary">
      <p>Total Items: {{ itemCount }}</p>
      <p>Total Price: {{ totalPrice }}€</p>
    </div>
  </div>
</template>
<script>
import axiosInstance from "@/api/axiosInstance";

export default {
  data() {
    return {
      cartItems: [],
      totalPrice: 0,
      itemCount: 0,
    };
  },
  methods: {
    async fetchCartDataFrom(endpoint) {
      try {
        const response = await axiosInstance.get(endpoint);
        return response.data;
      } catch (error) {
        console.error(`Fehler beim Abrufen der Daten von ${endpoint}`, error);
      }
    },
    async fetchCartData() {
      this.cartItems = await this.fetchCartDataFrom('/api/cart/items');
      this.totalPrice = await this.fetchCartDataFrom('/api/cart/total');
      this.itemCount = await this.fetchCartDataFrom('/api/cart/count');
    },
  },
  created() {
    this.fetchCartData();
  },
  watch: {
    cartItems: {
      handler() {
        this.fetchCartData();
      },
      deep: true
    },
  }
}
</script>
<style>
.cart-display {
  /* Styling for cart display */
}

.cart-items {
  /* Styling for cart items list */
}

.cart-item {
  /* Styling for individual cart item */
}

.cart-summary {
  /* Styling for cart summary section */
}
</style>