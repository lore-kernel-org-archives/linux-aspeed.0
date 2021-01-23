From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Jan 2021 08:14:05 -0800
Subject: [PATCH v2 4/4] hwmon: Support Aspeed AST2600 PWM/Fan tachometer
In-Reply-To: <20210113070850.1184506-5-troy_lee@aspeedtech.com>
References: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
 <20210113070850.1184506-5-troy_lee@aspeedtech.com>
Message-ID: <20210123161405.GA50622@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 13, 2021 at 07:08:48AM +0000, Troy Lee wrote:
> Add Aspeed AST2600 PWM/Fan tacho driver. AST2600 has 16 PWM channel and
> 16 FAN tacho channel.
> 
> Changes since v1:
> - fixed review comments
> - fixed double-looped calculation of div_h and div_l
> - moving configuration to device tree
> - register hwmon driver with devm_hwmon_device_register_with_info()
> 
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>

checkpatch says:

total: 0 errors, 9 warnings, 26 checks, 779 lines checked

This is a bit much. Please run checkpatch --strict and fix the issues
it reports. Please also fix the issues reported by 0-day as well as
the issues reported by the bindings robot, and resubmit.

Thanks,
Guenter
