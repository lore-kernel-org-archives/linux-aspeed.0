From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 8 Nov 2022 07:17:48 +0000
Subject: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <20221103143059.GB145042@roeck-us.net>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
 <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
 <20221103043034.GA2113834@roeck-us.net>
 <E9E92BC7-CB1A-487F-9E5D-2A403A01CB17@aspeedtech.com>
 <20221103143059.GB145042@roeck-us.net>
Message-ID: <4EC60594-E1F5-4F05-A9E6-3BDCFAE62A65@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 2022/11/3, 10:31 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On Thu, Nov 03, 2022 at 05:40:44AM +0000, Billy Tsai wrote:
    > > On 2022/11/3, 12:30 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:
    > > 
    > >     On Thu, Nov 03, 2022 at 03:52:59AM +0000, Billy Tsai wrote:
    > >     > > 
    > >     > > Can't I use a min/max RPM to let the driver know a reasonable timeout/polling period when
    > >     > > the driver is trying to get RPM?
    > >     > > Beacause that our tach controller have the falg to indicates the hardware detected the change
    > >     > > in the input signal. I need the proper timout to rule out slow RPMs.
    > > 
    > >     > If the chip measures the fan speed continuously, why would that ever be a
    > >     > problem, and why wait in the first place instead of just taking the most
    > >     > recent result ?
    > > 
    > >     > Pretty much every other driver is doing that, so I really don't understand
    > >     > why that would not work here.
    > > 
    > > When the fan speed drop from a very fast RPM to a very slow RPM. Especially when it is close to stopping.
    > > The most recent result will be no meaningful value. The slower RPM needs more time to sample it. E.g., If
    > > we want to measure the fan with 600 RPM, the controller needs at least 100ms. During this time period, we
    > > will always get the wrong value. So, our tach controller have the flag to avoid this problem:
    > > TACH_ASPEED_VALUE_UPDATE: tach value updated since last read
    > > This flag will be set when the controller detected the change of the signal and clear by read it.
    > > In order to use this flag, the controller needs the proper timeout based on minimum RPM to avoid waiting forever.
    > > 

    > I am not going to accept this patch as-is. If userspace wants to have
    > values accurate down to ms, this kind of approach is just wrong. Users
    > will have to live with the fact that measurements may be a bit (in the 
    > < 1 second range) out of date. Many older drivers even implement code
    > which avoids reading registers again for a second or longer. Older
    > temperature sensors may take several seconds to provide new readings.
    > That is not a reason to block userspace until a new value is available.
    > I do not see that as a problem. In my opinion it is much more of a
    > problem if the driver returns a completely bad value such as 0 or even
    > an error code because its software parameters did not match reality and
    > the driver didn't wait long enough for a new value. That would be _much_
    > worse than providing a value which is a few 100 ms out of date, and your
    > code is vulnerable to that problem.

    > Besides, for a fan to reduce its speed that quickly, it has to be manually
    > stopped. Normally fans take several seconds to stop if power is taken away
    > completely. Your code is adding a lot of complexity (and unnecessary
    > attributes) for no good reason.

Thanks for your detailed explanations.
I will remove the min and max RPMs and return the tach value directly without any polling or delay.

Best Regards,
Billy Tsai


