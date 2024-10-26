function updateStatusOptions() {
  const categorySelect = document.getElementById('category_select');
  const statusSelect = document.getElementById('status_select');
  const currentStatus = statusSelect.dataset.currentStatus; // Get the current status

  if (!categorySelect || !statusSelect) return; // Ensure the elements exist

  const statusOptions = {
    bug: ["not_started", "started", "resolved"],
    feature: ["not_started", "started", "completed"]
  };

  const selectedCategory = categorySelect.value;

  // Clear the current status options
  while (statusSelect.options.length > 0) {
    statusSelect.remove(0);
  }

  // Add the default "Select Status" prompt
  const defaultOption = new Option("Select Status", "");
  statusSelect.add(defaultOption);

  // Populate the status options based on the selected category
  if (selectedCategory && statusOptions[selectedCategory]) {
    statusOptions[selectedCategory].forEach(function(status) {
      const option = new Option(status, status);
      if (status === currentStatus) {
        option.selected = true; // Pre-select the current status if it's an edit form
      }
      statusSelect.add(option);
    });
  }
}

// Trigger the status update on both page load and Turbo navigation
document.addEventListener("turbo:load", updateStatusOptions); // Turbo event for page navigation
document.addEventListener("change", function(event) {
  if (event.target && event.target.id === 'category_select') {
    updateStatusOptions();
  }
});
