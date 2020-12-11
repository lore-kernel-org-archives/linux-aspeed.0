From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 11 Dec 2020 11:00:48 +0000
Subject: [PATCH] driver: aspeed: g6: Fix PWMG0 pinctrl setting
In-Reply-To: <CACPK8XdDn7GfGKAwZnoZrFc5wZW4p=xMuLmCcHvEyyNJZ8rGvw@mail.gmail.com>
References: <20201211031741.23711-1-billy_tsai@aspeedtech.com>
 <CACPK8XdDn7GfGKAwZnoZrFc5wZW4p=xMuLmCcHvEyyNJZ8rGvw@mail.gmail.com>
Message-ID: <D9745FBC-BEA7-421E-B56C-21EA9AAE094E@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

?On 2020/12/11, 6:55 PM, Joel Stanley wrote:

    On Fri, 11 Dec 2020 at 03:18, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
    >
    > The SCU offset for signal PWM8 in group PWM8G0 is wrong, fix it from
    > SCU414 to SCU4B4.
    > Besides that, When PWM8~15 of PWMG0 set it needs to clear SCU414 bits at
    > the same time.
    >
    > Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
    >
    > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    > ---
    >  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 26 ++++++++++++++--------
    >  1 file changed, 17 insertions(+), 9 deletions(-)
    >
    > diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
    > index 34803a6c7664..6e61f045936f 100644
    > --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
    > +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
    > @@ -346,50 +346,58 @@ FUNC_GROUP_DECL(RGMII4, F24, E23, E24, E25, D26, D24, C25, C26, C24, B26, B25,
    >  FUNC_GROUP_DECL(RMII4, F24, E23, E24, E25, C25, C24, B26, B25, B24);
    >
    >  #define D22 40
    > -SIG_EXPR_LIST_DECL_SESG(D22, SD1CLK, SD1, SIG_DESC_SET(SCU414, 8));
    > -SIG_EXPR_LIST_DECL_SEMG(D22, PWM8, PWM8G0, PWM8, SIG_DESC_SET(SCU414, 8));
    > +SIG_EXPR_LIST_DECL_SESG(D22, SD1CLK, SD1, SIG_DESC_SET(SCU414, 8))
    
    Is this missing a semicolon?

Yes, thanks for your check. I will send v2 to fix it.
    
    > +SIG_EXPR_LIST_DECL_SEMG(D22, PWM8, PWM8G0, PWM8, SIG_DESC_SET(SCU4B4, 8),
    > +                       SIG_DESC_CLEAR(SCU414, 8));
    

