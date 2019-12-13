$(document).ready(function() {
  $('.member').bind('click', function () {
    let id = this.id.substr(this.id.length - 1);
    let name = this.innerText
    $('#text_fields').append("<p>" + name + " <input type='text' value='0'> </p>")
  })
})
