From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Thu, 10 Nov 2022 10:24:37 +0800
Subject: Log spam from aspeed-video driver
In-Reply-To: <CACPK8XfQhaG2pb6=0YL6J3ME2XLxuQdV37tTuoOX5-05c7pDnQ@mail.gmail.com>
References: <Y1dX9r9ybGjBrW0k@hatter.bewilderbeest.net>
 <CACPK8XfQhaG2pb6=0YL6J3ME2XLxuQdV37tTuoOX5-05c7pDnQ@mail.gmail.com>
Message-ID: <7860c838-a3cd-d4e5-43d0-fe504138e1ef@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Zev,

Thanks for your advice.

On 2022/11/10 ?? 07:54, Joel Stanley wrote:
> On Tue, 25 Oct 2022 at 03:29, Zev Weiss <zev@bewilderbeest.net> wrote:
>> Hi all,
>>
>> Since the recent update of the OpenBMC kernel to 6.0, I've been seeing a
>> lot of new log noise from aspeed-video driver when the host is powered
>> off after having been on:
>>
>>       [  335.526279] aspeed-video 1e700000.video: Timed out; first mode detect
>>       [  335.544172] aspeed-video 1e700000.video: No signal; don't start frame
>>       [  337.165555] aspeed-video 1e700000.video: Timed out; first mode detect
>>       [  337.186214] aspeed-video 1e700000.video: No signal; don't start frame
>>       [  338.815501] aspeed-video 1e700000.video: Timed out; first mode detect
>>       [  338.834008] aspeed-video 1e700000.video: No signal; don't start frame
>>
>> It just emits that pair of messages continuously, about every 1.6
>> seconds.
> Our current generation machines don't use the bmc kvm setup, so this
> hasn't seen much testing by IBM.
>
> I'd like to hear from aspeed. If this is a problem with the driver
> then it's something to look into. If it's log spam then we should put
> it back to a dbg call.
>
>> Looking through the commit history of the driver, it looks like that
>> stems from commit a3de90afe392 ("media: aspeed: use
>> v4l2_info/v4l2_warn/v4l2_dbg for log"), which converted a bunch of print
>> calls from dev_dbg() to various v4l2_*() calls.  Reverting to the old
>> 5.15 kernel (which didn't include that change), I found by enabling the
>> dev_dbg() prints via sysfs (and cranking up the console loglevel) that
>> the conditions triggering those messages have been happening all along,
>> I just hadn't been seeing them because the debug prints were disabled by
>> default.
>>
>> I should note that aside from the dmesg spam I don't see any functional
>> problems with the driver; obmc-ikvm works as expected.
>>
>> Was switching those dev_dbg() calls to v4l2_warn() instead of v4l2_dbg()
>> intentional?  Does this indicate some latent bug that should be fixed,
>> or should they just be converted to v4l2_dbg()?

vl42_warn was used to warn the user something unexpected happen. But 
since these

things can be corrected and won't affect the user expericen,? I will 
update a patch to use

v4l2_dbg rather than v4l2_warn.

>>
>>
>> Thanks,
>> Zev
>>
-- 
Best Regards
Jammy

