From: Zev Weiss <zev@bewilderbeest.net>
Date: Tue, 2 Nov 2021 17:30:40 -0700
Subject: [PATCH -next 0/4] Add LCLK control into Aspeed LPC sub drivers
In-Reply-To: <d2a18e3b-cb02-37b5-cad8-45c3e8ff3bb4@linux.intel.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <CACPK8XfBi+jY5ftLqsEVXHe01SQBNpTSwo+WtXN3=YUQnXACtw@mail.gmail.com>
 <YYHSHoELvKRI4Zh1@hatter.bewilderbeest.net>
 <d2a18e3b-cb02-37b5-cad8-45c3e8ff3bb4@linux.intel.com>
Message-ID: <YYHYMKDD7hz15ceR@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 02, 2021 at 05:17:30PM PDT, Jae Hyun Yoo wrote:
>Hi Zev,
>
>On 11/2/2021 5:04 PM, Zev Weiss wrote:
>>On Mon, Nov 01, 2021 at 04:36:38PM PDT, Joel Stanley wrote:
>>>On Mon, 1 Nov 2021 at 23:18, <jae.hyun.yoo@intel.com> wrote:
>>>>
>>>>From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>>
>>>>Hello all,
>>>>
>>>>This series is for appliying below fix to all Aspped LPC sub drivers.
>>>>https://lore.kernel.org/all/20201208091748.1920-1-wangzhiqiang.bj at bytedance.com/
>>>>
>>>>
>>>>An LPC sub driver can be enabled without using the lpc-ctrl driver or it
>>>>can be registered ahead of lpc-ctrl depends on each system 
>>>>configuration and
>>>>this difference introduces that LPC can be enabled without heart 
>>>>beating of
>>>>LCLK so it causes improper handling on host interrupts when the 
>>>>host sends
>>>>interrupts in that time frame. Then kernel eventually forcibly 
>>>>disables the
>>>>interrupt with dumping stack and printing a 'nobody cared this 
>>>>irq' message
>>>>out.
>>>>
>>>>To prevent this issue, all LPC sub drivers should enable LCLK 
>>>>individually
>>>>so this patch adds clock control logic into the remaining Aspeed LPC sub
>>>>drivers.
>>>
>>>Thanks for sending this out!
>>>
>>>This will resolve a few of the issues we have in the issue tracker:
>>>
>>>https://github.com/openbmc/linux/issues/210
>>>https://github.com/openbmc/linux/issues/130
>>>
>>>The patches look good to me. I think you've just missed Corey's PR for
>>>v5.16, but I will stick them in the openbmc tree once they've had a
>>>review.
>>>
>>
>>Hi Jae,
>>
>>I tried this series out on the same in-progress OpenBMC port from 
>>issue number 210 linked above and am still seeing problems (dmesg 
>>pasted below).
>>
>>I cherry-picked commit f9241fe8b9652 ("ARM: dts: aspeed: Add uart 
>>routing to device tree") from linux-next to allow the first patch to 
>>apply cleanly; is there anything else I might be missing that'd be 
>>needed to test the series properly?
>
>Looks like below dmesg shows an error from 'aspeed_lpc_snoop_probe'
>which this series doesn't touch. Do you have below fix in your code
>tree?
>
>https://lore.kernel.org/all/20201208091748.1920-1-wangzhiqiang.bj at bytedance.com/
>
>Thanks,
>Jae
>

Yes, I've got that patch (commit 3f94cf1558), and the accompanying dts 
update to add the clocks property to the lpc-snoop device (commit 
d050d049f8).

However, while there is an aspeed_lpc_snoop_probe() backtrace there, 
note that there's *also* one from aspeed_kcs_probe() further on 
(starting at timestamp 3.263306).


Zev

