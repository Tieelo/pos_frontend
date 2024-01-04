<template>
  <div class="cart-display">
    <v-table
        density="comfortable"
        class="cart-items-box">
      <thead>
      <tr>
        <th class="text-left">Produkt</th>
        <th class="text-left">#</th>
        <th class="text-left">Preis</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="cartItem in cartItems" :key="cartItem.item.id">
        <td>{{cartItem.item.name}}</td>
        <td>{{cartItem.amountInCart}}</td>
        <td>{{(cartItem.item.price).toLocaleString("de-DE", {minimumFractionDigits: 2, maximumFractionDigits: 2})}} €</td>
      </tr>
      </tbody>
    </v-table>
    <div class="footer">
      <div class="cart-summary">
        <p>Total Items: {{ itemCount }}</p>
        <p>Total Price: {{ (totalPrice).toLocaleString("de-DE", {minimumFractionDigits: 2, maximumFractionDigits: 2})}} €</p>
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
  flex: 1em;
  margin-top: 5em;
  margin-left: 5em;
  margin-right: 2em;
}

.cart-items-box {
  border: 0.2em solid #ddd; /* Farbe und Stil der Box-Rahmen anpassen */
  padding: 1em; /* optional: fügt etwas Abstand zwischen dem Inhalt und der Box hinzu */
  height: 40em; /* Höhe der Box festlegen */
  width: 24em; /* Breite der Box festlegen */
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