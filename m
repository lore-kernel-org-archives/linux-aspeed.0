From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 17 Jan 2023 17:07:12 -0800
Subject: [PATCH net-next 1/6] net: mdio: Move mdiobus_scan() within file
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-1-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v1-1-5aa29738a023@walle.cc>
Message-ID: <30225b71-18f8-1948-9d1b-95e418d14748@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/16/2023 4:55 AM, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> No functional change, just place it earlier in preparation for some
> refactoring.
> 
> While at it, correct the comment format and one typo.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


