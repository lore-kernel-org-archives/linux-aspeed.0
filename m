From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 17 Jan 2023 17:07:27 -0800
Subject: [PATCH net-next 2/6] net: mdio: Rework scanning of bus ready for
 quirks
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-2-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v1-2-5aa29738a023@walle.cc>
Message-ID: <517488dc-069d-9e5e-c671-0dcf78e61172@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/16/2023 4:55 AM, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Some C22 PHYs do bad things when there are C45 transactions on the
> bus. In order to handle this, the bus needs to be scanned first for
> C22 at all addresses, and then C45 scanned for all addresses.
> 
> The Marvell pxa168 driver scans a specific address on the bus to find
> its PHY. This is a C22 only device, so update it to use the c22
> helper.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

