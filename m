From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 9 Nov 2022 14:48:26 -0800
Subject: Log spam from aspeed-video driver
In-Reply-To: <Y1dX9r9ybGjBrW0k@hatter.bewilderbeest.net>
References: <Y1dX9r9ybGjBrW0k@hatter.bewilderbeest.net>
Message-ID: <Y2wuOlQRBobRonj5@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 24, 2022 at 08:28:56PM PDT, Zev Weiss wrote:
>Hi all,
>
>Since the recent update of the OpenBMC kernel to 6.0, I've been seeing 
>a lot of new log noise from aspeed-video driver when the host is 
>powered off after having been on:
>
>    [  335.526279] aspeed-video 1e700000.video: Timed out; first mode detect
>    [  335.544172] aspeed-video 1e700000.video: No signal; don't start frame
>    [  337.165555] aspeed-video 1e700000.video: Timed out; first mode detect
>    [  337.186214] aspeed-video 1e700000.video: No signal; don't start frame
>    [  338.815501] aspeed-video 1e700000.video: Timed out; first mode detect
>    [  338.834008] aspeed-video 1e700000.video: No signal; don't start frame
>
>It just emits that pair of messages continuously, about every 1.6 
>seconds.
>
>Looking through the commit history of the driver, it looks like that 
>stems from commit a3de90afe392 ("media: aspeed: use 
>v4l2_info/v4l2_warn/v4l2_dbg for log"), which converted a bunch of 
>print calls from dev_dbg() to various v4l2_*() calls.  Reverting to 
>the old 5.15 kernel (which didn't include that change), I found by 
>enabling the dev_dbg() prints via sysfs (and cranking up the console 
>loglevel) that the conditions triggering those messages have been 
>happening all along, I just hadn't been seeing them because the debug 
>prints were disabled by default.
>
>I should note that aside from the dmesg spam I don't see any 
>functional problems with the driver; obmc-ikvm works as expected.
>
>Was switching those dev_dbg() calls to v4l2_warn() instead of 
>v4l2_dbg() intentional?  Does this indicate some latent bug that 
>should be fixed, or should they just be converted to v4l2_dbg()?
>

Ping -- Jammy, any input on this?


Thanks,
Zev

