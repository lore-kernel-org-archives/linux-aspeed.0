From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 3 Nov 2022 03:52:59 +0000
Subject: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <20221102170138.GA2913353@roeck-us.net>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
 <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
 <20221102170138.GA2913353@roeck-us.net>
Message-ID: <F1166366-99CC-4A36-A0A2-4965C787E60B@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2022/11/3, 1:01 AM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On Wed, Nov 02, 2022 at 06:54:43AM +0000, Billy Tsai wrote:
    >   > Hi Guenter,
    >   > 
    >   > On 2022/11/1, 9:15 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:
    >   > 
    >   >     On Tue, Nov 01, 2022 at 05:51:56PM +0800, Billy Tsai wrote:
    >   >     > > +
    >   >     > > +	/* Restart the Tach channel to guarantee the value is fresh */
    >   >     > > +	aspeed_tach_ch_enable(priv, fan_tach_ch, false);
    >   >     > > +	aspeed_tach_ch_enable(priv, fan_tach_ch, true);
    >   > 
    >   >     > Is that really needed ? Doesn't the controller measure values continuously ?
    >   > 
    >   > Yes, the controller will measure values continuously by hardware. I will remove it. 
    >   > If the user want to get the fresh value, it should be done by the application layer
    >   > (e.g. read two times).
    >   > 
    >   >     > > +
    >   >     > > +	if (ret) {
    >   >     > > +		/* return 0 if we didn't get an answer because of timeout*/
    >   >     > > +		if (ret == -ETIMEDOUT)
    >   >     > > +			return 0;
    >   >     > > +		else
    >   >     > > +			return ret;
    >   > 
    >   >     > else after return is unnecessary, and why would a timeout be be ignored ?
    >   > 
    >   > When the user sets the correct fan information (i.e., min_rpm, max_rpm), the read
    >   > poll timeout will only occur if the tach pin does not get any signal (i.e. rpm=0).
    >   > 

    >   In that case it would be appropriate to return -ETIMEDOUT to the caller.

    >   Anyway, that should really not happen. Sysfs attributes such as minimum/maximum fan
    >   speed, the number of fan pulses per revolution, or a divider value should only exist
    >   if the chip needs that information, for example to report a fan error/alarm if the
    >   measured speed is out of range or if the chip actually calculates RPM and provides
    >   the result to the driver. Those values should not be necessary (and should not be
    >   used) to calculate some timeout.

Can't I use a min/max RPM to let the driver know a reasonable timeout/polling period when
the driver is trying to get RPM?
Beacause that our tach controller have the falg to indicates the hardware detected the change
in the input signal. I need the proper timout to rule out slow RPMs.

Thanks

Best Regards,
Billy Tsai




