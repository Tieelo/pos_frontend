<template>
  <div class="dynamic-button-group">
    <button
        v-for="group in inventoryGroups"
        :key="group.id"
        @click="fetchItems(group.id)"
    >
      {{ group.name }}
    </button>
  </div>
</template>

<script>
import axiosInstance from '@/api/axiosInstance'

export default {
  data() {
    return {
      inventoryGroups: [],
    };
  },
  created() {
    this.fetchInventoryGroups();
  },
  methods: {
    fetchInventoryGroups() {
      axiosInstance.get('/api/inventory/groups')
          .then(response => {
            this.inventoryGroups = response.data;
          })
          .catch(error => {
            console.error('Fehler beim Abrufen der Inventargruppen', error);
          });
    },
    fetchItems(groupId) {
      axiosInstance.get(`/api/inventory/items?groupId=${groupId}`)
          .then(response => {
            // Emit an event with the fetched items
            this.$emit('items-fetched', response.data);
          })
          .catch(error => {
            console.error('Fehler beim Abrufen der Items', error);
          });
    },
    selectGroup(groupId) {
      // Emit an event with the selected group ID
      this.$emit('group-selected', groupId);
    }
  }
}
</script>

<style>
.dynamic-button-group button {
  margin: 5px;
  /* Weitere Styling-Optionen hier hinzufügen */
}
</style>