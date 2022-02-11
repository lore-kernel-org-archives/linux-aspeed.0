From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri, 11 Feb 2022 12:42:38 -0800
Subject: [PATCH v2] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port
 type
In-Reply-To: <YgY4IODZlKTG7yzn@smile.fi.intel.com>
References: <20220211004203.14915-1-zev@bewilderbeest.net>
 <YgY4IODZlKTG7yzn@smile.fi.intel.com>
Message-ID: <YgbKPmZIpfRPKg1k@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 11, 2022 at 02:19:12AM PST, Andy Shevchenko wrote:
>On Thu, Feb 10, 2022 at 04:42:03PM -0800, Zev Weiss wrote:
>> Commit 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to
>> set up register mapping") fixed a bug that had, as a side-effect,
>> prevented the 8250_aspeed_vuart driver from enabling the VUART's
>> FIFOs.  However, fixing that (and hence enabling the FIFOs) has in
>> turn revealed what appears to be a hardware bug in the ASPEED VUART in
>> which the host-side THRE bit doesn't get if the BMC-side receive FIFO
>> trigger level is set to anything but one byte.  This causes problems
>> for polled-mode writes from the host -- for example, Linux kernel
>> console writes proceed at a glacial pace (less than 100 bytes per
>> second) because the write path waits for a 10ms timeout to expire
>> after every character instead of being able to continue on to the next
>> character upon seeing THRE asserted.  (GRUB behaves similarly.)
>>
>> As a workaround, introduce a new port type for the ASPEED VUART that's
>> identical to PORT_16550A as it had previously been using, but with
>> UART_FCR_R_TRIG_00 instead to set the receive FIFO trigger level to
>> one byte, which (experimentally) seems to avoid the problematic THRE
>> behavior.
>
>...
>
>> +	[PORT_ASPEED_VUART] = {
>> +		.name		= "ASPEED VUART",
>> +		.fifo_size	= 16,
>> +		.tx_loadsz	= 16,
>> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
>> +		.rxtrig_bytes	= {1, 4, 8, 14},
>> +		.flags		= UART_CAP_FIFO,
>> +	},
>
>This is quite similar to AR7 type. Can that be (re-)used?
>

I suppose that could work if there's a strong preference for it, but I'd 
sort of prefer to keep it as a separate entry if that's alright.

Firstly, I haven't yet heard back from ASPEED confirming the nature of 
the underlying problem, so it seems entirely possible we'll end up 
wanting to tweak it further if they can suggest a better workaround, and 
I believe having rxtrig_bytes defined (which AR7 doesn't) enables 
adjusting the trigger-level FCR bits from userspace via sysfs, which 
could be useful for experiments relating to that.

Secondly, there are a half-dozen or so other existing entries in the 
uart_config[] array that differ only in name, so it doesn't seem to be 
something that's generally been deemed worth optimizing thus far, and 
now that the constant value has been shifted down it's just filling in a 
previously-empty slot in the array instead of expanding it further.

But mostly it strikes me as a bit...gratuitously confusing to label the 
port as something it ultimately isn't, even if they're functionally 
"close enough" (calling it an 8250 or 16550A is a bit different, as 
those are well-established, widely-emulated ones that have become 
generic nomenclature, which isn't so much the case for AR7).  While in 
the source code it could be explained with a comment, having 
/proc/tty/driver/serial (and wherever else that name might end up) 
referencing a totally unrelated MIPS SoC just seems kind of weird to me.


Zev

