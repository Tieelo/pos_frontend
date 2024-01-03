<template>
  <div>
    <table>
      <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="group in groups" :key="group.id">
        <td>{{ group.id }}</td>
        <td>{{ group.name }}</td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue'
import axiosInstance from '@/api/axiosInstance' // Pfad anpassen, falls notwendig

export default {
  setup() {
    const groups = ref([])

    onMounted(async () => {
      const response = await axiosInstance.get('/api/inventory/groups')
      groups.value = response.data
    })

    return {
      groups
    }
  }
}
</script>