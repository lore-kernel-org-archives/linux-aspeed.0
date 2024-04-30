From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 30 Apr 2024 08:54:32 +0200
Subject: [PATCH v4 05/17] dt-bindings: fsi: Document the IBM SBEFIFO
 engine
In-Reply-To: <20240429210131.373487-6-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-6-eajames@linux.ibm.com>
Message-ID: <b89bb761-49dc-4e76-9b80-c45e2b7e7638@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/04/2024 23:01, Eddie James wrote:
> The SBEFIFO engine provides an interface to the POWER processor
> Self Boot Engine (SBE).
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> Changes since v3:
>  - Drop occ unit address
> 
>  .../bindings/fsi/ibm,p9-sbefifo.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
> 
> diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
> new file mode 100644
> index 000000000000..24903829fca1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fsi/ibm,p9-sbefifo.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: IBM FSI-attached SBEFIFO engine
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +description:
> +  The SBEFIFO is an FSI CFAM engine that provides an interface to the
> +  POWER processor Self Boot Engine (SBE). This node will always be a child
> +  of an FSI CFAM node.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ibm,p9-sbefifo
> +      - ibm,odyssey-sbefifo
> +
> +  reg:
> +    items:
> +      - description: FSI slave address
> +
> +patternProperties:
> +  "^occ":

Same questions as patch #4.

> +    type: object
> +    $ref: ibm,p9-occ.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    fsi-slave-engine at 2400 {
> +        compatible = "ibm,p9-sbefifo";
> +        reg = <0x2400 0x400>;
> +
> +        occ {
> +            compatible = "ibm,p9-occ";
> +
> +            hwmon {
> +                compatible = "ibm,p9-occ-hwmon";

Three nodes which should be just one node.

Best regards,
Krzysztof

