$(document).ready(function () {
  let ratings = document.querySelectorAll('.rating');
  let ratingItems = [];
  for(let i = 0; i < ratings.length; i++) {
    ratingItems[i] = ratings[i].querySelectorAll('.rating-item');
  }

  for(let i = 0; i < ratings.length; i++) {
    ratings[i].onclick = function (e) {
      let target = e.target;

      if(target.classList.contains('rating-item')) {
        removeClass(ratingItems[i], 'current-active');
        target.classList.add('current-active');
      }
    };

    ratings[i].onmouseover = function (e) {
      let target = e.target;

      if(target.classList.contains('rating-item')) {
        removeClass(ratingItems[i], 'active');
        target.classList.add('active');
        mouseOverActiveClass(ratingItems[i]);
      }
    };

    ratings[i].onmouseout = function (e) {
      addActiveClass(ratingItems[i]);
      mouseOutCurrentActive(ratingItems[i]);
    }
  }
});

function removeClass(arr) {
  for(let i = 0; i < arr.length; i++) {
    for(let j = 1; j < arguments.length; j++) {
      arr[i].classList.remove(arguments[j]);
    }
  }
}

function mouseOverActiveClass(arr) {
  for(let i = 0; i < arr.length; i++) {
    if(arr[i].classList.contains('active')) {
      break;
    } else {
      arr[i].classList.add('active');
    }
  }
}

function mouseOutCurrentActive(arr) {
  for(let i = arr.length - 1; i > 0; i--) {
    if(arr[i].classList.contains('current-active')) {
      break;
    } else {
      arr[i].classList.remove('active');
    }
  }
}

function addActiveClass(arr) {
  for(let i = 0; i < arr.length; i++) {
    arr[i].classList.add('active');
  }
}