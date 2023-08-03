const API_URL = 'https://gist.githubusercontent.com/tusuii/60d95a6b0214a679956502980b3f55d7/raw/100d6206de65d9f90327e07af9a29ea1649b0395/quote.json';

function fetchData() {
  fetch(API_URL)
    .then(response => {
      if (!response.ok) {
        throw new Error('Network Problem API could not fetch');
      }
      return response.json();
    })
    .then(data => {
      const randomIndex = Math.floor(Math.random() * data.length);
      const randomQuote = data[randomIndex];

      // quoteElement.textContent = randomQuote.quote;
      const content = data[0].content;
      const quote = document.getElementById('quote');
      quote.innerHTML = randomQuote.quote;
    })
    .catch(error => {
      console.error('Error fetching data:', error);
    });
}

fetchData();
