function openAccountCustomPage(primaryControl) {
// Side Dialog
var pageInput = {
    pageType: "custom",
    name: "mshack_opportunitylookup_f5faf",
    recordId: primaryControl.data.entity.getId().replace("{","").replace("}","")
};
var navigationOptions = {
    target: 2, 
    position: 2,
    width: {value: 500, unit: "px"}
};
Xrm.Navigation.navigateTo(pageInput, navigationOptions)
    .then(
        function () {
            // Called when the dialog closes
            primaryControl.data.refresh();
        }
    ).catch(
        function (error) {
            // Handle error
            console.log(error.message);
        }
    );
}