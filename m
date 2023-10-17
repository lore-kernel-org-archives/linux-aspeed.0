From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 17 Oct 2023 20:15:33 +0100
Subject: [PATCH v1] iio: adc: aspeed: Support deglitch feature.
In-Reply-To: <SG2PR06MB33657B698EDFC3D6937997938BD6A@SG2PR06MB3365.apcprd06.prod.outlook.com>
References: <20230925081845.4147424-1-billy_tsai@aspeedtech.com>
	<20230930174501.039095da@jic23-huawei>
	<SG2PR06MB3365E89B1543B770AC2EE7E78BC5A@SG2PR06MB3365.apcprd06.prod.outlook.com>
	<20231002103940.00001dbd@Huawei.com>
	<SG2PR06MB336557EDAAE2950D192E40838BCBA@SG2PR06MB3365.apcprd06.prod.outlook.com>
	<20231005150753.38e79c20@jic23-huawei>
	<SG2PR06MB33657B698EDFC3D6937997938BD6A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Message-ID: <20231017201346.2f4f6b01@jic23-huawei>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 17 Oct 2023 11:10:54 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> > > > > > > Create event sysfs for applying the deglitch condition. When
> > > > > > > in_voltageY_thresh_rising_en/in_voltageY_thresh_falling_en is set to true,
> > > > > > > the driver will use the in_voltageY_thresh_rising_value and
> > > > > > > in_voltageY_thresh_falling_value as threshold values. If the ADC value
> > > > > > > falls outside this threshold, the driver will wait for the ADC sampling
> > > > > > > period and perform an additional read once to achieve the deglitching
> > > > > > > purpose.
> > > > > > >
> > > > > > > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> > > > >  
> > > > > > Hi Billy  
> > > > >  
> > > > > > This is pushing the meaning of the events interface too far.
> > > > > > You can't use it to hide a value you don't like from userspace.  
> > > > >  
> > > > > > If you can explain what the condition is that you are seeing
> > > > > > and what you need to prevent happening if it is seen that would help
> > > > > > us figure out if there is another way to do this.  
> > > > >  
> > > > > > Jonathan  
> > > > >
> > > > > Hi Jonathan,
> > > > >
> > > > > Currently, we are experiencing some voltage glitches while reading from our
> > > > > controller, but we do not wish to report these false alarms to the user space.
> > > > > Instead, we want to retry the operation as soon as possible. This is why the
> > > > > driver requires this patch to handle retries internally, rather than relying on user
> > > > > space which could introduce unpredictable timing for retrying the reading process.
> > > > > This software approach aims to minimize the possibility of false alarms as much as possible.  
> > >  
> > > > Thanks for the extra detail. Perhaps share more of that in the cover letter for v2.  
> > >
> > > Okay, I will incorporate more details into my commit message for v2.
> > >  
> > > > >
> > > > > If you have any suggestions or recommendations regarding this situation, please feel free to
> > > > > share them with me.  
> > >  
> > > > Why do you need userspace control for the thresholds?
> > > > Perhaps this is something that belongs in DT for a particular board design?  
> > >
> > > If the input voltage remains constant, these settings can be incorporated into the DTS properties for configuring the threshold. However, if the input voltage is subject to change, adding user-space control may offer more flexibility.  
> 
> > My concern is that it's an interface userspace probably won't know how to use, or
> > will misuse given this seems to be papering over bad hardware.  
> 
> > If there is a 'safe' value to put in DT I'd prefer to see that. I guess it might be per
> > channel thing to adjust for different expected voltage ranges?  
> 
> Yes, the voltage ranges should be adjusted based on each individual channel.
> I'm not entirely sure what you mean by the term 'safe' value. 
> Are you suggesting that a DTS property should be used to constrain the threshold ranges? Or someting else?
> From my point of view, I think misusing this feature will only increase the sampling period of the ADC values and decrease the sensitivity.
> As the name of this feature , it is primarily used to eliminate or mitigate glitches in readings.
> 
Note a good choice of wording from me.  I meant, for a given design (and hence DTS)
is there a reasonable value that will work for all instances of that design?

If there is it is a characteristic of the board design and should be in DT.
If there isn't, how do you calibrate it for individual devices?

Jonathan

> Thanks
> 
> 
> 

