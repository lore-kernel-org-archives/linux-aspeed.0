From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 25 Mar 2019 15:59:54 +0100
Subject: [PATCH v2 2/2] rtc: Add ASPEED RTC driver
In-Reply-To: <20190325133159.10653-3-joel@jms.id.au>
References: <20190325133159.10653-1-joel@jms.id.au>
 <20190325133159.10653-3-joel@jms.id.au>
Message-ID: <20190325145954.GM30105@piout.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

This seems mostly good to me.

On 26/03/2019 00:01:59+1030, Joel Stanley wrote:
> +	dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
> +			1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> +			tm->tm_hour, tm->tm_min, tm->tm_sec);
> +

We now have %ptR, could you use that?

> +	rtc->rtc_dev->ops = &aspeed_rtc_ops;
> +	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
> +	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
> +

I'm curious how many RTC have been properly designed, could you run
rtc-range?

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c

Thanks!

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
