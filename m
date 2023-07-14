From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Jul 2023 09:13:53 +0200
Subject: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
Message-ID: <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/07/2023 09:04, ??? wrote:

>         > This is because our register layout for PWM and Tach is not
> continuous.
> 
>         > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
> 
>         > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
> 
>         > ...
> 
>         > Each PWM/Tach instance has its own controller register and is not
> dependent on others.

Your email reply quoting style is very difficult to read.

> 
> 
> 
> Hi Guenter,
> 
> 
> 
> Did you receive a response to my previous email?
> 
> I would like to inquire if you have any further concerns regarding the PWM
> and Tach with 16 instances.

But isn't like this in all PWMs in all SoCs?

Best regards,
Krzysztof

