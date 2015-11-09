
$(document).ready(function () {
    Init();
    // table mode switcher
    $('#RadioButtonList').find('input[type=radio]').on('click', function () {
        $("#Table").jqxDataTable('updateBoundData');
    });
    // window for display book history
    $('#modal').jqxWindow({ height: '250px', width: '300px', isModal: true, autoOpen: false });

    // display server messages
    $(".notification").jqxNotification({
        width: "auto", position: "top-left",
        opacity: 0.9, autoOpen: false, autoClose: true, template: "info"
    });
});

function Init() {
    var source = {
        dataType: "json",
        dataFields: [
            { name: 'Id', type: 'int' },
            { name: 'Title', type: 'string' },
            { name: 'Authors', type: 'string' },
            { name: 'Status', type: 'string' }
        ],
        formatdata: function (data) {
            var mode = $('input[type=radio]:checked');
            data.sortdatafield = (data.sortdatafield == null) ? 'Id' : data.sortdatafield;
            data.sortorder = (data.sortorder == null) ? 'asc' : data.sortorder;
            return {
                pagenum: data.pagenum,
                pagesize: data.pagesize,
                sortdatafield: JSON.stringify(data.sortdatafield),
                sortorder: JSON.stringify(data.sortorder),
                mode: mode.val()
            }
        },
        url: 'BookList.aspx/GetBooks'
    };

    var dataAdapter = new $.jqx.dataAdapter(source,
        {
            contentType: 'application/json; charset=utf-8',
            formatData: function (data) {
                if (data.sortdatafield && data.sortorder) {
                    data.$orderby = data.sortdatafield + " " + data.sortorder;
                }
                return data;
            },
            loadError: function (jqXHR, status, error) {
                alert(error);
            },
            downloadComplete: function () {
                // update the totalrecords count.
                var mode = $('input[type=radio]:checked');
                $.ajax({
                    method: "GET",
                    url: 'BookList.aspx/GetTotalRowsCount',
                    contentType: 'application/json; charset=utf-8',
                    async: false,
                    data: { mode: mode.val() },
                    success: function (data) {
                        source.totalrecords = data.d;
                    }
                });
            }
        }
    );

    $("#Table").jqxDataTable({
        source: dataAdapter,
        pageable: true,
        pagerButtonsCount: 12,
        height:"400px",
        serverProcessing: true,
        altRows: true,
        sortable: true,
        selectionMode: "custom", // disable row selection
        rendered: // starts when table is rendered
            function () {
            // handle "Take/Return" buttons clicking
            ActionBtnsHandler();
            // email button only in mode=2 (as default it's removed)
            $('#reminderBtn').remove();
            var mode = $('input[type=radio]:checked');
            // display 'Status' column only for mode = 0 (All books)
            if (mode.val() == 0 && this.getColumn('Status').hidden) {
                this.showColumn('Status');
            }
            // show and perform email reminder only for mode = 2 (Users books)
            else if (mode.val() == 2 && this.getRows().length > 0) {
                EmailInit();    
            }
            return true;
        },
        columns: [
            { text: 'Title', dataField: 'Title', width: 180 },
            { text: 'Authors', dataField: 'Authors', width: 180 },
            {
                text: 'Status', dataField: 'Status', width: 180, sortable: false, hidden: true
            },
            {
                text: 'Action', cellsAlign: 'center', align: "center", width: 180, columnType: 'none', editable: false, sortable: false, dataField: null, cellsRenderer: function (rowData, column, value, row) {
                    // render custom column
                    var mode = $('input[type=radio]:checked');
                    switch (mode.val())
                    {
                        case "0": // All books
                            return "<button data-bookid='" + row.Id + "' class='history-button'>History</div>";
                        case "1": // Available books
                            return "<button data-action='take' data-bookid='" + row.Id + "' class='action-buttons'>Take</button>";
                        case "2": // Books of current user
                            return "<button data-action='return' data-bookid='" + row.Id + "' class='action-buttons'>Return</button>";
                        default:
                            return "Not allowed"
                    }
                }
            },
        ]
    });
}

function EmailInit()
{
    var borrowList = [];
    var rows = $("#Table").jqxDataTable('getRows');
    // forming list of borrowed books
    for (var i = 0; i < rows.length; i++) {
        borrowList.push(rows[i].Title);
    }
    var but = $('<button id ="reminderBtn">Remind me!</button>').on('click', function () {
        $.ajax({
            method: "GET",
            url: 'BookList.aspx/SendReminder',
            contentType: 'application/json; charset=utf-8',
            async: false,
            traditional: true,
            data: { borrowList: JSON.stringify(borrowList) },
            success: function (data) {
                $(".notification:last").html(data.d);
                $(".notification:last").jqxNotification('open');
            }
        });
    });
    $('#container').append(but);
}

function ActionBtnsHandler()
{
    $('.action-buttons').one('click', function (e) {
        e.preventDefault();
        $.ajax({
            method: "GET",
            url: 'BookList.aspx/OnMoveBook',
            contentType: 'application/json; charset=utf-8',
            async: false,
            data: {
                bookId: JSON.stringify(this.dataset.bookid),
                action: JSON.stringify(this.dataset.action)
            },
            success: function (data) {
                $(".notification:last").html(data.d);
                $(".notification:last").jqxNotification('open');
                $("#Table").jqxDataTable('updateBoundData');
            }
        });
    });

    $('.history-button').on('click', function (e) {
        var select = $(this);
        e.preventDefault();
        $.ajax({
            method: "GET",
            url: 'BookList.aspx/BookHistory',
            contentType: 'application/json; charset=utf-8',
            async: false,
            data: {
                bookId: JSON.stringify(this.dataset.bookid)
            },
            success: function (data) {
                var items = JSON.parse(data.d);
                var modal = $('#modal');
                var content = $('.history-content');
                content.html('');
                var title = 'Book history - ' + select.parents('tr[role="row"]').find('td:first').text();
                modal.jqxWindow('setTitle', title);
                for (var i = 0; i < items.length; i++) {

                    var row = $('<tr/>');
                    row.append('<td>'+items[i].Name + ' ' + items[i].Surname + '</td>');
                    row.append('<td>'+FormatDate(items[i].DateOut) + '</td>');
                    row.append('<td>'+FormatDate(items[i].DateIn) + '</td>');
                    content.append(row);
                }
                var template = $('.history-template');
                template.show();
                $('#modal').jqxWindow('setContent', template);
                modal.jqxWindow('open');


            }
        });
    });

    function FormatDate(d) {
        var date = new Date(parseInt(d.substr(6)));
        return date.toLocaleString();
    }
}

