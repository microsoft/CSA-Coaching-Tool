function openAccountCustomPage(selectedControl, selectedItems) {
// Side Dialog
//let selectedItems = selectedControl.getGrid().getSelectedRows();
console.log(selectedItems);

let selectedItem = selectedItems[0];
var pageInput = {
    pageType: "custom",
    name: "mshack_accountlookup_256cb",
    recordId: selectedItem.Id
};
console.log(pageInput);
var navigationOptions = {
    target: 2, 
    position: 2,
    width: {value: 500, unit: "px"}
};
Xrm.Navigation.navigateTo(pageInput, navigationOptions)
    .then(
        function () {
            // Called when the dialog closes
            selectedControl.refresh();
        }
    ).catch(
        function (error) {
            // Handle error
            console.log(error.message);
        }
    );
}