const targetDay = 6 // 0 (Sunday) to 6 (Saturday)
const now = new Date();
const diff = now.getDay() - targetDay
const prev = diff < 0 ? diff + 7 : diff;
const lastTraget= new Date(now.setDate(now.getDate() - prev))
console.log(`${lastTraget.getFullYear()}${lastTraget.getMonth()+1}${lastTraget.getDate()}`)