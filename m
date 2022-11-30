From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Nov 2022 15:30:57 -0600
Subject: [PATCH v3 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
In-Reply-To: <20221124105552.1006549-5-neal_liu@aspeedtech.com>
References: <20221124105552.1006549-1-neal_liu@aspeedtech.com>
 <20221124105552.1006549-5-neal_liu@aspeedtech.com>
Message-ID: <20221130213057.GA2960216-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 24, 2022 at 06:55:52PM +0800, Neal Liu wrote:
> Add device tree binding documentation for the Aspeed
> Advanced High-Performance Bus (AHB) Controller.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> new file mode 100644
> index 000000000000..cf9740f2a0c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device Tree Bindings

Drop " Device Tree Bindings"

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
