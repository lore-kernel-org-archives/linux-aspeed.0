From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 8 Aug 2024 12:48:29 +0200
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
 <20240808-dt-warnings-irq-aspeed-dt-schema-v2-1-c2531e02633d@codeconstruct.com.au>
Message-ID: <721f2102-0f2b-4d01-aadc-15aa6d1d837f@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/08/2024 06:14, Andrew Jeffery wrote:
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

