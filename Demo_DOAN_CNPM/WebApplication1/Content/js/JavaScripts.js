$(document).ready(function () {
    $("#searchForm").submit(function (e) {
        e.preventDefault();
        performSearch();
    });

    $("#searchButton").click(function (e) {
        e.preventDefault();
        performSearch();
    });

    function performSearch() {
        var searchString = $("#searchForm input[name='searchString']").val();
        $.ajax({
            url: $("#searchForm").attr("action"),
            type: $("#searchForm").attr("method"),
            data: { searchString: searchString },
            success: function (data) {
                $("#searchResults").html(data);
            }
        });
    }
});
