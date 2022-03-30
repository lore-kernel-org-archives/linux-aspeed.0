From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 30 Mar 2022 13:14:22 +1030
Subject: [PATCH 1/1] net: mdio: aspeed: Add Clause 45 support
In-Reply-To: <20220329161949.19762-1-potin.lai@quantatw.com>
References: <20220329161949.19762-1-potin.lai@quantatw.com>
Message-ID: <489d851e-be29-44a3-bf56-78be33d585f2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 30 Mar 2022, at 02:49, Potin Lai wrote:
> Add Clause 45 support for Aspeed mdio driver.
>
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 122 ++++++++++++++++++++++++---------
>  1 file changed, 88 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index e2273588c75b..aa2b678b2381 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -21,6 +21,10 @@
>  #define   ASPEED_MDIO_CTRL_OP		GENMASK(27, 26)
>  #define     MDIO_C22_OP_WRITE		0b01
>  #define     MDIO_C22_OP_READ		0b10
> +#define     MDIO_C45_OP_ADDR		0b00
> +#define     MDIO_C45_OP_WRITE		0b01
> +#define     MDIO_C45_OP_PREAD		0b10
> +#define     MDIO_C45_OP_READ		0b11
>  #define   ASPEED_MDIO_CTRL_PHYAD	GENMASK(25, 21)
>  #define   ASPEED_MDIO_CTRL_REGAD	GENMASK(20, 16)
>  #define   ASPEED_MDIO_CTRL_MIIWDATA	GENMASK(15, 0)
> @@ -39,34 +43,35 @@ struct aspeed_mdio {
>  	void __iomem *base;
>  };
> 
> -static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
> +static int aspeed_mdio_ctrl_reg(struct mii_bus *bus, u8 st, u8 op, u8 phyad,

It's a bit of a nit-pick, but this function name talks about something
it impacts rather than something it does. What do you think of
`aspeed_mdio_op()`?

Less of a nitpick, this patch does three things:

1. Distills the aspeed_mdio_ctrl_reg() function from from the
   aspeed_mdio_{read,write}() functions

2. Introduces the additional function indirection for C22 vs C45 reads

3. Adds the C45 support.

I think it'd be easier to review if it was broken into three separate
patches along the lines of the above. I'm finding the hunks hard to
concentrate on as they are.

Andrew
