From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 17 Jan 2023 17:07:49 -0800
Subject: [PATCH net-next 5/6] net: phy: Decide on C45 capabilities based
 on presence of method
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-5-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
 <20230116-net-next-remove-probe-capabilities-v1-5-5aa29738a023@walle.cc>
Message-ID: <44b3d722-b07d-c924-6a71-4e0f912eab61@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/16/2023 4:55 AM, Michael Walle wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Some PHYs provide invalid IDs in C22 space. If C45 is supported on the
> bus an attempt can be made to get the IDs from the C45 space. Decide
> on this based on the presence of the C45 read method in the bus
> structure. This will allow the unreliable probe_capabilities to be
> removed.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


