<template>
  <div class="cart-display">
    <div class="cart-items-box">
      <ul class="cart-items">
        <li v-for="cartItem in cartItems" :key="cartItem.item.id" class="cart-item">
          {{ cartItem.item.name }} x {{ cartItem.amountInCart }} - {{ cartItem.item.price }}€
        </li>
      </ul>
    </div>
    <div class="footer">
      <div class="cart-summary">
        <p>Total Items: {{ itemCount }}</p>
        <p>Total Price: {{ totalPrice }}€</p>
      </div>
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
  align-items: flex-start;
  flex: 1px;
  margin-top: 70px;
  margin-left: 50px;
  margin-right: 20px;

}

.cart-items-box {
  border: 1px solid #ddd; /* Farbe und Stil der Box-Rahmen anpassen */
  padding: 10px; /* optional: fügt etwas Abstand zwischen dem Inhalt und der Box hinzu */
  height: 400px; /* Höhe der Box festlegen */
  width: 250px; /* Breite der Box festlegen */
  overflow: auto; /* Falls der Inhalt zu groß ist, wird ein Scrollbalken hinzugefügt */
  background-color: #ffffff; /* Dunkelgrüne Farbe */
}

.cart-item {
}

.footer {
  margin-top: 10px; /* Optional: Fügt etwas Abstand zwischen der Box und dem Footer hinzu */
  width: 100%;
  background: #fff;
  padding: 10px;
}

.cart-summary {
  /* Styling for cart summary section */
}
</style>