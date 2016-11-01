App.sandbox = App.cable.subscriptions.create("SandboxChannel", {
  connected: function() {
    updateResource();
  },
  update: function(data) {
    $( "div.error.label ").remove(); // Clear labels
    this.perform('update', data);
  },
  received: function(data) {
    if (data['output']) {
      for (var type in data['output']) {
        $("div#" + type).html(data['output'][type]);
      };
    } else if (data['errors']) {
      for (var field in data['errors']) {
        var error_msg = '<div class="ui pointing red basic error label">' + data['errors'][field] + '</div>'
        $( "div.field." + field ).append(error_msg);
      };
    }
    highlight_code();
  },
  disconnected: function() {},
});

function getActiveTab() {
  return $("a.active.item").first().attr('data-tab');
}

function getName() {
  return $("[name='name']").val();
};

function getNamespace() {
  return $("[name='namespace']").val();
};

function getSingular() {
  if ($("[name='singular']").prop('checked')) {
    return true;
  } else {
    return false;
  };
};

function getCrud() {
  var crud = [];
  $("option.crud").each(function() {
    if (this.selected) {
      crud.push(this.value);
    };
  });
  return crud;
};

function getAttributes() {
  var attributes = {};
  $("div.attribute-row").each(function() {
    var name = $(this).find($("[name='attribute-name']")).val();
    var type = $(this).find($("select")).val();
    if (name != "") {
      attributes[name] = type;
    };
  });
  return attributes;
};

function updateResource() {
  var data = {
    "input": {
       "name":       getName(),
       "namespace":  getNamespace(),
       "singular":   getSingular(),
       "crud":       getCrud(),
       "attributes": getAttributes()
    },
    "active_type": getActiveTab()
  };
  App.sandbox.update(data);
};

function add_attribute_popup() {
  $('.attribute-button')
    .popup({
      inline     : true,
      position   : 'bottom left',
      on         : 'click'
    });
};

function add_tab() {
  $('.tab-menu .item').tab();
};

function highlight_code() {
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
};

function add_select_dropdown() {
  $('select.dropdown').dropdown();
};

function listen_for_new_attributes() {
  $(".disabled-attribute").click(function() {
    var last_row = $(".attribute-row").last();
    var new_row = last_row.clone();

    // Reset new row
    new_row.find('input').val('');
    new_row.find('div.fluid.dropdown').dropdown();

    // Append in front of last row
    new_row.insertAfter(last_row);
    listen_for_changes()
  });
};


function listen_for_deleted_attributes() {
  $(".attribute-grid").on('click', ".attribute-icon.delete", function(event) {
    event.stopPropagation(); // Prevent the window from being closed
    $(this).parent().parent().remove();
    updateResource();
  });
};

function listen_for_changes() {
  $( ".form-field" ).change(function() {
    updateResource();
  });
};

$(document).ready(function() {
  add_attribute_popup();
  add_select_dropdown();
  add_tab();
  highlight_code();
  listen_for_new_attributes();
  listen_for_deleted_attributes();
  listen_for_changes();
});
