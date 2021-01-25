From: Troy Lee <troy_lee@aspeedtech.com>
Date: Mon, 25 Jan 2021 10:01:19 +0000
Subject: [PATCH v2 4/4] hwmon: Support Aspeed AST2600 PWM/Fan tachometer
In-Reply-To: <20210123161405.GA50622@roeck-us.net>
References: <20210113070850.1184506-1-troy_lee@aspeedtech.com>
 <20210113070850.1184506-5-troy_lee@aspeedtech.com>
 <20210123161405.GA50622@roeck-us.net>
Message-ID: <20210125100119.GA2349720@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Guenter,

The 01/24/2021 00:14, Guenter Roeck wrote:
> On Wed, Jan 13, 2021 at 07:08:48AM +0000, Troy Lee wrote:
> > Add Aspeed AST2600 PWM/Fan tacho driver. AST2600 has 16 PWM channel and
> > 16 FAN tacho channel.
> > 
> > Changes since v1:
> > - fixed review comments
> > - fixed double-looped calculation of div_h and div_l
> > - moving configuration to device tree
> > - register hwmon driver with devm_hwmon_device_register_with_info()
> > 
> > Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> 
> checkpatch says:
> 
> total: 0 errors, 9 warnings, 26 checks, 779 lines checked
> 
> This is a bit much. Please run checkpatch --strict and fix the issues
> it reports. Please also fix the issues reported by 0-day as well as
> the issues reported by the bindings robot, and resubmit.
> 
> Thanks,
> Guenter

I'll fix the WARNINGs and CHECKs.

Thanks,
Troy Lee
