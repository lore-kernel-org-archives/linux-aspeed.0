From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Sep 2020 14:37:29 -0600
Subject: [PATCH 1/5] dt-bindings: input: Add documentation for IBM
 Operation Panel
In-Reply-To: <20200820161152.22751-2-eajames@linux.ibm.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
 <20200820161152.22751-2-eajames@linux.ibm.com>
Message-ID: <20200908203729.GA872283@bogus>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 20, 2020 at 11:11:48AM -0500, Eddie James wrote:
> Document the bindings for the IBM Operation Panel, which provides
> a simple interface to control a server. It has a display and three
> buttons.
> Also update MAINTAINERS for the new file.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/input/ibm,op-panel.yaml          | 38 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/ibm,op-panel.yaml b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
> new file mode 100644
> index 000000000000..86a32e8f3ef0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ibm,op-panel.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ibm,op-panel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM Operation Panel
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description: |
> +  The IBM Operation Panel provides a simple interface to control the connected
> +  server. It has a display and three buttons: two directional arrows and one
> +  'Enter' button.
> +
> +properties:
> +  compatible:
> +    const: ibm,op-panel
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

additionalProperties: false

With that added,

Reviewed-by: Rob Herring <robh@kernel.org>
