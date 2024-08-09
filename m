From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 09 Aug 2024 16:36:00 +0930
Subject: [PATCH 0/7] ARM: dts: aspeed: Miscellaneous devicetree cleanups
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <3ace8d9363265449acc124316b9a76b9f8d095a9.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-08-02 at 13:55 +0930, Andrew Jeffery wrote:
> Hello,
> 
> As mentioned elsewhere the Aspeed devicetrees are in a bit of a sad
> state. This series is a collection of fixes that make them a little
> less so.
> 
> If there no concerns raised in the near future I'll queue them up for
> the BMC tree.
> 
> Andrew
> 
> ---
> Andrew Jeffery (7):
>       ARM: dts: aspeed: Fix coprocessor interrupt controller node name
>       ARM: dts: aspeed: Specify correct generic compatible for CVIC
>       ARM: dts: aspeed: Specify required properties for sram node
>       ARM: dts: aspeed: Remove undocumented XDMA nodes
>       ARM: dts: aspeed: Clean up AST2500 pinctrl properties
>       ARM: dts: aspeed-g6: Use generic 'ethernet' for ftgmac100 nodes
>       ARM: dts: aspeed-g6: Drop cells properties from ethernet nodes

I've applied these to be picked up through the BMC tree.

Andrew
