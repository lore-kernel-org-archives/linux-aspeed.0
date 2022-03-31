From: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Thu, 31 Mar 2022 08:12:25 +0100
Subject: [PATCH v3 2/3] net: mdio: add reset control for Aspeed MDIO
In-Reply-To: <20220325041451.894-3-dylan_hung@aspeedtech.com>
References: <20220325041451.894-1-dylan_hung@aspeedtech.com>
 <20220325041451.894-3-dylan_hung@aspeedtech.com>
Message-ID: <YkVUWV0czTzo6MrJ@shell.armlinux.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Fri, Mar 25, 2022 at 12:14:50PM +0800, Dylan Hung wrote:
> Add reset assertion/deassertion for Aspeed MDIO.  There are 4 MDIO
> controllers embedded in Aspeed AST2600 SOC and share one reset control
> register SCU50[3].  To work with old DT blobs which don't have the reset
> property, devm_reset_control_get_optional_shared is used in this change.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Should this really be specific to one driver rather than being handled
in the core mdio code?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
