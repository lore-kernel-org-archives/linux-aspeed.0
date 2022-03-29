From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 29 Mar 2022 19:39:49 +0200
Subject: [PATCH 1/1] net: mdio: aspeed: Add Clause 45 support
In-Reply-To: <20220329161949.19762-1-potin.lai@quantatw.com>
References: <20220329161949.19762-1-potin.lai@quantatw.com>
Message-ID: <YkNEZRDw1bZuc/PP@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 30, 2022 at 12:19:49AM +0800, Potin Lai wrote:
> Add Clause 45 support for Aspeed mdio driver.

This looks O.K, but please set bus->probe_capabilities to indicate
both C22 and C45.

net-next is closed at the moment, so please wait until next week
before sending the next version.

     Andrew

