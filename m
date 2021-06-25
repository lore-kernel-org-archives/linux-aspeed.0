From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 25 Jun 2021 03:35:43 +0000
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
In-Reply-To: <20210624124428.GB1670703@roeck-us.net>
References: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
 <20210624124428.GB1670703@roeck-us.net>
Message-ID: <51093C5F-61E2-4155-9C9A-035E330AEA1E@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2021/6/24, 8:44 PM, "Guenter Roeck" <groeck7 at gmail.com on behalf of linux@roeck-us.net> wrote:

    On Thu, Jun 24, 2021 at 11:58:21AM +0800, Billy Tsai wrote:
    >> The tach shouldn't use both edges to measure. When the tach input
    >> duty cycle isn't 50% the return value will inaccurate.
    >> 
    > A tachometer doesn't have a duty cycle. A pwm has a duty cycle, but that
    > is completely independent of the pwm duty cycle used to set the fan speed.
    > So this patch does not really make sense with the above explanation.

The duty cycle means the waveform that reported from the fan tach pin not pwm signal.

    > The impact of this patch is likely that the reported fan speed is reduced
    > by 50%. It may well be that the driver currently reports twice the real fan
    > speed. I have no idea if that is the case, but if it is it should not be
    > conditional. The description above states "when the tach input cycle isn't
    > 50%", suggesting that this is conditional on some other configuration.
    > I don't know what that might be either.

According to the tach mode, our tach controller will sample the time of once conditional meet and translate it to tach value.
When the tach signal duty cycle isn't 50%, using both edges mode will get the tach value with error rate.
In addition, the current report value of both edges will twice the result which will enlarge the error rate.
Actually, the tach signal won't be a complete 50% duty cycle, so both edges mode isn't recommanded for the fan usage.
With rising-to-rising mode the skew time of tach signal will also effect the accuracy.
Thus, using the falling-to-falling mode is the better way for a fan tach monitor.
But for flexibility, I think using dts property to control the tach mode is better the user can change the mode to adapter the monitor device.

    > So, sorry, I can't accept this patch without a more detailed and accurate
    > description and explanation why it is needed.

    >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >> ---
    >>  drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
    >>  1 file changed, 1 insertion(+), 1 deletion(-)
    >> 
    >> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
    >> index 3d8239fd66ed..0a70a0e22acf 100644
    >> --- a/drivers/hwmon/aspeed-pwm-tacho.c
    >> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
    >> @@ -158,7 +158,7 @@
    >>   * 10: both
    >>   * 11: reserved.
    >>   */
    >> -#define M_TACH_MODE 0x02 /* 10b */
    >> +#define M_TACH_MODE 0x00 /* 10b */

    > That comment is now wrong.

    > Guenter

    >>  #define M_TACH_UNIT 0x0210
    >>  #define INIT_FAN_CTRL 0xFF
    >>  
    >> -- 
    >> 2.25.1
    >>

