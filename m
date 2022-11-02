From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 2 Nov 2022 06:54:43 +0000
Subject: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
In-Reply-To: <20221101131456.GA1310110@roeck-us.net>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
 <20221101131456.GA1310110@roeck-us.net>
Message-ID: <271C521D-8F20-4C86-B3DA-9C0AD74242D4@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Guenter,

On 2022/11/1, 9:15 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On Tue, Nov 01, 2022 at 05:51:56PM +0800, Billy Tsai wrote:
    > > +
    > > +	/* Restart the Tach channel to guarantee the value is fresh */
    > > +	aspeed_tach_ch_enable(priv, fan_tach_ch, false);
    > > +	aspeed_tach_ch_enable(priv, fan_tach_ch, true);

    > Is that really needed ? Doesn't the controller measure values continuously ?

Yes, the controller will measure values continuously by hardware. I will remove it. 
If the user want to get the fresh value, it should be done by the application layer
(e.g. read two times).

    > > +
    > > +	if (ret) {
    > > +		/* return 0 if we didn't get an answer because of timeout*/
    > > +		if (ret == -ETIMEDOUT)
    > > +			return 0;
    > > +		else
    > > +			return ret;

    > else after return is unnecessary, and why would a timeout be be ignored ?

When the user sets the correct fan information (i.e., min_rpm, max_rpm), the read
poll timeout will only occur if the tach pin does not get any signal (i.e. rpm=0).

    > > +	}
    > > +
    > > +	raw_data = val & TACH_ASPEED_VALUE_MASK;
    > > +	/*
    > > +	 * We need the mode to determine if the raw_data is double (from
    > > +	 * counting both edges).
    > > +	 */
    > > +	if (priv->tach_channel[fan_tach_ch].tach_edge == BOTH_EDGES)
    > > +		raw_data <<= 1;
    > > +
    > > +	tach_div = raw_data * (priv->tach_channel[fan_tach_ch].divisor) *
    > > +		   (priv->tach_channel[fan_tach_ch].pulse_pr);
    > > +
    > > +	clk_source = clk_get_rate(priv->clk);
    > > +	dev_dbg(priv->dev, "clk %ld, raw_data %d , tach_div %d\n", clk_source,
    > > +		raw_data, tach_div);
    > > +
    > > +	if (tach_div == 0)
    > > +		return -EDOM;

    > If the fan is off or not connected, would that return an error ?
    > If so, that would be inappropriate; it should return a speed
    > of 0 in that case.

It will be handled by the regmap_read_poll_timeout.

Thanks

Best Regards,
Billy Tsai

