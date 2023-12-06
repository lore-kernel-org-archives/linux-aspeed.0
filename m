From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Wed, 6 Dec 2023 18:48:23 +0100
Subject: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed ast26xx
In-Reply-To: <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
Message-ID: <20231206174823.ok6rrufhez33rte5@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 07, 2023 at 11:02:43AM -0800, Guenter Roeck wrote:
> On 11/7/23 02:50, Billy Tsai wrote:
> > Unlike the old design that the register setting of the TACH should based
> > on the configure of the PWM. In ast26xx, the dependency between pwm and
> > tach controller is eliminated and becomes a separate hardware block. One
> > is used to provide pwm output and another is used to monitor the frequency
> > of the input. This driver implements them by exposing two kernel
> > subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> > existing drivers for controlling elements such as fans (pwm-fan.c),
> > beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
> > provides sysfs interfaces for fan.
> > 
> > Changes since v9:
> > Change the type of fan-driving-mode to string
> > Fix some typos and formatting issues.
> > 
> 
> What is the resend about ?

And to the original v10 there is a reply by Krzysztof;
see https://lore.kernel.org/linux-pwm/3d9e50db-19f0-43b3-8042-2f80a1e7b79e at linaro.org/ .

I'll mark the original and this resend as "changes-requested" in our
patchwork. Probably the most cooperative way to object is to send a v11
and point out the changes compared to v10.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20231206/03a10a77/attachment.sig>
