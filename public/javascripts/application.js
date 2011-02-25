// JQuery settings
$.ajaxSetup({
  'beforeSend': function(xhr) {
    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
  }
});

// Templates
Handlebars.registerHelper('flow_type', function(context) {
  if (context.value > 0) {
    return "income_history";
  } else {
    return "outcome_history";
  }
});

Handlebars.registerHelper('flow_value', function(context) {
  if (new String(context.value).slice(-2) == ".0") {
    return context.value.slice(0, -2);
  } else {
    return context.value;
  }
});

Handlebars.registerHelper('flow_note', function(context) {
  if (context.note.length > 0) {
    return context.note;
  } else {
    return "No note specified";
  }
});



var flow_history_link_src  = '{{#cashflows}}{{#cashflow}}<li class="arrow"><span class={{{flow_type this}}}><a class="show_link" id="{{id}}" href="#show">${{{ flow_value this }}</a></span></li>{{/cashflow}}{{/cashflows}}';
var flow_history_link  = Handlebars.compile(flow_history_link_src);

var show_tmpl_src = '<div class="toolbar"><h1>Cashflow Info</h1><a class="back" href="#">Back</a></div>{{#cashflow}}<ul><li><span class={{{flow_type this}}}>${{value}}</span></li><li>{{{flow_note this}}}</li></ul>{{/cashflow}}';
var show_tmpl = Handlebars.compile(show_tmpl_src);

// Vars
var current_flow_type = "";

$(function() {

  // Initialization
  if (!localStorage["pendingFlows"]) {
    localStorage["pendingFlows"] = JSON.stringify([]);
  }

  // Filling up history
  $.retrieveJSON("/cashflows.json", function(data) {
    var local_flows = $.parseJSON(localStorage["pendingFlows"]);

    var flows = $.parseJSON(data.cashflows).concat(local_flows);
    $("#history").html(flow_history_link({ cashflows: flows }));

    updateBalance(data.balance);
  });

  // Adding flows
  $("#income_link").click(function()  { current_flow_type = "income"; });
  $("#outcome_link").click(function() { current_flow_type = "outcome"; });

  $("#cancel_flow").click(function() { $("#new_flow")[0].reset(); });

  $("#send_flow").click(function() {
    var value = parseFloat($("#value").val().replace(",", "."));
    var note  = $("#note").val();
    var id = new Date().getTime();

    if (!value || value < 0.1) {
      alert("You should specify correct value");
      return false;
    }

    if (current_flow_type == "outcome") {
      value = -value;
    }

    var local_flows = $.parseJSON(localStorage["pendingFlows"]);
    var flow = { "id": id, "value": value, "note": note };
    flow = { cashflow: flow };
    $("#history").prepend(flow_history_link({ cashflows: flow }));

    local_flows.push(flow);
    localStorage["pendingFlows"] = JSON.stringify(local_flows);

    var new_balance = parseFloat($("#balance").html()) + value
    updateBalance(new_balance);

    var cache = $.parseJSON(localStorage["offline.jquery:/cashflows.json:"]);
    cache.balance = new_balance;
    localStorage["offline.jquery:/cashflows.json:"] = JSON.stringify(cache);

    sendFlows();

    $("#new_flow")[0].reset();
    jQT.goBack();
  });

  function updateBalance(new_balance) {
    $("#balance").html(parseFloat(new_balance));
  };

  // Talking to the server
  function sendFlows() {
    if (window.navigator.onLine) {
      var local_flows = $.parseJSON(localStorage["pendingFlows"]);
      if (local_flows.length > 0) {
        var flow = local_flows[0];
        $.post("/cashflows", { cashflow: flow.cashflow }, function(data) {
          $("#" + flow.cashflow.id).attr('id', data.id);
          flow.cashflow.id = data.id;

          var cache = $.parseJSON(localStorage["offline.jquery:/cashflows.json:"]);
          cache.cashflows = JSON.stringify($.parseJSON(cache.cashflows).concat(flow));
          console.log(cache);
          localStorage["offline.jquery:/cashflows.json:"] = JSON.stringify(cache);

          var local_flows = $.parseJSON(localStorage["pendingFlows"]);
          local_flows.shift();
          localStorage["pendingFlows"] = JSON.stringify(local_flows);

          setTimeout(sendFlows, 100);
        });
      }
    }
  }

  $(window).bind("online", sendFlows);

  // Viewing cashflows
  $("#jqt").delegate("a.show_link", "click", function() {
    var id = $(this).attr('id');
    var local_flows = $.parseJSON(localStorage["pendingFlows"]);

    var flow = null;
    $.each(local_flows, function() {
      if (this.cashflow.id == id) {
        flow = this;
        return true;
      }
    });

    if (!flow) {
      var cache = $.parseJSON(localStorage["offline.jquery:/cashflows.json:"]);
      cache.cashflows = $.parseJSON(cache.cashflows);
      $.each(cache.cashflows, function() {
        if (this.cashflow.id == id) {
          flow = this;
          return true;
        }
      });
    }

    if (flow) {
      $("#show").html(show_tmpl(flow));
    }
  });
});
