List<Map<String, dynamic>> productList = [
  {
    'name': 'PRODUCT 1',
    'description': [
      'Description 1 for Product 1',
      'Description 2 for Product 1'
    ],
    'descriptionSelections': [false, false],
    'isSelected': false,
  },
  {
    'name': 'PRODUCT 2',
    'description': ['Description 1 for Product 2'],
    'descriptionSelections': [false],
    'isSelected': false,
  },
  {
    'name': 'PRODUCT 3',
    'description': [
      'Description 1 for Product 3',
      'Description 2 for Product 3',
      'Description 3 for Product 3'
    ],
    'descriptionSelections': [false, false, false],
    'isSelected': false,
  },
];

Map<String, bool> checkDescriptionSelections(
    List<Map<String, dynamic>> productList) {
  bool allSelected = true;
  bool anyDescriptionNotSelected = false;

  for (var product in productList) {
    // Ensure descriptionSelections is a List<bool>
    List<bool> selections = List<bool>.from(product['descriptionSelections']);

    bool productAllSelected = selections.every((selected) => selected);
    bool productAnyDescriptionNotSelected =
        selections.any((selected) => !selected);

    allSelected = allSelected && productAllSelected;
    anyDescriptionNotSelected =
        anyDescriptionNotSelected || productAnyDescriptionNotSelected;
  }

  return {
    'allSelected': allSelected,
    'anyDescriptionNotSelected': anyDescriptionNotSelected,
  };
}
