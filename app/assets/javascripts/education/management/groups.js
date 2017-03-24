$(document).ready(function() {
  $('.edu-group-tab-1').addClass('edu-group-active active');
  $('#edu-group-tab-1').addClass('edu-group-active active');
  $('.edu-group-tabs .edu-group-tab-links a').on('click', function(e)  {
    var currentAttrValue = $(this).attr('href');
    $('.edu-group-tabs ' + currentAttrValue).show().siblings().hide();
    $(this).parent('li').addClass('edu-group-active').siblings().removeClass('edu-group-active');
    e.preventDefault();
  });

  var data = {};
  $('.edu-permission-info').on('change', function(e) {
    var id = this.dataset.id;
    create = $('#create-' + id).is(":checked");
    read = $('#read-' + id).is(":checked");
    update = $('#update-' + id).is(":checked");
    destroy = $('#destroy-' + id).is(":checked");
    data[id] = {create: create, read: read, update: update, destroy: destroy};
    e.preventDefault();
  });

  $('.edu-update-permission a').on('click', function(e) {
    $.ajax({
      type: 'post',
      url: '/education/management/permissions',
      data: {permissions: JSON.stringify(data)},
      success: function(data) {
        if(data.status === 200) {
          $.growl.notice({message: data.flash});
        }
        else {
          $.growl.error({message: data.flash});
          location.reload();
        }
      },
      error: function(error) {
        $.growl.error({message: error});
        location.reload();
      }
    });
    e.preventDefault();
  });
});
