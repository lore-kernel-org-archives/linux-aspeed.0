From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Sep 2023 21:24:40 -0700
Subject: [PATCH] watchdog: aspeed: Add sysfs attributes for reset mask
 bits
In-Reply-To: <91be26169ebbddf3c05cd19626478246cb72a72a.camel@codeconstruct.com.au>
References: <20230922013542.29136-2-zev@bewilderbeest.net>
 <91be26169ebbddf3c05cd19626478246cb72a72a.camel@codeconstruct.com.au>
Message-ID: <85ddf493-934f-75c4-7a3a-728289c1ee09@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/21/23 21:16, Andrew Jeffery wrote:
> On Thu, 2023-09-21 at 18:35 -0700, Zev Weiss wrote:
>> The AST2500 and AST2600 watchdog timers provide the ability to control
>> which devices are reset by the watchdog timer via a reset mask
>> resgister.  Previously the driver ignored that register, leaving
>> whatever configuration it found at boot and offering no way of
>> altering its settings.  Add a 'reset_ctrl' sysfs subdirectory with a
>> file per bit so that userspace can determine which devices the reset
>> is applied to.
>>
>> Note that not all bits in the hardware register are exposed -- in
>> particular, the ARM CPU and SOC/misc reset bits are left hidden since
>> clearing them can render the system unable to reboot.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>
>> I'm porting OpenBMC to a platform that requires that the LPC controller remain
>> un-reset by a BMC reboot.  With this patch userspace can control the reset
>> mask of the Aspeed watchdog timer, with a few bits remaining unexposed so as
>> to prevent some almost-certainly undesirable situations.  If there are other
>> bits that people feel shouldn't be exposed (or conversely if someone feels
>> strongly that the "dangerous" bits _should_ be exposed) I can adjust
>> accordingly.
> 
> 
> Is there a reason this has to be managed by userspace? It sounds a lot
> like a property of platform design, in which case exposing this feature
> in the devicetree might be a better approach.
> 

Same sentiment here.

Guenter


