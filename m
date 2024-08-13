From: Rob Herring (Arm) <robh@kernel.org>
Date: Tue, 13 Aug 2024 09:46:15 -0600
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
 <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>
Message-ID: <172356397447.1008665.7000351139259690854.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Thu, 08 Aug 2024 13:44:24 +0930, Andrew Jeffery wrote:
> Squash warnings such as:
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/interrupt-controller at 1e6c0080: failed to match any schema with compatible: ['aspeed,ast2400-vic']
> 
> The YAML DT schema defines an optional property, valid-sources, which
> was not previously described in the prose binding. It is added to
> document existing practice in the Aspeed devicetrees. Unfortunately
> the property seems to predate the requirement that vendor-specific
> properties be prefixed.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../interrupt-controller/aspeed,ast2400-vic.txt    | 23 --------
>  .../interrupt-controller/aspeed,ast2400-vic.yaml   | 62 ++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 23 deletions(-)
> 

Applied, thanks!

