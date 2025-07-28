const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#081833", /* black   */
  [1] = "#9B5377", /* red     */
  [2] = "#E75B5B", /* green   */
  [3] = "#145B81", /* yellow  */
  [4] = "#375983", /* blue    */
  [5] = "#485783", /* magenta */
  [6] = "#5C7389", /* cyan    */
  [7] = "#a8b8c2", /* white   */

  /* 8 bright colors */
  [8]  = "#758087",  /* black   */
  [9]  = "#9B5377",  /* red     */
  [10] = "#E75B5B", /* green   */
  [11] = "#145B81", /* yellow  */
  [12] = "#375983", /* blue    */
  [13] = "#485783", /* magenta */
  [14] = "#5C7389", /* cyan    */
  [15] = "#a8b8c2", /* white   */

  /* special colors */
  [256] = "#081833", /* background */
  [257] = "#a8b8c2", /* foreground */
  [258] = "#a8b8c2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
