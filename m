From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 6 Apr 2022 20:58:43 +0200
Subject: [PATCH net-next RESEND v2 2/3] net: mdio: aspeed: Introduce read
 write function for c22 and c45
In-Reply-To: <20220406170055.28516-3-potin.lai@quantatw.com>
References: <20220406170055.28516-1-potin.lai@quantatw.com>
 <20220406170055.28516-3-potin.lai@quantatw.com>
Message-ID: <Yk3i496mEwOdUEyd@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 07, 2022 at 01:00:54AM +0800, Potin Lai wrote:
> Add following additional functions to move out the implementation from
> aspeed_mdio_read() and aspeed_mdio_write().
> 
> c22:
>  - aspeed_mdio_read_c22()
>  - aspeed_mdio_write_c22()
> 
> c45:
>  - aspeed_mdio_read_c45()
>  - aspeed_mdio_write_c45()
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
