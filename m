From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Thu, 16 Jan 2020 10:41:42 -0800
Subject: [PATCH 1/2] clk: aspeed: add critical clock setting logic
In-Reply-To: <3cafc96a-0ec5-d51c-94cc-2b2e41cc5c65@molgen.mpg.de>
References: <20200115212639.4998-1-jae.hyun.yoo@linux.intel.com>
 <20200115212639.4998-2-jae.hyun.yoo@linux.intel.com>
 <3cafc96a-0ec5-d51c-94cc-2b2e41cc5c65@molgen.mpg.de>
Message-ID: <0ba94fd3-e57f-82bc-0770-d623c2ce0a3b@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Paul,

On 1/16/2020 1:57 AM, Paul Menzel wrote:
> Dear Jae,
> 
> 
> On 2020-01-15 22:26, Jae Hyun Yoo wrote:
>> This commit adds critical clock setting logic that applies
>> CLK_IS_CRITICAL flag if it detects 'clock-critical' property in
>> device tree.
> 
> Tested how?

I added in the cover letter how I tested it. For an example, BCLK
can have the flag if I add below setting into one of
'aspeed-bmc-*.dts' files.

&syscon {
	clock-critical = <ASPEED_CLK_GATE_BCLK>;
};

>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   drivers/clk/clk-aspeed.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
>> index 411ff5fb2c07..d22eeb574ede 100644
>> --- a/drivers/clk/clk-aspeed.c
>> +++ b/drivers/clk/clk-aspeed.c
>> @@ -541,8 +541,11 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>>   
>>   	for (i = 0; i < ARRAY_SIZE(aspeed_gates); i++) {
>>   		const struct aspeed_gate_data *gd = &aspeed_gates[i];
>> +		unsigned long flags = gd->flags;
>>   		u32 gate_flags;
>>   
>> +		of_clk_detect_critical(pdev->dev.of_node, i, &flags);
>> +
> 
> The function description in `drivers/clk/clk.c` has the warning below.
> 
>>   * Do not use this function. It exists only for legacy Device Tree
>>   * bindings, such as the one-clock-per-node style that are outdated.
>>   * Those bindings typically put all clock data into .dts and the Linux
>>   * driver has no clock data, thus making it impossible to set this flag
>>   * correctly from the driver. Only those drivers may call
>>   * of_clk_detect_critical from their setup functions.
> 
> Will this still work?

At least, it still works now and still useful for this case. Actually, I
made this change as an alternative way of
https://www.spinics.net/lists/linux-clk/msg44836.html
because not all Aspeed BMC systems enable BCLK as a critical clock, so
it's for providing more flexible way of critical clock setting for
various hardware configurations.

If the function is deprecated and is going to be removed soon, would it
be acceptable if I add the 'critical-clock' parsing code into this
driver module instead of using the function?

Best Regards,

Jae

>>   		/* Special case: the USB port 1 clock (bit 14) is always
>>   		 * working the opposite way from the other ones.
>>   		 */
>> @@ -550,7 +553,7 @@ static int aspeed_clk_probe(struct platform_device *pdev)
>>   		hw = aspeed_clk_hw_register_gate(dev,
>>   				gd->name,
>>   				gd->parent_name,
>> -				gd->flags,
>> +				flags,
>>   				map,
>>   				gd->clock_idx,
>>   				gd->reset_idx,
> 
> 
> Kind regards,
> 
> Paul
> 
