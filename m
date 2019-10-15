From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Oct 2019 14:26:02 -0500
Subject: [PATCH 11/16] dt-bindings: mtd: aspeed-smc: Add new comptatible
 for  AST2600
In-Reply-To: <20191004115919.20788-12-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
 <20191004115919.20788-12-clg@kaod.org>
Message-ID: <20191015192602.GA2299@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri,  4 Oct 2019 13:59:14 +0200, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= wrote:
> The SMC controllers on the AST2600 SoC are very similar to the the
> AST2500. The SoC has one Firmware Memory Controller and two SPI flash
> memory controllers.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: C?dric Le Goater <clg@kaod.org>
> ---
>  Documentation/devicetree/bindings/mtd/aspeed-smc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
