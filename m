From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 29 Jun 2021 05:26:50 +0000
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
In-Reply-To: <43b0c30c-949a-8a6f-268f-c2a550fca30d@roeck-us.net>
References: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
 <20210624124428.GB1670703@roeck-us.net>
 <51093C5F-61E2-4155-9C9A-035E330AEA1E@aspeedtech.com>
 <43b0c30c-949a-8a6f-268f-c2a550fca30d@roeck-us.net>
Message-ID: <9CFDB695-1F7C-4B80-8AF9-A591C4D38813@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2021/6/28, 9:56 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On 6/24/21 8:35 PM, Billy Tsai wrote:
    >   > On 2021/6/24, 8:44 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:
    >   > 
    >   >      On Thu, Jun 24, 2021 at 11:58:21AM +0800, Billy Tsai wrote:
    >   >      >> The tach shouldn't use both edges to measure. When the tach input
    >   >      >> duty cycle isn't 50% the return value will inaccurate.
    >   >      >>
    >   >      > A tachometer doesn't have a duty cycle. A pwm has a duty cycle, but that
    >   >      > is completely independent of the pwm duty cycle used to set the fan speed.
    >   >      > So this patch does not really make sense with the above explanation.
    >   > 
    >   > The duty cycle means the waveform that reported from the fan tach pin not pwm signal.
    >   > 
    >   >      > The impact of this patch is likely that the reported fan speed is reduced
    >   >      > by 50%. It may well be that the driver currently reports twice the real fan
    >   >      > speed. I have no idea if that is the case, but if it is it should not be
    >   >      > conditional. The description above states "when the tach input cycle isn't
    >   >      > 50%", suggesting that this is conditional on some other configuration.
    >   >      > I don't know what that might be either.
    >   > 
    >   > According to the tach mode, our tach controller will sample the time of once conditional meet and translate it to tach value.
    >   > When the tach signal duty cycle isn't 50%, using both edges mode will get the tach value with error rate.
    >   > In addition, the current report value of both edges will twice the result which will enlarge the error rate.
    >   > Actually, the tach signal won't be a complete 50% duty cycle, so both edges mode isn't recommanded for the fan usage.
    >   > With rising-to-rising mode the skew time of tach signal will also effect the accuracy.
    >   > Thus, using the falling-to-falling mode is the better way for a fan tach monitor.
    >   > But for flexibility, I think using dts property to control the tach mode is better the user can change the mode to adapter the monitor device.
    >   > 

    >   Trying again, using my own words.

    >   A fan normally provides two short pulses per revolution. Those are short
    >   puleses, and one does not typically talk about "duty cycle" or "waveform"
    >   in this context. The driver currently counts both edges of those pulses.

Our tach controller will count how many tach clocks in those shot pulses.
In both edge mode the counting period only half of the pulse. Thus, it is more sensitive
to the signal quality of the shot pulse when using both edges mode.

    >   Assuming that a fan reports, say, 1,000 pulses per minute, the hardware
    >   would report a edle count of 2,000. This should translate into 500 RPM.
    >   I don't know if this is currently the case in the driver; if not, it would
    >   be a bug. Either case, the suggested change would reduce the pulse count
    >   reported by the hardware to 1,000. If we assume that the driver currently
    >   translates this correctly to 500 RPM, the suggested change would result
    >   in the driver reporting 250 RPM, which would be wrong.

    >   So there are two possibilities:
    >   1) The driver currently reports 1,000 RPM in this situation. This would be a bug
    >       which needs to get fixed.
    >   2) The driver currently correctly reports 500 RPM. In this case, the suggested
    >       patch would introduce a bug because the code is not adjusted for the reduced
    >       pulse count.

    >   The problem is that the patch does not address either of the situations above.
    >   In case 1), it should state that the code currently reports twice the real
    >   fan speed, and that the patch fixes that problem. In case 2), the patch should
    >   also fix the arithmetic used to calculate RPM from the pulse count.
    >   Either case, I disagree that this should be handled in devicetree. It has
    >   nothing to do with hardware description or configuration but is in the
    >   discretion of the driver author/implementer.

The driver doesn't have the two situations you describe, it already considers the different
sampling modes at the arithmetic. The patch is used to make users have the option to select
the mode not just fix it to the both edges mode.

    >   Guenter

