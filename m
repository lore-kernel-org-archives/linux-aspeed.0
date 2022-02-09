From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 9 Feb 2022 01:55:17 +0100
Subject: [PATCH net] net: mdio: aspeed: Add missing MODULE_DEVICE_TABLE
In-Reply-To: <20220209000359.372978-1-joel@jms.id.au>
References: <20220209000359.372978-1-joel@jms.id.au>
Message-ID: <YgMQ9e6MZ2h8i73/@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 09, 2022 at 10:33:59AM +1030, Joel Stanley wrote:
> Fix loading of the driver when built as a module.
> 
> Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
