const API_URL = 'https://api.quotable.io/quotes/random';

function fetchData() {
  fetch(API_URL)
    .then(response => {
      if (!response.ok) {
        throw new Error('Network Problem API could not fetch');
      }
      return response.json();
    })
    .then(data => {
      const content = data[0].content;
      const quote = document.getElementById('quote');
      quote.innerHTML = content;
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });
}

fetchData();

