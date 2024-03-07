From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 7 Mar 2024 10:51:48 -0800
Subject: [PATCH v14 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
In-Reply-To: <20240221104025.1306227-4-billy_tsai@aspeedtech.com>
References: <20240221104025.1306227-1-billy_tsai@aspeedtech.com>
 <20240221104025.1306227-4-billy_tsai@aspeedtech.com>
Message-ID: <771b185f-98ee-475d-8075-86399b3dfe09@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 21, 2024 at 06:40:25PM +0800, Billy Tsai wrote:
> The driver support two functions: PWM and Tachometer. The PWM feature can
> handle up to 16 output ports, while the Tachometer can monitor to up to 16
> input ports as well. This driver implements them by exposing two kernel
> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> existing drivers for controlling elements such as fans (pwm-fan.c),
> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
> provides sysfs interfaces for fan.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Applied to hwmon-next. There was an outstanding suggestion:

> > +static int aspeed_pwm_tach_remove(struct platform_device *pdev)
> > +{
> > +	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
> > +
> > +	reset_control_assert(priv->reset);
> 
> This is already done by aspeed_pwm_tach_reset_assert(), looks like
> aspeed_pwm_tach_remove() can be removed. With that, priv->reset can
> become a local variable in aspeed_pwm_tach_probe().

I'll be happy to apply a follow-up patch making this change.

Thanks,
Guenter
