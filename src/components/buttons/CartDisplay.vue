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
    fetchCartData() {
      // Fetch cart items
      axiosInstance.get('/api/cart/items')
          .then(response => {
            this.cartItems = response.data;
          })
          .catch(error => {
            console.error('Fehler beim Abrufen der Warenkorbartikel', error);
          });

      // Fetch total price
      axiosInstance.get('/api/cart/total')
          .then(response => {
            this.totalPrice = response.data;
          })
          .catch(error => {
            console.error('Fehler beim Abrufen des Gesamtpreises', error);
          });

      // Fetch item count
      axiosInstance.get('/api/cart/count')
          .then(response => {
            this.itemCount = response.data;
          })
          .catch(error => {
            console.error('Fehler beim Abrufen der Gesamtanzahl der Artikel', error);
          });
    }
  },
  created() {
    this.fetchCartData();
  },
  watch: {
    // Watch for changes in cartItems to update the component
    cartItems: {
      handler() {
        this.fetchCartData();
      },
      deep: true
    }
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