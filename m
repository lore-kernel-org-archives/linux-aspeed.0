From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 25 May 2021 13:12:59 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v1_3/3]_pinctrl:_pinctrl-aspeed-g6:_Add_sgpio_pinct?=
 =?UTF-8?Q?rl_settings?=
In-Reply-To: <20210525030254.GA23525@aspeedtech.com>
References: <20210524111338.16049-1-steven_lee@aspeedtech.com>
 <20210524111338.16049-4-steven_lee@aspeedtech.com>
 <43b00f2e-4381-4899-b561-da9a24347f8b@www.fastmail.com>
 <20210525030254.GA23525@aspeedtech.com>
Message-ID: <b38cf7e0-6cce-4cb3-8bb7-d711b1fe6eb2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 25 May 2021, at 12:32, Steven Lee wrote:
> The 05/25/2021 08:54, Andrew Jeffery wrote:
> > Hi Steven,
> > 
> > On Mon, 24 May 2021, at 20:43, Steven Lee wrote:
> > > AST2600 supports 2 SGPIO master interfaces and 2 SGPIO slave interfaces.
> > > Current pinctrl driver only define the first sgpio master and slave
> > > interfaces.
> > > The sencond SGPIO master and slave interfaces should be added in
> > > pinctrl driver as well.
> > > 
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > ---
> > >  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 24 ++++++++++++++++++----
> > >  drivers/pinctrl/aspeed/pinmux-aspeed.h     |  9 ++++++++
> > >  2 files changed, 29 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c 
> > > b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > > index 5c1a109842a7..d0e9ab9d1a9c 100644
> > > --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > > +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> > > @@ -46,8 +46,10 @@
> > >  #define SCU620		0x620 /* Disable GPIO Internal Pull-Down #4 */
> > >  #define SCU634		0x634 /* Disable GPIO Internal Pull-Down #5 */
> > >  #define SCU638		0x638 /* Disable GPIO Internal Pull-Down #6 */
> > > +#define SCU690		0x690 /* Multi-function Pin Control #24 */
> > >  #define SCU694		0x694 /* Multi-function Pin Control #25 */
> > >  #define SCU69C		0x69C /* Multi-function Pin Control #27 */
> > > +#define SCU6D0		0x6D0 /* Multi-function Pin Control #29 */
> > >  #define SCUC20		0xC20 /* PCIE configuration Setting Control */
> > >  
> > >  #define ASPEED_G6_NR_PINS 256
> > > @@ -81,13 +83,17 @@ FUNC_GROUP_DECL(I2C12, L26, K24);
> > >  #define K26 4
> > >  SIG_EXPR_LIST_DECL_SESG(K26, MACLINK1, MACLINK1, SIG_DESC_SET(SCU410, 4));
> > >  SIG_EXPR_LIST_DECL_SESG(K26, SCL13, I2C13, SIG_DESC_SET(SCU4B0, 4));
> > > -PIN_DECL_2(K26, GPIOA4, MACLINK1, SCL13);
> > > +SIG_EXPR_LIST_DECL_SESG(K26, SGPS2CK, SGPS2, SIG_DESC_SET(SCU690, 4));
> > > +SIG_EXPR_LIST_DECL_SESG(K26, SGPM2CLK, SGPM2, SIG_DESC_SET(SCU6D0, 4));
> > > +PIN_DECL_4(K26, GPIOA4, SGPM2CLK, SGPS2CK, MACLINK1, SCL13);
> > 
> > Is this the right priority order? Looking at the Multi-Function Pin 
> > Mapping and Control table, function 1 is MACLINK1,
> > function 2 is SCL13, function 3 is SGPS2CK, and I assume function 4 
> > would be SGPM2CLK, except it's not documented in the table in v9 of the 
> > datasheet (I hope it will be documented?).
> > 
> > If function 1 is the highest priority (which is what all the Aspeed 
> > pinctrl drivers assume), then this should be:
> > 
> > PIN_DECL_4(K26, GPIOA4, MACLINK1, SCL13, SGPS2CK, SGPM2CLK);
> > 
> > Anyway, one of several things could be at fault here:
> > 
> > 1. I've made a wrong assumption about the priority order in how I've 
> > implemented pinctrl support for Aspeed SoCs
> > 
> > 2. The Multi-Function Pin Mapping and Control table is out of date and 
> > needs to be fixed (which it already does as it doesn't list SGPM2CLK).
> > 
> > 3. The patch needs to align with the assumptions of the Aspeed pinctrl 
> > support.
> > 
> > I don't think it's 1 as I haven't heard of any issues where we are 
> > getting incorrect behaviour because of pinmux. I don't think it's 2 as 
> > this patch makes a non-linear change to the ordering. So my hunch is
> > the issue is 3, that the patch is putting the signals in the wrong order.
> > In this case, you want the PIN_DECL_4(...) I outlined above.
> > 
> 
> Yes, you are right. Per discussion with the designer, the priority order is
> MACLINK1 > SCL13 > SGPS2CK > SGPM2CLK
> 
> We will add the information in the v10 datasheet.

Great. Thanks Steven.

Andrew
