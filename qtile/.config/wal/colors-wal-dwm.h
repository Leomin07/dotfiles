static const char norm_fg[] = "#a8b8c2";
static const char norm_bg[] = "#081833";
static const char norm_border[] = "#758087";

static const char sel_fg[] = "#a8b8c2";
static const char sel_bg[] = "#E75B5B";
static const char sel_border[] = "#a8b8c2";

static const char urg_fg[] = "#a8b8c2";
static const char urg_bg[] = "#9B5377";
static const char urg_border[] = "#9B5377";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
