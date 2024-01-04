<template>
  <div class="dynamic-button-group">
    <v-btn
        class="no-caps"
        stacked="true"
        rounded="sm"
        density="default"
        color="blue"
        v-for="group in inventoryGroups"
        :key="group.id"
        @click="fetchItems(group.id)"
    >
      {{ group.name }}
    </v-btn>
  </div>
</template>

<script lang="ts">
import { ref} from 'vue';
import axiosInstance from '@/api/axiosInstance'

export default {
  setup(_, {emit}) {

    const inventoryGroups = ref<any[]>([]);

    const fetchInventoryGroups = async () => {
      try {
        const response = await axiosInstance.get('/api/inventory/groups');
        inventoryGroups.value = response.data;
      } catch (error) {
        console.error('Fehler beim Abrufen der Inventargruppen', error);
      }
    };

    const fetchItems = async (groupId: string) => {
      try {
        const response = await axiosInstance.get(`/api/inventory/items?groupId=${groupId}`);
        // Emit an event with the fetched items
        emit('items-fetched', response.data);
      } catch (error) {
        console.error('Fehler beim Abrufen der Items', error);
      }
    };

    fetchInventoryGroups();

    return {
      inventoryGroups,
      fetchItems
    };
  },
}
</script>


<style>

</style>