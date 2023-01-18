From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 17 Jan 2023 17:17:40 -0800
Subject: [PATCH net-next 2/6] net: mdio: Rework scanning of bus ready
 for quirks
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-2-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
	<20230116-net-next-remove-probe-capabilities-v1-2-5aa29738a023@walle.cc>
Message-ID: <20230117171740.3a9e6f8d@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 16 Jan 2023 13:55:14 +0100 Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Some C22 PHYs do bad things when there are C45 transactions on the
> bus. In order to handle this, the bus needs to be scanned first for
> C22 at all addresses, and then C45 scanned for all addresses.
> 
> The Marvell pxa168 driver scans a specific address on the bus to find
> its PHY. This is a C22 only device, so update it to use the c22
> helper.

clang says:

drivers/net/phy/mdio_bus.c:708:11: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
        while (--i >= 0) {
                 ^
drivers/net/phy/mdio_bus.c:620:7: note: initialize the variable 'i' to silence this warning
        int i, err;
             ^
              = 0
