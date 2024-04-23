From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Apr 2024 09:00:56 -0500
Subject: [PATCH v2] dt-bindings: watchdog: aspeed,ast2400-wdt: Convert to
 DT schema
In-Reply-To: <20240403020439.418788-1-andrew@codeconstruct.com.au>
References: <20240403020439.418788-1-andrew@codeconstruct.com.au>
Message-ID: <171388085227.112740.4043099256538346209.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Wed, 03 Apr 2024 12:34:39 +1030, Andrew Jeffery wrote:
> Squash warnings such as:
> 
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/watchdog at 1e785000: failed to match any schema with compatible: ['aspeed,ast2400-wdt']
> ```
> 
> The schema binding additionally defines the clocks property over the
> prose binding to align with use of the node in the DTS files.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v2: Address feedback from Rob and Zev
> 
>     - Rob: https://lore.kernel.org/linux-watchdog/20240402180718.GA358505-robh at kernel.org/
>     - Zev: https://lore.kernel.org/linux-watchdog/65722a59-2e94-4616-81e1-835615b0e600 at hatter.bewilderbeest.net/
> 
> v1: https://lore.kernel.org/linux-watchdog/20240402120118.282035-1-andrew at codeconstruct.com.au/
> 
>  .../bindings/watchdog/aspeed,ast2400-wdt.yaml | 142 ++++++++++++++++++
>  .../bindings/watchdog/aspeed-wdt.txt          |  73 ---------
>  2 files changed, 142 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 

Applied, thanks!

