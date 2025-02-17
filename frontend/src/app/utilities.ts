/**
 * format the date by Intl DateTimeFormatOptions
 * @function
 * @param {string} date
 * @param {Intl.DateTimeFormatOptions} options
 * @example
 * const options: Intl.DateTimeFormatOptions = {
 *   weekday: "long",
 *   year: "numeric",
 *   month: "long",
 *   day: "numeric",
 * };
 * formatDate({ date: date, options: options })
 * Thursday, December 20, 2012
 */

const defaultDateTimeOptions: Intl.DateTimeFormatOptions = {
  dateStyle: 'long',
  timeStyle: 'long',
};
export const formatDateTime = (
  date: string | number,
  options: Intl.DateTimeFormatOptions = defaultDateTimeOptions,
) => new Date(date).toLocaleString('en-US', options);
