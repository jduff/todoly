$('#tasks').delegate('.edit_task_link', 'click', function(){
  // show any tasks that might be hidden
  $('li.task').children().show();
  // hide any open edit forms
  $('li.task form').hide();

  // hide this task
  $(this).closest('li').children().hide();
  // show the edit form for this task
  $(this).closest('li').find('form').show();

  return false;
});

$('#tasks').delegate('.cancel_edit_link', 'click', function(){
  // hide this tasks edit form
  $(this).closest('li').find('form').hide();
  // show this task
  $(this).closest('li').children(':not(form)').show()

  return false;
});

