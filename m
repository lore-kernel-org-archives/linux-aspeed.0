From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 2 Nov 2022 21:30:34 -0700
Subject: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
 <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
Message-ID: <20221103043034.GA2113834@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 03, 2022 at 03:52:59AM +0000, Billy Tsai wrote:
> 
> Can't I use a min/max RPM to let the driver know a reasonable timeout/polling period when
> the driver is trying to get RPM?
> Beacause that our tach controller have the falg to indicates the hardware detected the change
> in the input signal. I need the proper timout to rule out slow RPMs.
> 

If the chip measures the fan speed continuously, why would that ever be a
problem, and why wait in the first place instead of just taking the most
recent result ?

Pretty much every other driver is doing that, so I really don't understand
why that would not work here.

Guenter
