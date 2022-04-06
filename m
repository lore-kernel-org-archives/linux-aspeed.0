From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 6 Apr 2022 21:00:04 +0200
Subject: [PATCH net-next RESEND v2 3/3] net: mdio: aspeed: Add c45 support
In-Reply-To: <20220406170055.28516-4-potin.lai@quantatw.com>
References: <20220406170055.28516-1-potin.lai@quantatw.com>
 <20220406170055.28516-4-potin.lai@quantatw.com>
Message-ID: <Yk3jNJMjMPj7NM8r@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 07, 2022 at 01:00:55AM +0800, Potin Lai wrote:
> Add Clause 45 support for Aspeed mdio driver.
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 35 ++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index 5becddb56117..4236ba78aa65 100644
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
> @@ -100,15 +104,37 @@ static int aspeed_mdio_write_c22(struct mii_bus *bus, int addr, int regnum,
>  
>  static int aspeed_mdio_read_c45(struct mii_bus *bus, int addr, int regnum)
>  {
> -	/* TODO: add c45 support */
> -	return -EOPNOTSUPP;
> +	int rc;
> +	u8 c45_dev = (regnum >> 16) & 0x1F;
> +	u16 c45_addr = regnum & 0xFFFF;

Sorry, missed it the first time. You should use reverse christmass
tree here. Just move rc to last.

>  static int aspeed_mdio_write_c45(struct mii_bus *bus, int addr, int regnum,
>  				 u16 val)
>  {
> -	/* TODO: add c45 support */
> -	return -EOPNOTSUPP;
> +	int rc;
> +	u8 c45_dev = (regnum >> 16) & 0x1F;
> +	u16 c45_addr = regnum & 0xFFFF;

Same here.

     Andrew
