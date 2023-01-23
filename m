From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 23 Jan 2023 12:03:08 +1030
Subject: [PATCH 2/2] dtsi:aspeed: add miss pinctrl in pinctrl dtsi
In-Reply-To: <20230103093702.2613574-3-ryan_chen@aspeedtech.com>
References: <20230103093702.2613574-1-ryan_chen@aspeedtech.com>
 <20230103093702.2613574-3-ryan_chen@aspeedtech.com>
Message-ID: <3b11d987-180d-4b99-949a-b854b1d6d39b@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

On Tue, 3 Jan 2023, at 20:07, ryan_chen wrote:
> add miss pcie rc, secure i2c, i3c, 8bit emmc, uart ncts..

Please make sure that any new functions and groups are documented in 
the devicetree bindings. Also, updates to the binding documentation 
should be in their own patch, separate to the changes to the devicetree 
itself.

Cheers,

Andrew
