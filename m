From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 8 Jun 2023 08:37:57 +0200
Subject: [v6 0/4] Support pwm/tach driver for aspeed ast26xx
In-Reply-To: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
References: <20230608021839.12769-1-billy_tsai@aspeedtech.com>
Message-ID: <797c61d2-b8f1-e80e-24b9-4c7a7d266080@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/06/2023 04:18, Billy Tsai wrote:
> Unlike the old design that the register setting of the TACH should based
> on the configure of the PWM. In ast26xx, the dependency between pwm and
> tach controller is eliminated and becomes a separate hardware block. One
> is used to provide pwm output and another is used to monitor the frequency
> of the input. Therefore, this patch serials implements them by writing the
> two driver "pwm-aspeed-ast2600.c" and "tach-aspeed-ast2600.c". The former
> is following the pwm subsystem which can apply the existed driver to
> controller the fan(pwm-fan.c), beeper(pwm-beeper.c) and so on. The latter
> is following the sysfs interface of hwmon to creat the node for fan
> monitor.

You like to ignore my comments... How did you implement them? Go one by
one - answer to v4 emails.

Best regards,
Krzysztof

