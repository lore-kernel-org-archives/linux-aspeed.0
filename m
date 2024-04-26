From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 08:23:24 +0200
Subject: [PATCH v3 06/14] dt-bindings: fsi: Document the FSI controller
 common properties
In-Reply-To: <20240425213701.655540-7-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-7-eajames@linux.ibm.com>
Message-ID: <3f381a54-49ce-4a45-a960-00cf2e91b044@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/04/2024 23:36, Eddie James wrote:
> Since there are multiple FSI controllers documented, the common
> properties should be documented separately and then referenced
> from the specific controller documentation.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---


> +
> +  no-scan-on-init:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      The FSI controller cannot scan the bus during initialization.
> +
> +patternProperties:
> +  "cfam@[0-9a-f],[0-9a-f]":
> +    type: object
> +    properties:
> +      chip-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32

Missing description

> +
> +      reg:
> +        maxItems: 1
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 1
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: true> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    fsi at 3400 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        compatible = "fsi-controller";

No, there is no such compatible here.

> +        reg = <0x3400 0x400>;

Neither reg.

Also, keep order of properties matching DTS coding style.


Best regards,
Krzysztof

