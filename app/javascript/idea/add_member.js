$(document).ready(function() {
  $('.member').bind('click', function () {
    let id = this.id.substr(this.id.length - 1);
    let name = this.innerText;
    p_id = `p_${id}`
    if(document.getElementById(p_id) === null){
      add_p(id, name)
    }else{
      remove_p(p_id)
    }
  })
})

function add_p(id, name){
  p_start = `<p id=p_${id}>`;
  str = p_start + name + " <input type='text' value='0' name='idea[local_members_attributes][][amount]'>";
  hiden_value = `value=${id}`;
  str += "<input type='hidden' " + hiden_value + " name='idea[local_members_attributes][][member_id]'> </p>";
  $('#text_fields').append(str);
}

function remove_p(id) {
  $(`#${id}`).remove();
}
