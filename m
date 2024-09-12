From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 12 Sep 2024 10:16:23 +0930
Subject: [PATCH] ARM: dts: aspeed: Fix at24 EEPROM node names
In-Reply-To: <20240910215929.823913-1-robh@kernel.org>
References: <20240910215929.823913-1-robh@kernel.org>
Message-ID: <082cea8c7ca1aa15001b7c48b1c3ef1f209cc40a.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-09-10 at 16:59 -0500, Rob Herring (Arm) wrote:
> at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks, I've applied this to be picked up through the BMC tree.

Andrew
