From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 13 Feb 2024 22:45:36 -0000
Subject: [PATCH 2/6] arm: dts: Fix dtc interrupt_provider warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-2-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
	 <20240213-arm-dt-cleanups-v1-2-f2dee1292525@kernel.org>
Message-ID: <9a67cee101e7e15d5e70553e3929ee2fbd480c1f.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-02-13 at 13:34 -0600, Rob Herring wrote:
> The dtc interrupt_provider warning is off by default. Fix all the warnings
> so it can be enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/amazon/alpine.dtsi                   |  1 -
>  arch/arm/boot/dts/aspeed/aspeed-g4.dtsi                | 14 --------------
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi                | 15 +--------------
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                | 18 ++----------------

I wrote a very similar patch just a day or so ago, so thanks :)

For the Aspeed portions:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
