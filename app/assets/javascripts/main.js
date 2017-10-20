function bug_status(val, bug_id){
  $.ajax({
    url: "/bug_status",
    type: "POST",
    data: {"status" : val, "bug_id" : bug_id},
    dataType: "html",
    success: function(data) {
      toastr.info('Status change');
    },
    error: function (textStatus, errorThrown) {
      toastr.error("Something went wrong")
    }
  });
}

function update_status_div(bug_type) {
  $.ajax({
    url: "/change_status",
    type: "POST",
    data: {"bug_type" : bug_type},
    dataType: "html",
    success: function(data) {
      $("#status").html(data);
    }
  });
}
