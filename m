From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 5 Dec 2018 09:04:30 -0600
Subject: [PATCH v2] clk: aspeed: Mark lclk (LPC) and espiclk (eSPI) as
 critical
In-Reply-To: <154395687459.88331.13570416457347078441@swboyd.mtv.corp.google.com>
References: <20181204185054.24053-1-jae.hyun.yoo@linux.intel.com>
 <CACPK8XcwMMoxG6vhDhUU8RYGABx7rtBoxJvp2yDhHeD-PemdqA@mail.gmail.com>
 <154395687459.88331.13570416457347078441@swboyd.mtv.corp.google.com>
Message-ID: <697a184b-ef99-a46e-bf98-4d339b3aafd8@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/4/2018 2:54 PM, Stephen Boyd wrote:
> Quoting Joel Stanley (2018-12-04 12:51:43)
>> Hi Jae,
>>
>> On Wed, 5 Dec 2018 at 05:20, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>
>>> These interfaces are used by host to talk to BMC, and the clock
>>> source is from the host, usually from PCH. So this commit marks
>>> the lclk as critical to make it able to be enabled. Also, it marks
>>> espiclk too because eSPI is sharing the same interface with LPC.
>>
>> While this is true on the platform you have in mind, on other
>> platforms this is not the case. They do not use eSPI, and LCLK is
>> enabled by the driver that is used to configure LPC
>> (drivers/misc/aspeed-lpc-ctrl.c):
>>
>>   lpc_ctrl: lpc-ctrl at 0 {
>>       compatible = "aspeed,ast2400-lpc-ctrl";
>>       reg = <0x0 0x80>;
>>       clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
>>   }
>>
>> I wonder if we need a device tree binding to describe which clocks are critical.
> 
> A binding to describe critical clks has been rejected in the past. I
> don't think we need to have it here either? More information on why
> things are being marked critical will be helpful to see if we need to
> re-open that discussion again.
> 
>>
>> Stephen, please don't merge this patch yet.
>>
> 
> Sure.
> 

Hi Stephen and Joel,

Thanks for blocking this patch. We checked that LCLK gate can be opened
by enabling lpc-ctrl node without using this change. Please drop this
patch.

Thanks,
Jae
