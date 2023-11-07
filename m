From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 7 Nov 2023 11:02:43 -0800
Subject: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed ast26xx
In-Reply-To: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
Message-ID: <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/7/23 02:50, Billy Tsai wrote:
> Unlike the old design that the register setting of the TACH should based
> on the configure of the PWM. In ast26xx, the dependency between pwm and
> tach controller is eliminated and becomes a separate hardware block. One
> is used to provide pwm output and another is used to monitor the frequency
> of the input. This driver implements them by exposing two kernel
> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
> existing drivers for controlling elements such as fans (pwm-fan.c),
> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
> provides sysfs interfaces for fan.
> 
> Changes since v9:
> Change the type of fan-driving-mode to string
> Fix some typos and formatting issues.
> 

What is the resend about ?

Guenter

