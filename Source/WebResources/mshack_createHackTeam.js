function createHackTeam(selectedControlSelectItemIds) {
    // Get the contact record with the first ID in the array parameter, and retrieve the Parent Company name

    Xrm.WebApi.retrieveRecord("contact", selectedControlSelectItemIds[0], "?$select=fullname,contactid&$expand=mshack_ParentCompanyId($select=name)").then(
        function success(result) {
            console.log("Parent Account Name: " + result.mshack_ParentCompanyId.name);

            // Create a new ms_hackteam record with Parent Company name and current date/time

            var newHackTeamdata = {
                "mshack_name": result.mshack_ParentCompanyId.name + " " + new Date().toLocaleDateString()
            };
            console.log(newHackTeamdata);
            Xrm.WebApi.createRecord("mshack_hackteam", newHackTeamdata).then(
                function success(result) {
                    console.log("New Hack Team Created, ID: " + result.id);

                    // Update each selected contact to be related to the new Hack Team
                    for (var i = 0; i < selectedControlSelectItemIds.length; i++) {
                        console.log("starting contact update loop " + i);
                        var contactId = selectedControlSelectItemIds[i];
                        var updateContactdata = {
                            "mshack_HackTeamId@odata.bind": "/mshack_hackteams(" + result.id + ")"
                        };
                        Xrm.WebApi.updateRecord("contact", contactId, updateContactdata).then(
                            function success(result) {
                                console.log("Contact " + contactId + " Updated");
                            },
                            function (error) {
                                console.log(error.message);
                                // handle error conditions
                            }
                        );
                    }
                    
                    // Navigate to the new record created in step 3
                    Xrm.Navigation.openForm({
                        entityName: "mshack_hackteam",
                        entityId: result.id
                    });

                },
                function (error) {
                    console.log(error.message);
                    // handle error conditions
                }
            );    
        },
        function (error) {
            console.log(error.message);
            // handle error conditions
        }
    );

}
