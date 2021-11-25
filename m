From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Thu, 25 Nov 2021 15:35:36 +0000
Subject: [PATCH v2] mdio: aspeed: Fix "Link is Down" issue
In-Reply-To: <20211125024432.15809-1-dylan_hung@aspeedtech.com>
References: <20211125024432.15809-1-dylan_hung@aspeedtech.com>
Message-ID: <YZ+tSMT4Z6CpOgJ3@shell.armlinux.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 25, 2021 at 10:44:32AM +0800, Dylan Hung wrote:
> The issue happened randomly in runtime.  The message "Link is Down" is
> popped but soon it recovered to "Link is Up".
> 
> The "Link is Down" results from the incorrect read data for reading the
> PHY register via MDIO bus.  The correct sequence for reading the data
> shall be:
> 1. fire the command
> 2. wait for command done (this step was missing)
> 3. wait for data idle
> 4. read data from data register
> 
> Fixes: f160e99462c6 ("net: phy: Add mdio-aspeed")
> Cc: stable at vger.kernel.org
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
