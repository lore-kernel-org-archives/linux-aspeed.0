From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 8 Jun 2023 07:15:49 +0000
Subject: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
In-Reply-To: <ce99a709-ba4a-eb53-39ac-88a194879000@linaro.org>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <ce99a709-ba4a-eb53-39ac-88a194879000@linaro.org>
Message-ID: <SG2PR06MB3365AE9D075601CB62C6E7F78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

        On 23/11/2022 09:24, Krzysztof Kozlowski wrote:
        >> On 23/11/2022 07:16, Billy Tsai wrote:
        >>> Add device binding for aspeed pwm-tach device which is a multi-function
        >>> device include pwm and tach function.
        >>
        >> Subject: drop second, redundant "bindings".

        > Where did you implement this comment in your v6?

Sorry, I guess by "Subject: drop second, redundant "bindings"" you meant to remove the second "bindings" string from my subject. So I change the subject from "dt-bindings: hwmon: Add bindings for aspeed tach controller" and "dt-bindings: pwm: Add bindings for aspeed pwm controller" in v4 to "dt-bindings: hwmon: Add ASPEED TACH Control documentation" and "dt-bindings: pwm: Add ASPEED PWM Control documentation" in v6.
If I have misunderstood your comment, please let me know.

        >> Also use proper PATCH prefix.

        > Where did you implement this comment in your v6?

I apologize for forgetting that part of the change.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230608/0e58986b/attachment.htm>
