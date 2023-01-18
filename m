From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 17 Jan 2023 17:07:42 -0800
Subject: [PATCH net-next 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-4-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v1-4-5aa29738a023@walle.cc>
Message-ID: <5d3d42ba-c25a-acfd-e271-003e86b290d6@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/16/2023 4:55 AM, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Now that all MDIO bus drivers which set probe_capabilities to
> MDIOBUS_C22_C45 have been converted to use the name API for C45
> transactions, perform the scanning of the bus based on which methods
> the bus provides.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>

Nice, cleanup is looking much better

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


