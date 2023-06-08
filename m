From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 8 Jun 2023 09:20:08 +0200
Subject: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <SG2PR06MB3365AE9D075601CB62C6E7F78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <ce99a709-ba4a-eb53-39ac-88a194879000@linaro.org>
 <SG2PR06MB3365AE9D075601CB62C6E7F78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <5000d481-2125-95e0-4033-d9c71a49cbd7@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/06/2023 09:15, Billy Tsai wrote:
>         On 23/11/2022 09:24, Krzysztof Kozlowski wrote:
>         >> On 23/11/2022 07:16, Billy Tsai wrote:
>         >>> Add device binding for aspeed pwm-tach device which is a multi-function
>         >>> device include pwm and tach function.
>         >>
>         >> Subject: drop second, redundant "bindings".
> 
>         > Where did you implement this comment in your v6?
> 
> Sorry, I guess by "Subject: drop second, redundant "bindings"" you meant to remove the second "bindings" string from my subject. So I change the subject from "dt-bindings: hwmon: Add bindings for aspeed tach controller" and "dt-bindings: pwm: Add bindings for aspeed pwm controller" in v4 to "dt-bindings: hwmon: Add ASPEED TACH Control documentation" and "dt-bindings: pwm: Add ASPEED PWM Control documentation" in v6.

A nit, subject: drop second/last, redundant "documentation". The
"dt-bindings" prefix is already stating that these are bindings and
documentation.

> If I have misunderstood your comment, please let me know.

You replaced one redundant with other redundant. I only asked to drop
it, not replace it.


Best regards,
Krzysztof

