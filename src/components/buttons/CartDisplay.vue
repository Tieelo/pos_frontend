<template>
  <div class="cart-display">
    <v-table
        density="comfortable"
        class="cart-items-box"
    >
      <thead>
      <tr>
        <th class="text-left">Produkt</th>
        <th class="text-left">#</th>
        <th class="text-left">Preis</th>
      </tr>
      </thead>

      <tbody>
      <tr v-for="cartItem in cartItems" :key="cartItem.item.id">
        <td>{{ cartItem.item.name }}</td>
        <td>{{ cartItem.amountInCart }}</td>
        <td>{{ (cartItem.item.price).toLocaleString("de-DE", {minimumFractionDigits: 2, maximumFractionDigits: 2}) }} €</td>
      </tr>
      </tbody>
    </v-table>

    <p>Total Items: {{ itemCount }}</p>
    <p>Total Price: {{ (totalPrice).toLocaleString("de-DE", {minimumFractionDigits: 2, maximumFractionDigits: 2}) }} €</p>

  </div>
</template>

<script lang="ts">
export default {
  props: ['cartItems', 'totalPrice', 'itemCount'],
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