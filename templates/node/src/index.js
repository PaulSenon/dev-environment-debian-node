const {parse} = require('node-html-parser');

const html = '<p>a</p>  <p>b</p>  <div><p>1</p> <p>2</p> <p>3</p></div> <p>c</p> <p>d</p> <p>e</p>'
const replacement = '<span>HELLOOOOOOOOOOOOO</span>';

function insertHtml(htmlSource, htmlElement, position = 0) {
  const dom = parse(`${htmlSource}`);
  try{
    dom.querySelector(`:root > p:nth-of-type(${position})`)
      ?.insertAdjacentHTML('afterend', htmlElement);
  } catch(err) {
    console.error('Failled to parse html:', err);
  }
  return dom.toString();
}

console.log(insertHtml(html, replacement, 3));