const fs = require('fs')
const readline=require('readline')

const title = process.env.TITLE
const id=process.env.ID
const rssEndpoint  = process.env.RSS_ENDPOINT
const image = process.env.IMAGE

// const reader = readline.createInterface({input:fs.createReadStream(__dirname+"/test/playlist.txt")})
const reader = readline.createInterface({input:fs.createReadStream("/tmp/playlist.txt")})
let body =""
reader.on("line",(line)=>{
  const input = line.split(" ").filter(f=>f!="")
  const date = input[0] + " " + input[1]
  const filelength = input[2]
  const filename = input[3]
  body += genItem(filename,filelength,date)
})

const genItem =(filename,filelength,date)=>{
  const ext = filename.split(".").pop()
  return `<item>
  <title>${filename}</title>
  <itunes:author>ShoppingJaws</itunes:author>
  <itunes:image href="${image}"/>
  <pubDate>${new Date(date).toUTCString()}</pubDate>
  <enclosure url="${rssEndpoint}/${id}/${filename}" length="${filelength}" type="audio/${ext}" charset="binary"/>
  </item>`
}

reader.on("close",()=>{
  const before = `<?xml version="1.0" encoding="UTF-8" ?>
  <rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
  <channel>
  <title>${title}</title>
  <itunes:author>ShoppingJaws</itunes:author>
  <itunes:summary></itunes:summary>
  <itunes:image href="${image}"/>`
  const after = `</channel>
  </rss>`
})