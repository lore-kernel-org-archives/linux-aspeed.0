From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 6 Apr 2022 20:58:11 +0200
Subject: [PATCH net-next RESEND v2 1/3] net: mdio: aspeed: move reg
 accessing part into separate functions
In-Reply-To: <20220406170055.28516-2-potin.lai@quantatw.com>
References: <20220406170055.28516-1-potin.lai@quantatw.com>
 <20220406170055.28516-2-potin.lai@quantatw.com>
Message-ID: <Yk3iw0ENOYUBrXK2@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 07, 2022 at 01:00:53AM +0800, Potin Lai wrote:
> Add aspeed_mdio_op() and aseed_mdio_get_data() for register accessing.
> 
> aspeed_mdio_op() handles operations, write command to control register,
> then check and wait operations is finished (bit 31 is cleared).
> 
> aseed_mdio_get_data() fetchs the result value of operation from data
> register.
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
