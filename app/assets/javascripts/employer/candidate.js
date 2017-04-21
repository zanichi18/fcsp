$(document).ready(function() {
  candidatesByJob();
});

function candidatesByJob() {
  $('#select-job').on('change', function() {
    var selected_index = this.selectedIndex;
    var job_id = $(this).val();
    var company_id = $('#company-id').val();

    $.ajax({
      dataType: 'html',
      url: '/employer/companies/' + company_id + '/candidates',
      method: 'get',
      data: {select: job_id},
      success: function(data) {
        $('#list-candidates').empty();
        $('#list-candidates').append(data);
      },
      error: function() {
        alert(I18n.t('employer.candidates.not_found'));
      }
    })
  });
}
