// USAGE:
// node delay_ass.js subtitle.ass -32

const fs = require('fs');
const fileName = process.argv[2];
const delaySeconds = process.argv[3];
//const encoding = process.argv[4] || 'utf16le';
const encoding = 'utf-8';
// extraDelayOpts = '0:12:19:-60" - 12:19 has break - extra delay afterwards is -60 seconds
const extraDelayOpts = process.argv[4] || null
let extraDelayH = null;
let extraDelayM = null;
let extraDelayS = null;
let extraDelay = null;
if (extraDelayOpts !== null) {
    const extraDelayOptsParts = extraDelayOpts.split(':');
    extraDelayH = parseInt(extraDelayOptsParts[0]);
    extraDelayM = parseInt(extraDelayOptsParts[1]);
    extraDelayS = parseInt(extraDelayOptsParts[2]);
    extraDelay = extraDelayOptsParts[3];
}

if (typeof delaySeconds === 'undefined') {
  console.log(
    'Error: Please provide a number after file name for seconds to delay, e.g.:'
  );
  console.log('$ node delay_ass.js S02E01.ass -12.5');
  return;
}
const isDelay = !delaySeconds.startsWith('-');
const adjective = isDelay ? 'later' : 'earlier';

fs.readFile(fileName, encoding, (err, data) => {
  if (err) return console.log(err);

    //const dataLines = data.split(/\n/);
  //console.log(data.substring(0, 400));
  const dataLines = data.split(/[\r\n]+/);
    //console.log(dataLines.length);
  const newLines = dataLines.map(line => {
    if (line.startsWith('Dialogue:')) {
      return processLine(line);
    } else {
      return line;
    }
  });
  //let newData = newLines.join(/\N?\r?\n/);
  let newData = newLines.filter(it => it.indexOf('<skipme>') === -1).join('\n');
    //console.log(newLines.length);
    //if (newLines.indexOf('\N') !== -1) {
    //console.log('1');
    //newData = newLines.join('\N');
    //}

  fs.writeFile(fileName, newData, encoding, err => {
    if (err) return console.log(err);
    console.log(
      'Successfully made subtitle appear ',
      adjective,
      'by',
      delaySeconds,
      'seconds.'
    );
  });
});

function processLine(line) {
  // console.log('Old line: ', line);
  const blocks = line.split(/,/);
  const newBlocks = blocks.map((block, i) => {
    if (i === 1 || i === 2) {
      return delayTimestamp(block);
    } else {
      return block;
    }
  });

  // console.log('New line: ', newBlocks.join(','));
  return newBlocks.join(',');
}

function delayTimestamp(time, delayStr = delaySeconds) {
  // E.G. 0:14:12.04

  const timeArr = time.split(/:/).map(e => parseFloat(e, 10));
  const [h, m, s] = timeArr;
  const totalS = s + 60 * m + 3600 * h;
  const delay = parseFloat(delayStr, 10);
  const newTotalS = totalS + delay;
    if (newTotalS < 0) {
        return '<skipme>';
    }

  const newH = Math.max(0, Math.floor(newTotalS / 3600));
  const newM = Math.max(0, Math.floor((newTotalS % 3600) / 60));
  const newS = Math.max(0, newTotalS % 60);
  const newTime = [newH, newM, newS.toFixed(2)].join(':');

 
 if (!!extraDelay && ((newH > extraDelayH) || (newH == extraDelayH && newM > extraDelayM) || (newH == extraDelayH && newM == extraDelayM && newS >= extraDelayS))) {
  const delay2 = delay + parseFloat(extraDelay, 10);
  const newTotalS2 = totalS + delay2;
    if (newTotalS2 < 0) {
        return '<skipme>';
    }

  const newH2 = Math.max(0, Math.floor(newTotalS2 / 3600));
  const newM2 = Math.max(0, Math.floor((newTotalS2 % 3600) / 60));
  const newS2 = Math.max(0, newTotalS2 % 60);
  return [newH2, newM2, newS2.toFixed(2)].join(':');
 } else {
  return newTime;
 }

}
