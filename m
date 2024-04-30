From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 30 Apr 2024 09:01:50 +0200
Subject: [PATCH v4 06/17] dt-bindings: fsi: Document the FSI controller
 common properties
In-Reply-To: <20240429210131.373487-7-eajames@linux.ibm.com>
References: <20240429210131.373487-1-eajames@linux.ibm.com>
 <20240429210131.373487-7-eajames@linux.ibm.com>
Message-ID: <3bcc9143-6896-496b-aa30-7ac0fc2d8e51@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/04/2024 23:01, Eddie James wrote:
> +
> +patternProperties:
> +  "cfam@[0-9a-f],[0-9a-f]":
> +    type: object
> +    properties:
> +      chip-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Processor index

fsi.txt tells a bit more about it, so extend the description.


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
> +    additionalProperties: true
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    fsi {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +
> +        cfam at 0,0 {
> +            reg = <0 0>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            chip-id = <0>;
> +        };
> +    };

Drop the example, it's not being validated/used.

Best regards,
Krzysztof

