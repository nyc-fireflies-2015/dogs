$("#add-dog").on('click', function(e) {
  e.preventDefault();
  $("#dog-form").show();
});

$("#new-dog").on('submit', function(e) {
  e.preventDefault();

  $.ajax('/dogs', {
    data: $(this).serialize(),
    method: 'POST'
  }).done(function(data) {
    $("#dog-list").append(data);
    $("#dog-form").hide();
  }).fail(function() {
    alert("i died...sad...so sad");
  });
});

$("#demo").on('click', function(e) {
  e.preventDefault();
  $.ajax("/opt")
    .done(function(data) {
      debugger
      var obj = JSON.parse(data)
      console.log(obj.status)
    })
})

$(".like-dog").on('submit', function(e) {
  var clickTarget = $(e.target);

  e.preventDefault();
  //console.log("want to submit a thing " + $(e.target).attr('action') );

  $.ajax(clickTarget.attr('action'), {
    method: "PATCH",
    data: clickTarget.serialize()
  })
  .done(function(data) {
    clickTarget
      .parents(".dog-list-item")
      .replaceWith(data);
  })
  .fail(function() {
    console.error("sad face");
  });
});

var dogClickFunction = function(e) {
  var clickTarget = $(e.target),
    url = "/dogs/" + clickTarget.attr('name')
  $.ajax(url, {
    method: "PATCH",
  })
  .done(function(data) {
    clickTarget
      .parent()
      .replaceWith(data)
      .find("input")
      .on('click', dogClickFunction);
  })
  .fail(function() {
    console.error("sad face");
  });
}

$("#dog-list").on('click', dogClickFunction);
