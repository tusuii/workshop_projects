document.addEventListener('DOMContentLoaded', function () {
    fetch('https://www.thehindu.com/news/national/feeder/default.rss')
      .then(response => response.text())
      .then(xmlText => {
        const parser = new DOMParser();
        const xmlDoc = parser.parseFromString(xmlText, 'text/xml');
        const items = xmlDoc.querySelectorAll('item');
  
        const newsContainer = document.getElementById('newsContainer');
        items.forEach(item => {
          const title = item.querySelector('title').textContent;
          const description = item.querySelector('description').textContent;
  
          const newsItem = document.createElement('div');
          newsItem.classList.add('news-item');
          newsItem.innerHTML = `
            <div class="title">${title}</div>
            <div class="description">${description}</div>
          `;
  
          newsContainer.appendChild(newsItem);
        });
      })
      .catch(error => {
        console.error('Error fetching feed:', error);
      });
  });
  