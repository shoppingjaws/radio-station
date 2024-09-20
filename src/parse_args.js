// input = {"area":"JP13","exec_dayweek":"SUN","exec_time_hour":1,"exec_time_min":0,"id":"audrey","rec_dayweek":"SUN","rec_time_hour":1,"rec_time_min":0,"station":"LFR","title":"オードリーのオールナイトニッポン"}
const input = JSON.parse(process.argv[2]);

const parseDayWeek = (str) => {
  switch (str) {
    case "SUN":
      return 0;
    case "MON":
      return 1;
    case "TUE":
      return 2;
    case "WED":
      return 3;
    case "THU":
      return 4;
    case "FRI":
      return 5;
    case "SAT":
      return 6;
    default:
      throw new Error("Invalid dayweek", str);
  }
};
input.rec_dayweek = parseDayWeek(input.rec_dayweek);
const now = new Date();
const diff = now.getDay() - input.rec_dayweek;
const prev = diff < 0 ? diff + 7 : diff;
const targetDate = new Date(now.setDate(now.getDate() - prev));
const radigo_input_s = `${targetDate.getFullYear()}${String(
  targetDate.getMonth() + 1
).padStart(2, "0")}${String(targetDate.getDate()).padStart(2, "0")}${String(
  input.rec_time_hour
).padStart(2, "0")}${String(input.rec_time_min).padStart(2, "0")}`;
const cmd = `-a=${input.area} -id=${input.station} -s=${radigo_input_s}00`;
// console.log(cmd);
