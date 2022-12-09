From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 9 Dec 2022 08:48:13 +0100
Subject: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <A5EA19E5-21D8-4954-9636-9B28AC8D946A@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
 <A5EA19E5-21D8-4954-9636-9B28AC8D946A@aspeedtech.com>
Message-ID: <41500a04-b004-0e2c-20a1-3a3092b90e6d@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 09/12/2022 01:54, Billy Tsai wrote:
>     > > However I am surprised to see such change, so I have no clue why this
>     > > was done.
> 
>     > Actually now I see it was like that in previous patch, I just missed it
>     > during previous review. Anyway this must be fixed.
> 
> I have two module (PWM and TACH) but share with the same base address,
> The PWM will use the offset (N*0x10) + 0x0 and 0x04.
> The TACH will use the offset (N*0x10) + 0x8 and 0x0c.
> The range of the N is 0~15.
> Can you give me some advice to fix this problem without using simple-mfd?


Use regular driver which populates children.

Best regards,
Krzysztof

