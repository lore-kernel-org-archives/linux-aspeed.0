From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 15 Jan 2024 10:25:49 +0100
Subject: [PATCH v12 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
In-Reply-To: <20240108074348.735014-2-billy_tsai@aspeedtech.com>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-2-billy_tsai@aspeedtech.com>
Message-ID: <54929342-7e06-4e39-a7e9-e5dc787406ce@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/01/2024 08:43, Billy Tsai wrote:
> +  pwms:
> +    description:
> +      PWM provider.
> +    maxItems: 1
> +
> +  "#cooling-cells":
> +    const: 2
> +
> +  cooling-levels:
> +    description:
> +      The control value which correspond to thermal cooling states.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  tach-ch:
> +    description:
> +      The tach channel used for the fan.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array

What is the tach-channel and why is it different from pwm specifier?

Best regards,
Krzysztof

