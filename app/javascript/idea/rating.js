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
        addActiveClsForPrevStars(ratingItems[i]);
      }
    };

    ratings[i].onmouseout = function (e) {
      addActiveClass(ratingItems[i]);
      mouseOutCurrentActive(ratingItems[i]);
    }
  }
});

function removeClass(elements, elementsClass) {
  for(let i = 0; i < elements.length; i++) {
    elements[i].classList.remove(elementsClass);
  }
}

function addActiveClsForPrevStars(elements) {
  for(let i = 0; i < elements.length; i++) {
    if(elements[i].classList.contains('active')) {
      break;
    } else {
      elements[i].classList.add('active');
    }
  }
}

function mouseOutCurrentActive(elements) {
  for(let i = elements.length - 1; i > 0; i--) {
    if(elements[i].classList.contains('current-active')) {
      break;
    } else {
      elements[i].classList.remove('active');
    }
  }
}

function addActiveClass(elements) {
  for(let i = 0; i < elements.length; i++) {
    elements[i].classList.add('active');
  }
}
