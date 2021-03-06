const menuReservationsRegExp = new RegExp(/\/menus\/\d+\/reservations/);
const userShowRegExp = new RegExp(/\/users\/\d+/);
const shopShowRegExp = new RegExp(/\/shops\/\d+/);
const numberRegExp = new RegExp(/\d+/);

$(function () {
  // 画面遷移を検知
  $(document).on('turbolinks:load', function () {
      if ($('#calendar').length) {

          function generateJSONPath() {
            const path = window.location.pathname;
            const numbers = path.match(numberRegExp);
            if (numbers.length == 0) return;
            const number = numbers[0]

            if (!!path.match(menuReservationsRegExp)) {
              return `/menus/${number}/reservations.json`
            } else if (!!path.match(userShowRegExp)) {
              return `/users/${number}.json`
            } else if (!!path.match(shopShowRegExp)) {
              return `/shops/${number}.json`
            }
          }

          function Calendar() {
              return $('#calendar').fullCalendar({
              });
          }
          function clearCalendar() {
              $('#calendar').html('');
          }

          $(document).on('turbolinks:load', function () {
              Calendar();
          });
          $(document).on('turbolinks:before-cache', clearCalendar);

          //events: '/events.json', 以下に追加
          $('#calendar').fullCalendar({
              events: generateJSONPath(),
              //カレンダー上部を年月で表示させる
              titleFormat: 'YYYY年 M月',
              //曜日を日本語表示
              dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
              //ボタンのレイアウト
              header: {
                  left: 'month,agendaWeek,listMonth',
                  center: 'title',
                  right: 'today prev,next'
              },
              buttonText: {
                  prev: '前',
                  next: '次',
                  prevYear: '前年',
                  nextYear: '翌年',
                  today: '今日',
                  month: '月',
                  week: '週',
                  day: '日'
              },
              //イベントの色を変える
              eventColor: '#87cefa',
              //イベントの文字色を変える
              eventTextColor: '#000000',
              defaultView: 'month',
              displayEventTime: true,
              displayEventEnd: true,
              timeFormat: "HH:mm"
          });
      }
  });
});
